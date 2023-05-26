Name: liblogwrapper
Version: 1.0
Release: r0
Summary: Android wrapper library for logging

License: Apache-2.0

URL: https://www.codelinaro.org/
Source0: %{name}-%{version}.tar.gz

BuildRequires: autoconf automake libtool gcc-g++ libcutils-dev liblog-dev

%description
This library provides a wrapper interface for logging to the Android logging system.
Includes an option to log to the kernel log.

%package dev
Summary: %{summary} - Development files
Requires: %{name} = %{version}-%{release}

%description dev
This library provides a wrapper interface for logging to the Android logging system.
Includes an option to log to the kernel log.
This package contains symbolic links, header files, and related items necessary
for software development.

%prep
%autosetup -n logwrapper

%build
autoreconf -if
%configure

%make_build

%install
%make_install

%files
%license NOTICE
%{_bindir}/logwrapper
%{_libdir}/liblogwrap.a
%{_libdir}/liblogwrap.la
%{_libdir}/liblogwrap.so.0
%{_libdir}/liblogwrap.so.0.0.0

%files dev
%{_libdir}/pkgconfig/logwrapper.pc
%{_includedir}/logwrap/logwrap.h
%{_libdir}/liblogwrap.so
