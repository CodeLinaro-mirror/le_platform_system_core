AC_PREREQ(2.61)
AC_INIT([libion],1.0.0)
AM_INIT_AUTOMAKE([-Wall gnu foreign])
AC_CONFIG_SRCDIR([Makefile.am])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])

# Check for programs
AM_PROG_AR
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

PKG_CHECK_MODULES([LIBLOG], [liblog])
AC_SUBST([LIBLOG_CFLAGS])
AC_SUBST([LIBLOG_LIBS])


AC_ARG_WITH([rootprefix],
    [AS_HELP_STRING([--with-rootprefix=DIR], [Set the root prefix directory])],
    [rootprefix=$withval],
    [rootprefix=""])
AC_SUBST([rootprefix])

AC_ARG_WITH([core_includes],
    AC_HELP_STRING([--with-core-includes=@<:@dir@:>@],
       [Specify the location of the core headers]),
    [core_incdir=$withval],
    with_core_includes=no)

if test "x$with_core_includes" != "xno"; then
   CPPFLAGS="${CPPFLAGS} -I${core_incdir}"
   AC_SUBST(core_incdir,${core_incdir})
fi

AC_ARG_WITH(sanitized-headers,
        AS_HELP_STRING([--with-sanitized-headers=DIR],
                [Specify the location of the sanitized Linux headers]),
        [CPPFLAGS="$CPPFLAGS -I $withval"])

AC_CONFIG_FILES([ \
    Makefile \
    libion.pc
])
AC_OUTPUT

