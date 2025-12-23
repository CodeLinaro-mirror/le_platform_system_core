root_sbindir       := "/usr/sbin"
root_sbin_PROGRAMS := disksymlink-service

disksymlink_service_SOURCES  = disk_symlink.cpp
disksymlink_service_SOURCES += disk_part.cpp

disksymlink_service_LDFLAGS  = -lblkid -lvmm_utils

disksymlink_service_CPPFLAGS  = -I$(top_srcdir)
disksymlink_service_CPPFLAGS += -std=c++11 -Wall -Wno-unused-parameter
