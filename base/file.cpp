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

#include "base/file.h"

#include <errno.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <libgen.h>
#include <unistd.h>
#include <memory>
#include <mutex>
#include <cstring>
#include <string>
#include <vector>

#if defined(__APPLE__)
#include <mach-o/dyld.h>
#endif
#if defined(_WIN32)
#include <direct.h>
#include <windows.h>
#define O_NOFOLLOW 0
#define OS_PATH_SEPARATOR '\\'
#else
#define OS_PATH_SEPARATOR '/'
#endif
#include "base/macros.h"  // For TEMP_FAILURE_RETRY on Darwin.
#define LOG_TAG "base.file"
#include "cutils/log.h"
#include "utils/Compat.h"

std::string GetSystemTempDir() {
#if defined(__ANDROID__)
  const auto* tmpdir = getenv("TMPDIR");
  if (tmpdir == nullptr) tmpdir = "/data/local/tmp";
  if (access(tmpdir, R_OK | W_OK | X_OK) == 0) {
    return tmpdir;
  }
  // Tests running in app context can't access /data/local/tmp,
  // so try current directory if /data/local/tmp is not accessible.
  return ".";
#elif defined(_WIN32)
  wchar_t tmp_dir_w[MAX_PATH];
  DWORD result = GetTempPathW(std::size(tmp_dir_w), tmp_dir_w);  // checks TMP env
  CHECK_NE(result, 0ul) << "GetTempPathW failed, error: " << GetLastError();
  CHECK_LT(result, std::size(tmp_dir_w)) << "path truncated to: " << result;

  // GetTempPath() returns a path with a trailing slash, but init()
  // does not expect that, so remove it.
  if (tmp_dir_w[result - 1] == L'\\') {
    tmp_dir_w[result - 1] = L'\0';
  }

  std::string tmp_dir;
  CHECK(android::base::WideToUTF8(tmp_dir_w, &tmp_dir)) << "path can't be converted to utf8";

  return tmp_dir;
#else
  const auto* tmpdir = getenv("TMPDIR");
  if (tmpdir == nullptr) tmpdir = "/tmp";
  return tmpdir;
#endif
}
TemporaryFile::TemporaryFile() {
  init(GetSystemTempDir());
}

TemporaryFile::TemporaryFile(const std::string& tmp_dir) {
  init(tmp_dir);
}

TemporaryFile::~TemporaryFile() {
  if (fd != -1) {
    close(fd);
  }
  if (remove_file_) {
    unlink(path);
  }
}

int TemporaryFile::release() {
  int result = fd;
  fd = -1;
  return result;
}

