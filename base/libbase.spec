Name: libbase
Version: 1.0
Release: r0
Summary: Android base library

License: Apache-2.0

Group: base
URL: https://www.codelinaro.org/
#Source0: libbase-1.0.tar.gz
Source0: %{name}-%{version}.tar.gz

BuildRequires: autoconf automake libtool gcc-g++ libcutils-dev libselinux

%description
This library provides APIs for basic tasks like handling files,
Unicode strings,logging,memory allocation,integer parsing,etc.

%package -n libbase-dev
Summary: Android base library - Development files
License: Apache-2.0
Group: devel
Requires: %{name} = %{version}-%{release}

%description -n libbase-dev
This library provides APIs for basic tasks like handling files,
Unicode strings, logging, memory allocation, integer parsing,etc.
This package contains symbolic links, header files, and related
items necessary for software development.

%prep
%autosetup -n base

%build
autoreconf -if
%configure --with-core-includes=%{_builddir}/include/base

%make_build

%install
%make_install
%check

%files
%doc
%{_libdir}/libbase.a
%{_libdir}/libbase.la
%{_libdir}/libbase.so.0
%{_libdir}/libbase.so.0.0.0

%files -n libbase-dev
%{_includedir}/base/file.h
%{_includedir}/base/logging.h
%{_includedir}/base/memory.h
%{_includedir}/base/stringprintf.h
%{_includedir}/base/strings.h
%{_includedir}/base/macros.h
%{_libdir}/libbase.so
%{_libdir}/pkgconfig/libbase.pc
