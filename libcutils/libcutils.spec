Name: libcutils
Version: 1.0
Release: r0
Summary: Android utils library for C

License: Apache-2.0

URL: https://www.codelinaro.org/
#Source0: libcutils-1.0.tar.gz
Source0: %{name}-%{version}.tar.gz
# The source tarball must contain the cutils/ and include/ directories
# for access to the necessary headers in include/{cutils,private,sys}/

BuildRequires: autoconf automake libtool gcc-g++ liblog-dev

%description
This library provides set of fundamental routines which are essential to
basically any Unix utility or daemon application written in C.

%package -n libcutils-dev
Summary: Android utils library for C - Development files
Requires: %{name} = %{version}-%{release}

%description -n libcutils-dev
This library provides set of fundamental routines which are essential to
basically any Unix utility or daemon application written in C.  This
package contains symbolic links, header files, and related items necessary
for software development.

%prep
%autosetup -n libcutils

%build
autoreconf -if
%configure --with-core-includes=%{_builddir}/include

%make_build

%install
%make_install

%files
%license NOTICE
%{_libdir}/libcutils.a
%{_libdir}/libcutils.la
%{_libdir}/libcutils.so.0
%{_libdir}/libcutils.so.0.0.0

%files -n libcutils-dev
%{_libdir}/libcutils.so
%{_libdir}/pkgconfig/libcutils.pc
%dir %{_includedir}/cutils
%{_includedir}/cutils/android_reboot.h
%{_includedir}/cutils/aref.h
%{_includedir}/cutils/ashmem.h
%{_includedir}/cutils/atomic.h
%{_includedir}/cutils/bitops.h
%{_includedir}/cutils/compiler.h
%{_includedir}/cutils/config_utils.h
%{_includedir}/cutils/debugger.h
%{_includedir}/cutils/fs.h
%{_includedir}/cutils/hashmap.h
%{_includedir}/cutils/iosched_policy.h
%{_includedir}/cutils/jstring.h
%{_includedir}/cutils/klog.h
%{_includedir}/cutils/list.h
%{_includedir}/cutils/log.h
%{_includedir}/cutils/memory.h
%{_includedir}/cutils/misc.h
%{_includedir}/cutils/multiuser.h
%{_includedir}/cutils/native_handle.h
%{_includedir}/cutils/open_memstream.h
%{_includedir}/cutils/partition_utils.h
%{_includedir}/cutils/process_name.h
%{_includedir}/cutils/properties.h
%{_includedir}/cutils/qtaguid.h
%{_includedir}/cutils/record_stream.h
%{_includedir}/cutils/sched_policy.h
%{_includedir}/cutils/sockets.h
%{_includedir}/cutils/stdatomic.h
%{_includedir}/cutils/str_parms.h
%{_includedir}/cutils/threads.h
%{_includedir}/cutils/trace.h
%{_includedir}/cutils/uevent.h
%dir %{_includedir}/cutils/sys
%{_includedir}/cutils/sys/capability.h
%{_includedir}/cutils/sys/system_properties.h
%dir %{_includedir}/private
%{_includedir}/private/android_filesystem_capability.h
%{_includedir}/private/android_filesystem_config.h
