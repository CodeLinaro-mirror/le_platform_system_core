Name: liblog
Version: 1.0
Release: r0
Summary: liblog - Android NDK logger interfaces

License: Apache-2.0

Group: base
URL: https://www.codelinaro.org/
#Source0: liblog-1.0.tar.gz
Source0: %{name}-%{version}.tar.gz

BuildRequires: autoconf automake libtool gcc-g++

%description
liblog  represents  an interface to the volatile Android Logging system for
NDK (Native) applications  and  libraries.  Interfaces  for  either writing
or reading logs.

%package -n liblog-dev
Summary: liblog - Android NDK logger interfaces - Development files
License: Apache-2.0
Group: devel
Requires: %{name} = %{version}-%{release}

%description -n liblog-dev
liblog  represents  an interface to the volatile Android Logging system for
NDK (Native) applications  and  libraries.  Interfaces  for  either writing
or reading logs.  This package contains symbolic links, header files, and
related items necessary for software development.

%prep
%autosetup -n liblog

%build
autoreconf -if
%configure --with-core-includes=%{_builddir}/include

%make_build

%install
%make_install
%check

%files
%license NOTICE
%doc
%{_libdir}/liblog.a
%{_libdir}/liblog.la
%{_libdir}/liblog.so.0
%{_libdir}/liblog.so.0.0.0

%files -n liblog-dev
%{_includedir}/android/log.h
%{_includedir}/log/event_tag_map.h
%{_includedir}/log/log.h
%{_includedir}/log/log_read.h
%{_includedir}/log/logd.h
%{_includedir}/log/logger.h
%{_includedir}/log/logprint.h
%{_includedir}/log/uio.h
%{_libdir}/liblog.so
%{_libdir}/pkgconfig/liblog.pc
