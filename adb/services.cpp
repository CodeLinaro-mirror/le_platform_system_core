/*
 * Copyright (C) 2007 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define TRACE_TAG SERVICES

#include "sysdeps.h"

#include <errno.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef _WIN32
#include <netdb.h>
#include <netinet/in.h>
#include <sys/ioctl.h>
#include <unistd.h>
#endif

#include <base/file.h>
#include <base/stringprintf.h>
#include <base/strings.h>

#if !ADB_HOST
#include "cutils/android_reboot.h"
#include "cutils/properties.h"
#endif

#include "adb.h"
#include "adb_io.h"
#include "file_sync_service.h"
#include "remount_service.h"
#include "services.h"
#include "shell_service.h"
#include "transport.h"
#include "log/log.h"

struct stinfo {
    void (*func)(int fd, void *cookie);
    int fd;
    void *cookie;
};

static void service_bootstrap_func(void* x) {
    stinfo* sti = reinterpret_cast<stinfo*>(x);
    adb_thread_setname(android::base::StringPrintf("service %d", sti->fd));
    sti->func(sti->fd, sti->cookie);
    free(sti);
}

#if !ADB_HOST

void restart_root_service(int fd, void *cookie) {
#if defined(ALLOW_ADBD_ROOT)
    int f;
#endif
    if (getuid() == 0) {
        WriteFdExactly(fd, "adbd is already running as root\n");
        adb_close(fd);
    } else {
#if defined(ALLOW_ADBD_ROOT)
    int retry = 5;
    while(retry--){
        f = unix_open("/tmp/.adb.root", O_RDWR | O_CLOEXEC);
        if ( f == -1 && errno == ENOENT) {
            ALOGI("%s: unix_open failed,errorno = %d errstr= %s\n", __func__,errno, strerror(errno));
            f = unix_open("/tmp/.adb.root", O_WRONLY | O_CREAT, 0666);
        }
        if (f > 0) {
            if (unix_write(f, ROOT_MAGIC, ROOT_MAGIC_SIZE) == -1) {
                D("Failed to write to /tmp/.adb.root");
                unix_close(f);
                adb_close(fd);
                return;
            }
            unix_close(f);
            WriteFdExactly(fd, "restarting adbd as root\n");
            break;
        }
        else {
            ALOGI("%s: unix_open failed, errorno = %d errstr= %s\n", __func__,errno, strerror(errno));
            usleep(100000);

        }
    }
#else
        WriteFdExactly(fd, "adbd cannot run as root in production builds\n");
#endif
        adb_close(fd);
    }
}

void restart_unroot_service(int fd, void *cookie) {
    if (getuid() != 0) {
        WriteFdExactly(fd, "adbd not running as root\n");
    }
#if defined(ALLOW_ADBD_ROOT)
    else {
        int f = unix_open("/tmp/.adb.root", O_RDWR | O_CLOEXEC);
        if (f > 0) {
            char buf[ROOT_MAGIC_SIZE];
            if (unix_read(f, buf, sizeof(buf)) != -1) {
                if (strncmp(buf, ROOT_MAGIC,ROOT_MAGIC_SIZE) == 0) {
                   adb_lseek(f, 0 , SEEK_SET);
                   if (unix_write(f, "#NOROOT#", 8) == -1) {
                       D("failed to update /tmp/.adb.root");
                       unix_close(f);
                       adb_close(fd);
                       return;
                   }
                   WriteFdExactly(fd, "restarting adbd as non root\n");
                }
            }
        }
        unix_close(f);
    }
#endif
    adb_close(fd);
}

void restart_tcp_service(int fd, void *cookie) {
    int port = (int) (uintptr_t) cookie;
    if (port <= 0) {
        WriteFdFmt(fd, "invalid port %d\n", port);
        adb_close(fd);
        return;
    }

    char value[PROPERTY_VALUE_MAX];
    snprintf(value, sizeof(value), "%d", port);
    property_set("service.adb.tcp.port", value);
    WriteFdFmt(fd, "restarting in TCP mode port: %d\n", port);
    adb_close(fd);
}

void restart_usb_service(int fd, void *cookie) {
    property_set("service.adb.tcp.port", "0");
    WriteFdExactly(fd, "restarting in USB mode\n");
    adb_close(fd);
}

static bool reboot_service_impl(int fd, const char* arg) {
    const char* reboot_arg = arg;
    bool auto_reboot = false;

    if (strcmp(reboot_arg, "sideload-auto-reboot") == 0) {
        auto_reboot = true;
        reboot_arg = "sideload";
    }

    // It reboots into sideload mode by setting "--sideload" or "--sideload_auto_reboot"
    // in the command file.
    if (strcmp(reboot_arg, "sideload") == 0) {
        if (getuid() != 0) {
            WriteFdExactly(fd, "'adb root' is required for 'adb reboot sideload'.\n");
            return false;
        }

        const char* const recovery_dir = "/cache/recovery";
        const char* const command_file = "/cache/recovery/command";
        // Ensure /cache/recovery exists.
        if (adb_mkdir(recovery_dir, 0770) == -1 && errno != EEXIST) {
            D("Failed to create directory '%s': %s", recovery_dir, strerror(errno));
            return false;
        }

        bool write_status = android::base::WriteStringToFile(
                auto_reboot ? "--sideload_auto_reboot" : "--sideload", command_file);
        if (!write_status) {
            return false;
        }

        reboot_arg = "recovery";
    }

    sync();

    char property_val[PROPERTY_VALUE_MAX];
    int ret = snprintf(property_val, sizeof(property_val), "reboot,%s", reboot_arg);
    if (ret >= static_cast<int>(sizeof(property_val))) {
        WriteFdFmt(fd, "reboot string too long: %d\n", ret);
        return false;
    }

// Call android_reboot instead of passing args to init.
#if ADB_REBOOT_ENABLED
    ret = android_reboot(ANDROID_RB_RESTART2, 0, arg);
#else
    ret = property_set(ANDROID_RB_PROPERTY, property_val);
    if (ret < 0) {
        WriteFdFmt(fd, "reboot failed: %d\n", ret);
        return false;
    }
#endif

    return true;
}

void reboot_service(int fd, void* arg)
{
    if (reboot_service_impl(fd, static_cast<const char*>(arg))) {
        // Don't return early. Give the reboot command time to take effect
        // to avoid messing up scripts which do "adb reboot && adb wait-for-device"
        while (true) {
            pause();
        }
    }

    free(arg);
    adb_close(fd);
}

void reverse_service(int fd, void* arg)
{
    const char* command = reinterpret_cast<const char*>(arg);

    if (handle_forward_request(command, kTransportAny, NULL, fd) < 0) {
        SendFail(fd, "not a reverse forwarding command");
    }
    free(arg);
    adb_close(fd);
}

// Shell service string can look like:
//   shell[,arg1,arg2,...]:[command]
static int ShellService(const std::string& args, const atransport* transport) {
    size_t delimiter_index = args.find(':');
    if (delimiter_index == std::string::npos) {
        LOG(ERROR) << "No ':' found in shell service arguments: " << args;
        return -1;
    }

    const std::string service_args = args.substr(0, delimiter_index);
    const std::string command = args.substr(delimiter_index + 1);

    // Defaults:
    //   PTY for interactive, raw for non-interactive.
    //   No protocol.
    //   $TERM set to "dumb".
    SubprocessType type(command.empty() ? SubprocessType::kPty
                                        : SubprocessType::kRaw);
    SubprocessProtocol protocol = SubprocessProtocol::kNone;
    std::string terminal_type = "dumb";

    for (const std::string& arg : android::base::Split(service_args, ",")) {
        if (arg == kShellServiceArgRaw) {
            type = SubprocessType::kRaw;
        } else if (arg == kShellServiceArgPty) {
            type = SubprocessType::kPty;
        } else if (arg == kShellServiceArgShellProtocol) {
            protocol = SubprocessProtocol::kShell;
        } else if (android::base::StartsWith(arg, "TERM=")) {
            terminal_type = arg.substr(5);
        } else if (!arg.empty()) {
            // This is not an error to allow for future expansion.
            LOG(WARNING) << "Ignoring unknown shell service argument: " << arg;
        }
    }

    return StartSubprocess(command.c_str(), terminal_type.c_str(), type, protocol);
}

#endif  // !ADB_HOST

static int create_service_thread(void (*func)(int, void *), void *cookie)
{
    int s[2];
    if (adb_socketpair(s)) {
        printf("cannot create service socket pair\n");
        return -1;
    }
    D("socketpair: (%d,%d)", s[0], s[1]);

    stinfo* sti = reinterpret_cast<stinfo*>(malloc(sizeof(stinfo)));
    if (sti == nullptr) {
        fatal("cannot allocate stinfo");
    }
    sti->func = func;
    sti->cookie = cookie;
    sti->fd = s[1];

    if (!adb_thread_create(service_bootstrap_func, sti)) {
        free(sti);
        adb_close(s[0]);
        adb_close(s[1]);
        printf("cannot create service thread\n");
        return -1;
    }

    D("service thread started, %d:%d",s[0], s[1]);
    return s[0];
}

int service_to_fd(const char* name, const atransport* transport) {
    int ret = -1;

    if(!strncmp(name, "tcp:", 4)) {
        int port = atoi(name + 4);
        name = strchr(name + 4, ':');
        if(name == 0) {
            ret = socket_loopback_client(port, SOCK_STREAM);
            if (ret >= 0)
                disable_tcp_nagle(ret);
        } else {
#if ADB_HOST
            ret = socket_network_client(name + 1, port, SOCK_STREAM);
#else
            return -1;
#endif
        }
#ifndef HAVE_WINSOCK   /* winsock doesn't implement unix domain sockets */
    } else if(!strncmp(name, "local:", 6)) {
        ret = socket_local_client(name + 6,
                ANDROID_SOCKET_NAMESPACE_RESERVED, SOCK_STREAM);
    } else if(!strncmp(name, "localreserved:", 14)) {
        ret = socket_local_client(name + 14,
                ANDROID_SOCKET_NAMESPACE_RESERVED, SOCK_STREAM);
    } else if(!strncmp(name, "localabstract:", 14)) {
        ret = socket_local_client(name + 14,
                ANDROID_SOCKET_NAMESPACE_ABSTRACT, SOCK_STREAM);
    } else if(!strncmp(name, "localfilesystem:", 16)) {
        ret = socket_local_client(name + 16,
                ANDROID_SOCKET_NAMESPACE_FILESYSTEM, SOCK_STREAM);
#endif
#if !ADB_HOST
    } else if(!strncmp("dev:", name, 4)) {
        ret = unix_open(name + 4, O_RDWR | O_CLOEXEC);
    } else if(!strncmp(name, "framebuffer:", 12)) {
        ret = create_service_thread(framebuffer_service, 0);
    } else if (!strncmp(name, "jdwp:", 5)) {
        ret = create_jdwp_connection_fd(atoi(name+5));
    } else if(!strncmp(name, "shell", 5)) {
        ret = ShellService(name + 5, transport);
    } else if(!strncmp(name, "exec:", 5)) {
        ret = StartSubprocess(name + 5, nullptr, SubprocessType::kRaw, SubprocessProtocol::kNone);
    } else if(!strncmp(name, "sync:", 5)) {
        ret = create_service_thread(file_sync_service, NULL);
    } else if(!strncmp(name, "remount:", 8)) {
        ret = create_service_thread(remount_service, NULL);
    } else if(!strncmp(name, "reboot:", 7)) {
        void* arg = strdup(name + 7);
        if (arg == NULL) return -1;
        ret = create_service_thread(reboot_service, arg);
    } else if(!strncmp(name, "root:", 5)) {
        ret = create_service_thread(restart_root_service, NULL);
    } else if(!strncmp(name, "unroot:", 7)) {
        ret = create_service_thread(restart_unroot_service, NULL);
    } else if(!strncmp(name, "backup:", 7)) {
        ret = StartSubprocess(android::base::StringPrintf("/system/bin/bu backup %s",
                                                          (name + 7)).c_str(),
                              nullptr, SubprocessType::kRaw, SubprocessProtocol::kNone);
    } else if(!strncmp(name, "restore:", 8)) {
        ret = StartSubprocess("/system/bin/bu restore", nullptr, SubprocessType::kRaw,
                              SubprocessProtocol::kNone);
    } else if(!strncmp(name, "tcpip:", 6)) {
        int port;
        if (sscanf(name + 6, "%d", &port) != 1) {
            return -1;
        }
        ret = create_service_thread(restart_tcp_service, (void *) (uintptr_t) port);
    } else if(!strncmp(name, "usb:", 4)) {
        ret = create_service_thread(restart_usb_service, NULL);
    } else if (!strncmp(name, "reverse:", 8)) {
        char* cookie = strdup(name + 8);
        if (cookie == NULL) {
            ret = -1;
        } else {
            ret = create_service_thread(reverse_service, cookie);
            if (ret < 0) {
                free(cookie);
            }
        }
    } else if(!strncmp(name, "disable-verity:", 15)) {
        ret = create_service_thread(set_verity_enabled_state_service_le, (void*)0);
    } else if(!strncmp(name, "enable-verity:", 15)) {
        ret = create_service_thread(set_verity_enabled_state_service_le, (void*)1);
#endif
    }
    if (ret >= 0) {
        close_on_exec(ret);
    }
    return ret;
}

