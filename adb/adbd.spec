Name: adbd
Version: 1.0
Release: r0
Summary: Android Debug Bridge Daemon for ADB over ethernet on PVM
License: Apache-2.0
URL: https://www.codelinaro.org/
Source0: %{name}-%{version}.tar.gz

BuildRequires: autoconf automake libtool gcc-g++ systemd-rpm-macros libbase-dev libfs-mgr-dev glib2-devel systemd
Requires: glib2

%description
Android Debug Bridge (ADB) Daemon allows clients to run ADB and connect
to this device. It allows features like pushing files from host to device,
and pulling files from device to host.

%package dev
Summary: %{summary} - Development files
Requires: %{name} = %{version}-%{release}

%description dev
Android Debug Bridge (ADB) Daemon allows clients to run ADB and connect
to this device. It allows features like pushing files from host to device,
and pulling files from device to host.
This package contains an unversioned shared library.

%prep
%setup -n %{name}

%define EXTRA_OECONF --with-glib --with-mkbootimg-includes=%{_builddir}/mkbootimg/include/bootimg --with-systemd --enable-adb-root --disable-system-properties

%build
autoreconf -if
%configure %{EXTRA_OECONF}
%make_build

%install
%make_install

%files
%license NOTICE
%{_sbindir}/adbd
%{_unitdir}/adbd.service
%{_unitdir}/multi-user.target.wants/adbd.service
%{_libdir}/libadbd.so.0.0.0
%{_libdir}/libadbd.a
%{_libdir}/libadbd.la
%{_libdir}/libadbd.so.0
/usr/lib/tmpfiles.d/adbd.conf

%files dev
%{_libdir}/libadbd.so
