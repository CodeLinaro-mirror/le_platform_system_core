AC_PREREQ(2.61)
AC_INIT([leproperties],1.0.0)
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

# Checks for libraries.

AC_ARG_ENABLE(selinux,
      AC_HELP_STRING([--enable-selinux], [DISTRO enable selinux feature.]),
      [selinux_enable=${enableval}], [selinux_enable="no"])

AM_CONDITIONAL(SELINUX_ENABLE, [test "x${selinux_enable}" = "xyes"])

if test "x$selinux_enable" = "xyes"; then
PKG_CHECK_MODULES([LIBSELINUX], [libselinux])
AC_SUBST([LIBSELINUX_CFLAGS])
AC_SUBST([LIBSELINUX_LIBS])
fi

PKG_CHECK_MODULES([LIBCUTILS], [libcutils])
AC_SUBST([LIBCUTILS_CFLAGS])
AC_SUBST([LIBCUTILS_LIBS])

PKG_CHECK_MODULES([LIBLOG], [liblog])
AC_SUBST([LIBLOG_CFLAGS])
AC_SUBST([LIBLOG_LIBS])

AC_ARG_WITH([rootprefix],
    [AS_HELP_STRING([--with-rootprefix=DIR], [Set the root prefix directory])],
    [rootprefix=$withval],
    [rootprefix=""])
AC_SUBST([rootprefix])

AC_ARG_ENABLE(prop-trig,
      AS_HELP_STRING([--enable-property-triggers], [Enable property trigger scripts]),
         [prop_trig="yes"], [prop_trig="no"])

AM_CONDITIONAL(PROPTRIGGER, [test "x${prop_trig}" = "xyes"])

AC_ARG_WITH(systemd,
        AS_HELP_STRING([--with-systemd], [enable leproperties in systemd]),
        [SYSTEMD="yes"],
        [SYSTEMD="no"])

AM_CONDITIONAL([USE_SYSTEMD], [test "x${SYSTEMD}" != "xno"])

AC_CONFIG_FILES([ \
    Makefile \
])
AC_OUTPUT