#if ADB_HOST
struct state_info {
    TransportType transport_type;
    char* serial;
    ConnectionState state;
};

static void wait_for_state(int fd, void* cookie)
{
    state_info* sinfo = reinterpret_cast<state_info*>(cookie);

    D("wait_for_state %d", sinfo->state);

    std::string error_msg = "unknown error";
    atransport* t = acquire_one_transport(sinfo->state, sinfo->transport_type, sinfo->serial,
                                          &error_msg);
    if (t != 0) {
        SendOkay(fd);
    } else {
        SendFail(fd, error_msg);
    }

    if (sinfo->serial)
        free(sinfo->serial);
    free(sinfo);
    adb_close(fd);
    D("wait_for_state is done");
}

static void connect_device(const std::string& host, std::string* response) {
    if (host.empty()) {
        *response = "empty host name";
        return;
    }

    std::vector<std::string> pieces = android::base::Split(host, ":");
    const std::string& hostname = pieces[0];

    int port = DEFAULT_ADB_LOCAL_TRANSPORT_PORT;
    if (pieces.size() > 1) {
        if (sscanf(pieces[1].c_str(), "%d", &port) != 1) {
            *response = android::base::StringPrintf("bad port number %s", pieces[1].c_str());
            return;
        }
    }

    // This may look like we're putting 'host' back together,
    // but we're actually inserting the default port if necessary.
    std::string serial = android::base::StringPrintf("%s:%d", hostname.c_str(), port);

    int fd = socket_network_client_timeout(hostname.c_str(), port, SOCK_STREAM, 10);
    if (fd < 0) {
        *response = android::base::StringPrintf("unable to connect to %s:%d",
                                                hostname.c_str(), port);
        return;
    }

    D("client: connected on remote on fd %d", fd);
    close_on_exec(fd);
    disable_tcp_nagle(fd);

    int ret = register_socket_transport(fd, serial.c_str(), port, 0);
    if (ret < 0) {
        adb_close(fd);
        *response = android::base::StringPrintf("already connected to %s", serial.c_str());
    } else {
        *response = android::base::StringPrintf("connected to %s", serial.c_str());
    }
}

