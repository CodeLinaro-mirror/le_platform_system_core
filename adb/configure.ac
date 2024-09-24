AC_PREREQ(2.61)
AC_INIT([adbd],1.0.0)
AM_INIT_AUTOMAKE([-Wall gnu foreign])
AC_CONFIG_SRCDIR([Makefile.am])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])

# Check for programs
AM_PROG_AS
AC_PROG_CC
AM_PROG_CC_C_O
AC_PROG_LIBTOOL
AC_PROG_AWK
AC_PROG_CPP
AC_PROG_CXX
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
PKG_PROG_PKG_CONFIG

# Check for required libraries.
PKG_CHECK_MODULES([LIBLOG], [liblog])
PKG_CHECK_MODULES([LIBBASE], [libbase])
PKG_CHECK_MODULES([LIBCUTILS], [libcutils])
PKG_CHECK_MODULES([LIBMINCRYPT], [libmincrypt])
PKG_CHECK_MODULES([LIBFS_MGR], [fs_mgr])
PKG_CHECK_MODULES([LIBEXT4_UTILS], [ext4_utils])

AC_ARG_WITH([mkbootimg_includes],
    AC_HELP_STRING([--with-mkbootimg-includes=@<:@dir@:>@],
       [Specify the location of the mkbootimg headers]),
    [mkbootimg_incdir=$withval],
    with_mkbootimg_includes=no)

if test "x$with_mkbootimg_includes" != "xno"; then
   CPPFLAGS="${CPPFLAGS} -I${mkbootimg_incdir}"
   AC_SUBST(mkbootimg_incdir,${mkbootimg_incdir})
fi

AS_CASE([$host],
        [arm*], [ARM=yes],
        [ARM=no]
)
AM_CONDITIONAL(ARM, [test "x$ARM" = "xyes"])

AS_CASE([$host],
        [aarch64*], [ARM64=yes],
        [ARM64=no]
)
AM_CONDITIONAL(ARM64, [test "x$ARM64" = "xyes"])

AS_CASE([$host],
        [x86_64*], [X86_64=yes],
        [X86_64=no]
)
AM_CONDITIONAL(X86_64, [test "x$X86_64" = "xyes"])

AM_CONDITIONAL(BUILD_HOST, [test "x$X86_64" = "xyes"])
AM_CONDITIONAL(BUILD_DEVICE, [test "x$ARM$ARM64" != "xnono"])

AC_ARG_WITH([host-os],
        [AS_HELP_STRING([--with-host-os=HOST_OS],[Host OS to build adb host.(default: linux)])],
        [HOST_OS="$withval"],
        [HOST_OS='linux'])

if test "x$HOST_OS" = "xlinux-gnueabi"; then
  HOST_OS=linux
else
  AC_MSG_NOTICE([Unknown host OS $HOST_OS detected.])
fi

AM_CONDITIONAL([HOST_OS_LINUX], [test "x$HOST_OS" = "xlinux"])

AC_CHECK_FUNCS([strlcpy],[STRLCPY=yes],[STRLCPY=no])

if (test "x${STRLCPY}" = "xno"); then
        AC_ARG_WITH([glib],
                    AC_HELP_STRING([--with-glib],
                                   [enable glib, building HLOS systems which use glib]))

        if (test "x${with_glib}" = "xyes"); then
                AC_DEFINE(ENABLE_USEGLIB, 1, [Define if HLOS systems uses glib])
                PKG_CHECK_MODULES(GTHREAD, gthread-2.0 >= 2.16, dummy=yes,
                                  AC_MSG_ERROR(GThread >= 2.16 is required))
                PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.16, dummy=yes,
                                  AC_MSG_ERROR(GLib >= 2.16 is required))
                GLIB_CFLAGS="$GLIB_CFLAGS $GTHREAD_CFLAGS"
                GLIB_LIBS="$GLIB_LIBS $GTHREAD_LIBS"

                AC_SUBST(GLIB_CFLAGS)
                AC_SUBST(GLIB_LIBS)
        fi
fi

AM_CONDITIONAL(USE_GLIB, [test "x${with_glib}" = "xyes"  && test "x${STRLCPY}" = "xno"])

