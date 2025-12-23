BUILD_COMPONENTS :=

# Builds for both host and device
#BUILD_COMPONENTS += libzarchive

if BUILD_DEVICE
if !NO_LIBSYNC
BUILD_COMPONENTS += libsync
endif
if USE_LOGD
BUILD_COMPONENTS += logcat
BUILD_COMPONENTS += libsysutils
BUILD_COMPONENTS += logd
endif
BUILD_COMPONENTS += leproperties
if BUILD_DISKSYMLINK
BUILD_COMPONENTS += disksymlink
endif
BUILD_COMPONENTS += toolbox
BUILD_COMPONENTS += usb
BUILD_COMPONENTS += include
if !NO_DEBUGGERD
BUILD_COMPONENTS += libbacktrace
BUILD_COMPONENTS += debuggerd
endif
endif

if BUILD_HOST
BUILD_COMPONENTS += fastboot
endif

SUBDIRS := $(BUILD_COMPONENTS)
