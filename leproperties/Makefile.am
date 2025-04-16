ACLOCAL_AMFLAGS = -I m4

root_sbindir       = "@rootprefix@/sbin"
root_libdir        = "@rootprefix@/lib"
root_etcdir        = "/etc"
root_sbin_PROGRAMS = leprop-service

bin_PROGRAMS     = setprop
setprop_SOURCES  = setprop.c
setprop_CFLAGS   = -I$(top_srcdir) @LIBCUTILS_CFLAGS@
setprop_LDFLAGS  = @LIBCUTILS_LIBS@

if SELINUX_ENABLE
setprop_LDFLAGS  += -lselinux
setprop_CFLAGS += -DSELINUX_IS_ENABLE
endif

setprop_CFLAGS += -fstack-protector-all

bin_PROGRAMS    += getprop
getprop_SOURCES  = getprop.c
getprop_CFLAGS   = -I$(top_srcdir) @LIBCUTILS_CFLAGS@
getprop_LDFLAGS  = @LIBCUTILS_LIBS@

if SELINUX_ENABLE
getprop_LDFLAGS  += -lselinux
getprop_CFLAGS += -DSELINUX_IS_ENABLE
endif

leprop_service_SOURCES  = property_service.c
leprop_service_SOURCES += ll.c

leprop_service_CPPFLAGS = -I$(top_srcdir) @LIBCUTILS_CFLAGS@
leprop_service_LDFLAGS  = @LIBLOG_LIBS@ @LIBCUTILS_LIBS@

if PROPTRIGGER
leprop_service_CPPFLAGS += -DPROP_TRIGGER

root_etc_SCRIPTS  = proptrigger.sh
root_etc_SCRIPTS += proptrigger.conf

install-data-hook:
	chmod  go-x $(DESTDIR)$(root_etcdir)/proptrigger.sh
	chmod  go-x $(DESTDIR)$(root_etcdir)/proptrigger.conf
endif

if USE_SYSTEMD
leproperties_systemddir   = $(root_libdir)/systemd/system
leproperties_systemd_DATA = leprop.service
endif
