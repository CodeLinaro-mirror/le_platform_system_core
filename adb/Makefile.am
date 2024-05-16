adb_sources := adb.cpp
adb_sources += adb_auth.cpp
adb_sources += adb_io.cpp
adb_sources += adb_listeners.cpp
adb_sources += adb_utils.cpp
adb_sources += sockets.cpp
adb_sources += transport.cpp
adb_sources += transport_local.cpp
adb_sources += transport_usb.cpp

adb_linux_sources := fdevent.cpp
adb_linux_sources += get_my_path_linux.cpp
adb_linux_sources += usb_linux.cpp

adb_version := $(shell git -C $(top_srcdir) rev-parse --short=12 HEAD 2>/dev/null)-android

# Device daemon and lib.
# =========================================================
if BUILD_DEVICE
# Build libadbd.so
lib_LTLIBRARIES := libadbd.la

libadbd_la_SOURCES := $(adb_sources)
libadbd_la_SOURCES += adb_auth_client.cpp
libadbd_la_SOURCES += fdevent.cpp
libadbd_la_SOURCES += jdwp_service.cpp
libadbd_la_SOURCES += usb_linux_client.cpp
#libadbd_la_SOURCES += qemu_tracing.cpp

libadbd_la_CPPFLAGS := -Wall -Wno-unused-parameter
libadbd_la_CPPFLAGS += -Wno-deprecated-declarations
libadbd_la_CPPFLAGS += -std=c++14 -fpermissive
if USE_GLIB
libadbd_la_CPPFLAGS += -DUSE_GLIB -Dstrlcat=g_strlcat @GLIB_CFLAGS@
endif
libadbd_la_CPPFLAGS += -DADB_HOST=0
libadbd_la_CPPFLAGS += -DADB_REVISION='"$(adb_version)"'
libadbd_la_CPPFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
libadbd_la_CPPFLAGS +=  @LIBFS_MGR_CFLAGS@

libadbd_la_LDFLAGS  := -lresolv
libadbd_la_LDFLAGS  += @LIBFS_MGR_LIBS@ @LIBEXT4_UTILS_LIBS@ @LIBMINCRYPT_LIBS@ @LIBBASE_LIBS@ @LIBLOG_LIBS@ @LIBCUTILS_LIBS@
if SELINUX_ENABLE
libadbd_la_LDFLAGS  += @LIBSELINUX_LIBS@
libadbd_la_CPPFLAGS += -DSELINUX_IS_ENABLE
endif

# Build adb daemon
root_sbindir       := "/usr/sbin"
root_sbin_PROGRAMS := adbd

adbd_SOURCES  := adb_main.cpp
adbd_SOURCES  += services.cpp
adbd_SOURCES  += file_sync_service.cpp
adbd_SOURCES  += framebuffer_service.cpp
adbd_SOURCES  += remount_service.cpp
adbd_SOURCES  += set_verity_enable_state_service.cpp

adbd_CPPFLAGS := -I$(top_srcdir)
adbd_CPPFLAGS += @LIBFS_MGR_CFLAGS@ @LIBBASE_CFLAGS@ @LIBEXT4_UTILS_CFLAGS@
adbd_CPPFLAGS += -I@mkbootimg_incdir@
if USE_GLIB
adbd_CPPFLAGS += $(GLIB_CFLAGS) -Dstrlcat=g_strlcat -Dstrlcpy=g_strlcpy -include glib.h
endif
adbd_CPPFLAGS += -Wall -Wno-unused-parameter
adbd_CPPFLAGS += -Wno-deprecated-declarations
adbd_CPPFLAGS += -std=c++14 -fpermissive
adbd_CPPFLAGS += -D_GNU_SOURCE
adbd_CPPFLAGS += -DADB_HOST=0
adbd_CPPFLAGS += -DADB_REVISION='"$(adb_version)"'
adbd_CPPFLAGS += -DALLOW_ADBD_NO_AUTH=1
adbd_CPPFLAGS += -DSYSTEM_SIZE=@SYSTEM_SIZE@
adbd_CPPFLAGS += -DFEC_SIZE=@FEC_SIZE@
adbd_CPPFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64

