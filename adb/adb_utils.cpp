/*
 * Copyright (C) 2015 The Android Open Source Project
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

#define TRACE_TAG ADB

#include "adb_utils.h"

#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#include <algorithm>

#include <base/stringprintf.h>
#include <base/strings.h>

#include "adb.h"
#include "adb_trace.h"
#include "sysdeps.h"

#if defined(_WIN32)
constexpr char kNullFileName[] = "NUL";
#else
constexpr char kNullFileName[] = "/dev/null";
#endif

void close_stdin() {
    int fd = unix_open(kNullFileName, O_RDONLY);
    if (fd == -1) {
        fatal_errno("failed to open %s", kNullFileName);
    }

    if (TEMP_FAILURE_RETRY(dup2(fd, STDIN_FILENO)) == -1) {
        fatal_errno("failed to redirect stdin to %s", kNullFileName);
    }
    unix_close(fd);
}

bool getcwd(std::string* s) {
  char* cwd = getcwd(nullptr, 0);
  if (cwd != nullptr) *s = cwd;
  free(cwd);
  return (cwd != nullptr);
}

bool directory_exists(const std::string& path) {
  struct stat sb;
  return lstat(path.c_str(), &sb) != -1 && S_ISDIR(sb.st_mode);
}

std::string escape_arg(const std::string& s) {
  std::string result = s;

  // Escape any ' in the string (before we single-quote the whole thing).
  // The correct way to do this for the shell is to replace ' with '\'' --- that is,
  // close the existing single-quoted string, escape a single single-quote, and start
  // a new single-quoted string. Like the C preprocessor, the shell will concatenate
  // these pieces into one string.
  for (size_t i = 0; i < s.size(); ++i) {
    if (s[i] == '\'') {
      result.insert(i, "'\\'");
      i += 2;
    }
  }

  // Prefix and suffix the whole string with '.
  result.insert(result.begin(), '\'');
  result.push_back('\'');
  return result;
}

std::string adb_basename(const std::string& path) {
    size_t base = path.find_last_of(OS_PATH_SEPARATORS);
    return (base != std::string::npos) ? path.substr(base + 1) : path;
}

static bool real_mkdirs(const std::string& path) {
    std::vector<std::string> path_components = android::base::Split(path, OS_PATH_SEPARATOR_STR);
    // TODO: all the callers do unlink && mkdirs && adb_creat ---
    // that's probably the operation we should expose.
    path_components.pop_back();
    std::string partial_path;
    for (const auto& path_component : path_components) {
        if (partial_path.back() != OS_PATH_SEPARATOR) partial_path += OS_PATH_SEPARATOR;
        partial_path += path_component;
        if (adb_mkdir(partial_path.c_str(), 0775) == -1 && errno != EEXIST) {
            return false;
        }
    }
    return true;
}

bool mkdirs(const std::string& path) {
#if defined(_WIN32)
    // Replace '/' with '\\' so we can share the code.
    std::string clean_path = path;
    std::replace(clean_path.begin(), clean_path.end(), '/', '\\');
    return real_mkdirs(clean_path);
#else
    return real_mkdirs(path);
#endif
}

std::string dump_hex(const void* data, size_t byte_count) {
    byte_count = std::min(byte_count, size_t(16));

    const uint8_t* p = reinterpret_cast<const uint8_t*>(data);

    std::string line;
    for (size_t i = 0; i < byte_count; ++i) {
        android::base::StringAppendF(&line, "%02x", p[i]);
    }
    line.push_back(' ');

    for (size_t i = 0; i < byte_count; ++i) {
        int c = p[i];
        if (c < 32 || c > 127) {
            c = '.';
        }
        line.push_back(c);
    }

    return line;
}

std::string perror_str(const char* msg) {
    return android::base::StringPrintf("%s: %s", msg, strerror(errno));
}

#if !defined(_WIN32)
bool set_file_block_mode(int fd, bool block) {
    int flags = fcntl(fd, F_GETFL, 0);
    if (flags == -1) {
        PLOG(ERROR) << "failed to fcntl(F_GETFL) for fd " << fd;
        return false;
    }
    flags = block ? (flags & ~O_NONBLOCK) : (flags | O_NONBLOCK);
    if (fcntl(fd, F_SETFL, flags) != 0) {
        PLOG(ERROR) << "failed to fcntl(F_SETFL) for fd " << fd << ", flags " << flags;
        return false;
    }
    return true;
}
#endif