void connect_emulator(const std::string& port_spec, std::string* response) {
    std::vector<std::string> pieces = android::base::Split(port_spec, ",");
    if (pieces.size() != 2) {
        *response = android::base::StringPrintf("unable to parse '%s' as <console port>,<adb port>",
                                                port_spec.c_str());
        return;
    }

    int console_port = strtol(pieces[0].c_str(), NULL, 0);
    int adb_port = strtol(pieces[1].c_str(), NULL, 0);
    if (console_port <= 0 || adb_port <= 0) {
        *response = android::base::StringPrintf("Invalid port numbers: %s", port_spec.c_str());
        return;
    }

    // Check if the emulator is already known.
    // Note: There's a small but harmless race condition here: An emulator not
    // present just yet could be registered by another invocation right
    // after doing this check here. However, local_connect protects
    // against double-registration too. From here, a better error message
    // can be produced. In the case of the race condition, the very specific
    // error message won't be shown, but the data doesn't get corrupted.
    atransport* known_emulator = find_emulator_transport_by_adb_port(adb_port);
    if (known_emulator != nullptr) {
        *response = android::base::StringPrintf("Emulator already registered on port %d", adb_port);
        return;
    }

    // Check if more emulators can be registered. Similar unproblematic
    // race condition as above.
    int candidate_slot = get_available_local_transport_index();
    if (candidate_slot < 0) {
        *response = "Cannot accept more emulators";
        return;
    }

    // Preconditions met, try to connect to the emulator.
    if (!local_connect_arbitrary_ports(console_port, adb_port)) {
        *response = android::base::StringPrintf("Connected to emulator on ports %d,%d",
                                                console_port, adb_port);
    } else {
        *response = android::base::StringPrintf("Could not connect to emulator on ports %d,%d",
                                                console_port, adb_port);
    }
}