if ADB_ROOT
adbd_CPPFLAGS += -DALLOW_ADBD_ROOT=1
endif
adbd_CPPFLAGS += -DADB_REBOOT_ENABLED=1
adbd_CPPFLAGS += -DALLOW_ADBD_DISABLE_VERITY=1

if USING_SYSTEM_PROPERTIES
adbd_CPPFLAGS += -DUSING_SYSTEM_PROPERTIES
endif

if ADB_VERITY
adbd_CPPFLAGS += -DADB_VERITY=1
endif

if ADB_AVB20
adbd_CPPFLAGS += -DADB_AVB20=1
endif
adbd_LDADD   := libadbd.la
adbd_LDFLAGS := -lcutils -lresolv -lmincrypt -lbase

if SELINUX_ENABLE
adbd_LDFLAGS  += -lselinux
adbd_CPPFLAGS += -DSELINUX_IS_ENABLE
adbd_CPPFLAGS += @LIBSELINUX_CFLAGS@
endif

if USE_GLIB
adbd_CPPFLAGS += -DUSE_GLIB -Dstrlcat=g_strlcat @GLIB_CFLAGS@
adbd_LDFLAGS += @GLIB_LIBS@
endif

if USING_SYSTEM_PROPERTIES
adbd_service_file = adbd.service
else
adbd_service_file = no_sysprop_adbd.service
endif

# Install init files for adbd. install-data-hook runs after other data is installed.
install-data-hook:
if USING_SYSTEM_PROPERTIES
	$(INSTALL) -m 0755 $(top_srcdir)/launch_adbd -D $(DESTDIR)$(sysconfdir)/launch_adbd
	$(INSTALL_DATA) -b /dev/null $(DESTDIR)$(sysconfdir)/adb_devid
endif # USING_SYSTEM_PROPERTIES
if USE_SYSTEMD
	$(MKDIR_P) $(DESTDIR)$(systemd_system_unitdir)
	$(INSTALL_DATA) $(top_srcdir)/$(adbd_service_file) \
                $(DESTDIR)$(systemd_system_unitdir)/adbd.service
if USING_SYSTEM_PROPERTIES
	$(INSTALL) -m 0750 $(top_srcdir)/start_adbd -D $(DESTDIR)$(sysconfdir)/initscripts/adbd
endif # USING_SYSTEM_PROPERTIES
	$(MKDIR_P) $(DESTDIR)$(systemd_system_unitdir)/multi-user.target.wants/
	pushd $(DESTDIR)$(systemd_system_unitdir) && \
                $(LN_S) -r adbd.service multi-user.target.wants/adbd.service && \
                popd
if !USING_SYSTEM_PROPERTIES
	$(MKDIR_P) $(DESTDIR)/usr/lib/tmpfiles.d
	$(INSTALL) -m 0640 $(top_srcdir)/no_sysprop_tmpfile.conf $(DESTDIR)/usr/lib/tmpfiles.d/adbd.conf
endif # !USING_SYSTEM_PROPERTIES
endif # USE_SYSTEMD
endif # BUILD_DEVICE

# adb host tool for linux
# =========================================================
if BUILD_HOST
# Build libadb
lib_LTLIBRARIES := libadb.la

libadb_la_SOURCES := $(adb_sources) $(adb_linux_sources)
libadb_la_SOURCES += adb_auth_host.cpp

libadbd_la_CPPFLAGS := -I$(top_srcdir)
libadbd_la_CPPFLAGS += -Wall -Wno-unused-parameter
libadbd_la_CPPFLAGS += -std=c++14 -fpermissive
libadbd_la_CPPFLAGS += -DADB_HOST
libadbd_la_CPPFLAGS += -DADB_REVISION='"$(adb_version)"'
libadbd_la_CPPFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
libadbd_la_CPPFLAGS += @LIBFS_MGR_CFLAGS@
libadbd_la_LDFLAGS   = -lbase

# Build adb for linux
#bin_PROGRAMS = adb

endif
