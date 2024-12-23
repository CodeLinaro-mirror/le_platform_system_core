ACLOCAL_AMFLAGS = -I m4

AM_CFLAGS = \
    -W \
    -Wall \
    -Wextra \
    -Wunused \
    -Werror

ion_sources = ion_new.c

# Build libion.so
lib_LTLIBRARIES = libion.la

libion_la_SOURCES = $(ion_sources)
libion_la_CFLAGS  = -I$(top_srcdir)/include
libion_la_CFLAGS += $(AM_CFLAGS) -Wno-error=pointer-to-int-cast
libion_la_CFLAGS += -include stddef.h
libion_la_CFLAGS += -include ion_new.h
libion_la_CFLAGS += -DTARGET_ION_ABI_VERSION=2

libion_la_LDFLAGS = @LIBLOG_LIBS@

bindir       = "@rootprefix@/bin"
bin_PROGRAMS = iontest

iontest_SOURCES  = $(ion_sources)
iontest_SOURCES += ion_test.c
iontest_CFLAGS   = -I$(top_srcdir)/include
iontest_CFLAGS  += $(AM_CFLAGS) -Wno-error=strict-aliasing -Wno-error=pointer-to-int-cast
iontest_CFLAGS  += -include stddef.h
iontest_CFLAGS  += -include ion_new.h
iontest_CFLAGS  += -DTARGET_ION_ABI_VERSION=2

iontest_LDFLAGS  = @LIBLOG_LIBS@

# Export headers
ion_includedir      = $(includedir)/ion_headers/ion
ion_include_HEADERS = $(top_srcdir)/include/ion/ion.h

pkgconfigdir   = $(libdir)/pkgconfig
pkgconfig_DATA = libion.pc
EXTRA_DIST     = $(pkgconfig_DATA)