static void connect_service(int fd, void* cookie)
{
    char *host = reinterpret_cast<char*>(cookie);

    std::string response;
    if (!strncmp(host, "emu:", 4)) {
        connect_emulator(host + 4, &response);
    } else {
        connect_device(host, &response);
    }

    // Send response for emulator and device
    SendProtocolString(fd, response);
    adb_close(fd);
}
#endif

#if ADB_HOST
asocket* host_service_to_socket(const char* name, const char* serial) {
    if (!strcmp(name,"track-devices")) {
        return create_device_tracker();
    } else if (!strncmp(name, "wait-for-", strlen("wait-for-"))) {
        auto sinfo = reinterpret_cast<state_info*>(malloc(sizeof(state_info)));
        if (sinfo == nullptr) {
            fprintf(stderr, "couldn't allocate state_info: %s", strerror(errno));
            return NULL;
        }

        if (serial)
            sinfo->serial = strdup(serial);
        else
            sinfo->serial = NULL;

        name += strlen("wait-for-");

        if (!strncmp(name, "local", strlen("local"))) {
            sinfo->transport_type = kTransportLocal;
            sinfo->state = kCsDevice;
        } else if (!strncmp(name, "usb", strlen("usb"))) {
            sinfo->transport_type = kTransportUsb;
            sinfo->state = kCsDevice;
        } else if (!strncmp(name, "any", strlen("any"))) {
            sinfo->transport_type = kTransportAny;
            sinfo->state = kCsDevice;
        } else {
            free(sinfo);
            return NULL;
        }

        int fd = create_service_thread(wait_for_state, sinfo);
        return create_local_socket(fd);
    } else if (!strncmp(name, "connect:", 8)) {
        const char *host = name + 8;
        int fd = create_service_thread(connect_service, (void *)host);
        return create_local_socket(fd);
    }
    return NULL;
}
#endif /* ADB_HOST */