AC_ARG_ENABLE(selinux,
      AC_HELP_STRING([--enable-selinux], [DISTRO enable selinux feature.]),
         [selinux_enable=${enableval}], [selinux_enable="no"])

if (test "x${selinux_enable}" = "xyes"); then
        PKG_CHECK_MODULES([LIBSELINUX], [libselinux])
        AC_SUBST([LIBSELINUX_CFLAGS])
        AC_SUBST([LIBSELINUX_LIBS])
fi
AM_CONDITIONAL(SELINUX_ENABLE, [test "x${selinux_enable}" = "xyes"])

AC_ARG_ENABLE(adb-root,
      AC_HELP_STRING([--disable-adb-root], [Disable root privileges for adbd (default: enable)]),
         [adb_root=${enableval}], [adb_root="yes"])

AM_CONDITIONAL(ADB_ROOT, [test "x${adb_root}" = "xyes"])

AC_ARG_ENABLE(adb-verity,
      AC_HELP_STRING([--enable-adb-verity], [ADB enable verity for avb.]),
      [adb_verity=${enableval}], [adb_verity="no"])

AM_CONDITIONAL(ADB_VERITY, [test "x${adb_verity}" = "xyes"])

AC_ARG_ENABLE(adb-avb20,
      AC_HELP_STRING([--enable-adb-avb20], [ADB disable/enable verity with AVB2.0]),
      [adb_avb20=${enableval}], [adb_avb20="yes"])

AM_CONDITIONAL(ADB_AVB20, [test "x${adb_avb20}" = "xyes"])

AC_ARG_ENABLE(system-properties,
      AC_HELP_STRING([--disable-system-properties], [System Properties are enabled by default.]),
         [system_properties=${enableval}], [system_properties="yes"])

AM_CONDITIONAL(USING_SYSTEM_PROPERTIES, [test "x${system_properties}" = "xyes"])

AC_ARG_WITH([system-size],
        [AS_HELP_STRING([--with-system-size=SYSTEM_SIZE],[Size of system partition.])],
        [SYSTEM_SIZE="$withval"],
        [SYSTEM_SIZE="0"])

AC_SUBST(SYSTEM_SIZE)

AC_MSG_NOTICE([System of size $SYSTEM_SIZE detected.])

AC_ARG_WITH([fec-size],
        [AS_HELP_STRING([--with-fec-size=FEC_SIZE],[Size of fec image .])],
        [FEC_SIZE="$withval"],
        [FEC_SIZE="0"])

AC_SUBST(FEC_SIZE)

AC_MSG_NOTICE([fec image size $FEC_SIZE detected.])

AC_ARG_WITH(systemd,
        AS_HELP_STRING([--with-systemd], [enable systemd adbd]),
        [SYSTEMD="yes"],
        [SYSTEMD="no"])

AM_CONDITIONAL([USE_SYSTEMD], [test "x${SYSTEMD}" != "xno"])

# systemd is enabled if explicitly added as a configure argument or
# if pkg_config finds systemd installed on the target.
AC_ARG_WITH([systemd_system_unitdir],
     [AS_HELP_STRING([--with-systemd-system-unitdir=DIR], [systemd])],,
     [with_systemd_system_unitdir=auto])
AS_IF([test "x$with_systemd_system_unitdir" = "xyes" -o "x$with_systemd_system_unitdir" = "xauto"], [
     def_systemd_system_unitdir=$($PKG_CONFIG --variable=systemdsystemunitdir systemd)

     AS_IF([test "x$def_systemd_system_unitdir" = "x"],
   [AS_IF([test "x$with_systemd_system_unitdir" = "xyes"],
    [AC_MSG_ERROR([systemd support requested but pkg-config unable to query systemd package])])
    with_systemd_system_unitdir=no],
   [with_systemd_system_unitdir="$def_systemd_system_unitdir"])])
AS_IF([test "x$with_systemd_system_unitdir" != "xno"],
      [AC_SUBST([systemd_system_unitdir], [$with_systemd_system_unitdir])])

AC_CONFIG_FILES([ \
    Makefile \
])
AC_OUTPUT