void TemporaryFile::init(const std::string& tmp_dir) {
  snprintf(path, sizeof(path), "%s%cTemporaryFile-XXXXXX", tmp_dir.c_str(), OS_PATH_SEPARATOR);
#if defined(_WIN32)
  fd = mkstemp(path, sizeof(path));
#else
  fd = mkstemp(path);
#endif
}
namespace android {
namespace base {

bool ReadFdToString(int fd, std::string* content) {
  content->clear();

  char buf[BUFSIZ];
  ssize_t n;
  while ((n = TEMP_FAILURE_RETRY(read(fd, &buf[0], sizeof(buf)))) > 0) {
    content->append(buf, n);
  }
  return (n == 0) ? true : false;
}

bool ReadFileToString(const std::string& path, std::string* content) {
  content->clear();

  int fd =
      TEMP_FAILURE_RETRY(open(path.c_str(), O_RDONLY | O_CLOEXEC | O_NOFOLLOW));
  if (fd == -1) {
    return false;
  }
  bool result = ReadFdToString(fd, content);
  close(fd);
  return result;
}

bool WriteStringToFd(const std::string& content, int fd) {
  const char* p = content.data();
  size_t left = content.size();
  while (left > 0) {
    ssize_t n = TEMP_FAILURE_RETRY(write(fd, p, left));
    if (n == -1) {
      return false;
    }
    p += n;
    left -= n;
  }
  return true;
}

static bool CleanUpAfterFailedWrite(const std::string& path) {
  // Something went wrong. Let's not leave a corrupt file lying around.
  int saved_errno = errno;
  unlink(path.c_str());
  errno = saved_errno;
  return false;
}

#if !defined(_WIN32)
bool WriteStringToFile(const std::string& content, const std::string& path,
                       mode_t mode, uid_t owner, gid_t group) {
  int fd = TEMP_FAILURE_RETRY(
      open(path.c_str(), O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC | O_NOFOLLOW,
           mode));
  if (fd == -1) {
    ALOGE("android::WriteStringToFile open failed: %s", strerror(errno));
    return false;
  }

  // We do an explicit fchmod here because we assume that the caller really
  // meant what they said and doesn't want the umask-influenced mode.
  if (fchmod(fd, mode) == -1) {
    ALOGE("android::WriteStringToFile fchmod failed: %s", strerror(errno));
    return CleanUpAfterFailedWrite(path);
  }
  if (fchown(fd, owner, group) == -1) {
    ALOGE("android::WriteStringToFile fchown failed: %s", strerror(errno));
    return CleanUpAfterFailedWrite(path);
  }
  if (!WriteStringToFd(content, fd)) {
    ALOGE("android::WriteStringToFile write failed: %s", strerror(errno));
    return CleanUpAfterFailedWrite(path);
  }
  close(fd);
  return true;
}
#endif

bool WriteStringToFile(const std::string& content, const std::string& path) {
  int fd = TEMP_FAILURE_RETRY(
      open(path.c_str(), O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC | O_NOFOLLOW,
           DEFFILEMODE));
  if (fd == -1) {
    return false;
  }

  bool result = WriteStringToFd(content, fd);
  close(fd);
  return result || CleanUpAfterFailedWrite(path);
}

bool ReadFully(int fd, void* data, size_t byte_count) {
  uint8_t* p = reinterpret_cast<uint8_t*>(data);
  size_t remaining = byte_count;
  while (remaining > 0) {
    ssize_t n = TEMP_FAILURE_RETRY(read(fd, p, remaining));
    if (n <= 0) return false;
    p += n;
    remaining -= n;
  }
  return true;
}

bool WriteFully(int fd, const void* data, size_t byte_count) {
  const uint8_t* p = reinterpret_cast<const uint8_t*>(data);
  size_t remaining = byte_count;
  while (remaining > 0) {
    ssize_t n = TEMP_FAILURE_RETRY(write(fd, p, remaining));
    if (n == -1) return false;
    p += n;
    remaining -= n;
  }
  return true;
}

#if !defined(_WIN32)
bool Readlink(const std::string& path, std::string* result) {
  result->clear();

  // Most Linux file systems (ext2 and ext4, say) limit symbolic links to
  // 4095 bytes. Since we'll copy out into the string anyway, it doesn't
  // waste memory to just start there. We add 1 so that we can recognize
  // whether it actually fit (rather than being truncated to 4095).
  std::vector<char> buf(4095 + 1);
  while (true) {
    ssize_t size = readlink(path.c_str(), &buf[0], buf.size());
    // Unrecoverable error?
    if (size == -1) return false;
    // It fit! (If size == buf.size(), it may have been truncated.)
    if (static_cast<size_t>(size) < buf.size()) {
      result->assign(&buf[0], size);
      return true;
    }
    // Double our buffer and try again.
    buf.resize(buf.size() * 2);
  }
}
#endif
std::string GetExecutablePath() {
#if defined(__linux__)
  std::string path;
  android::base::Readlink("/proc/self/exe", &path);
  return path;
#elif defined(__APPLE__)
  char path[PATH_MAX + 1];
  uint32_t path_len = sizeof(path);
  int rc = _NSGetExecutablePath(path, &path_len);
  if (rc < 0) {
    std::unique_ptr<char> path_buf(new char[path_len]);
    _NSGetExecutablePath(path_buf.get(), &path_len);
    return path_buf.get();
  }
  return path;
#elif defined(_WIN32)
  char path[PATH_MAX + 1];
  DWORD result = GetModuleFileName(NULL, path, sizeof(path) - 1);
  if (result == 0 || result == sizeof(path) - 1) return "";
  path[PATH_MAX - 1] = 0;
  return path;
#else
#error unknown OS
#endif
}

std::string GetExecutableDirectory() {
  return Dirname(GetExecutablePath());
}


std::string Dirname(const std::string& path) {
  // Copy path because dirname may modify the string passed in.
  std::string result(path);

#if !defined(__BIONIC__)
  // Use lock because dirname() may write to a process global and return a
  // pointer to that. Note that this locking strategy only works if all other
  // callers to dirname in the process also grab this same lock, but its
  // better than nothing.  Bionic's dirname returns a thread-local buffer.
  static std::mutex& dirname_lock = *new std::mutex();
  std::lock_guard<std::mutex> lock(dirname_lock);
#endif

  // Note that if std::string uses copy-on-write strings, &str[0] will cause
  // the copy to be made, so there is no chance of us accidentally writing to
  // the storage for 'path'.
  char* parent = dirname(&result[0]);

  // In case dirname returned a pointer to a process global, copy that string
  // before leaving the lock.
  result.assign(parent);

  return result;
}

}  // namespace base
}  // namespace android
