# Build shared lib.
lib_LTLIBRARIES := liblogwrap.la

liblogwrap_la_SOURCES := logwrap.c
liblogwrap_la_CFLAGS  := @LIBCUTILS_CFLAGS@ @LIBLOG_CFLAGS@
liblogwrap_la_CFLAGS  += -I$(top_srcdir)/include
liblogwrap_la_LDFLAGS :=  @LIBCUTILS_LIBS@ @LIBLOG_LIBS@

# Build logwrapper daemon
bin_PROGRAMS = logwrapper

logwrapper_SOURCES := logwrapper.c
logwrapper_CFLAGS  := @LIBCUTILS_CFLAGS@ @LIBLOG_CFLAGS@
logwrapper_CFLAGS  += -I$(top_srcdir)/include
logwrapper_LDADD   := liblogwrap.la
logwrapper_LDADD   += -lcutils -llog -lpthread

# Export headers
logwrapper_includedir=$(includedir)/logwrap
logwrapper_include_HEADERS := $(top_srcdir)/include/logwrap/logwrap.h

pkgconfigdir := $(libdir)/pkgconfig
pkgconfig_DATA := logwrapper.pc
EXTRA_DIST := $(pkgconfig_DATA)

