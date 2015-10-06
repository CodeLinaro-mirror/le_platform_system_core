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

#include "adb_utils.h"

#include <gtest/gtest.h>

#include <stdlib.h>
#include <string.h>

#include "sysdeps.h"

#include <base/test_utils.h>

TEST(adb_utils, directory_exists) {
  ASSERT_TRUE(directory_exists("/proc"));
  ASSERT_FALSE(directory_exists("/proc/self")); // Symbolic link.
  ASSERT_FALSE(directory_exists("/proc/does-not-exist"));
}

TEST(adb_utils, escape_arg) {
  ASSERT_EQ(R"('')", escape_arg(""));

  ASSERT_EQ(R"('abc')", escape_arg("abc"));

  ASSERT_EQ(R"(' abc')", escape_arg(" abc"));
  ASSERT_EQ(R"(''\''abc')", escape_arg("'abc"));
  ASSERT_EQ(R"('"abc')", escape_arg("\"abc"));
  ASSERT_EQ(R"('\abc')", escape_arg("\\abc"));
  ASSERT_EQ(R"('(abc')", escape_arg("(abc"));
  ASSERT_EQ(R"(')abc')", escape_arg(")abc"));

  ASSERT_EQ(R"('abc abc')", escape_arg("abc abc"));
  ASSERT_EQ(R"('abc'\''abc')", escape_arg("abc'abc"));
  ASSERT_EQ(R"('abc"abc')", escape_arg("abc\"abc"));
  ASSERT_EQ(R"('abc\abc')", escape_arg("abc\\abc"));
  ASSERT_EQ(R"('abc(abc')", escape_arg("abc(abc"));
  ASSERT_EQ(R"('abc)abc')", escape_arg("abc)abc"));

  ASSERT_EQ(R"('abc ')", escape_arg("abc "));
  ASSERT_EQ(R"('abc'\''')", escape_arg("abc'"));
  ASSERT_EQ(R"('abc"')", escape_arg("abc\""));
  ASSERT_EQ(R"('abc\')", escape_arg("abc\\"));
  ASSERT_EQ(R"('abc(')", escape_arg("abc("));
  ASSERT_EQ(R"('abc)')", escape_arg("abc)"));
}

TEST(adb_utils, mkdirs) {
  TemporaryDir td;
  std::string path = std::string(td.path) + "/dir/subdir/file";
  EXPECT_TRUE(mkdirs(path));
  EXPECT_NE(-1, adb_creat(path.c_str(), 0600));
  EXPECT_FALSE(mkdirs(path + "/subdir/"));
}

TEST(adb_utils, adb_basename) {
  EXPECT_EQ("sh", adb_basename("/system/bin/sh"));
  EXPECT_EQ("sh", adb_basename("sh"));
}

#if !defined(_WIN32)
TEST(adb_utils, set_file_block_mode) {
  int fd = adb_open("/dev/null", O_RDWR | O_APPEND);
  ASSERT_GE(fd, 0);
  int flags = fcntl(fd, F_GETFL, 0);
  ASSERT_EQ(O_RDWR | O_APPEND, (flags & (O_RDWR | O_APPEND)));
  ASSERT_TRUE(set_file_block_mode(fd, false));
  int new_flags = fcntl(fd, F_GETFL, 0);
  ASSERT_EQ(flags | O_NONBLOCK, new_flags);
  ASSERT_TRUE(set_file_block_mode(fd, true));
  new_flags = fcntl(fd, F_GETFL, 0);
  ASSERT_EQ(flags, new_flags);
  ASSERT_EQ(0, adb_close(fd));
}
#endif
