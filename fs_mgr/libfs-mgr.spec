Name: libfs-mgr
Version: 1.0
Release: r0
Summary: filesystem manager

License: Apache-2.0

URL: https://www.codelinaro.org/
Source0: %{name}-%{version}.tar.gz

BuildRequires: autoconf automake libtool gcc-g++ glib2-devel liblog-dev libcutils-dev libext4-utils-dev libmincrypt-dev liblogwrapper-dev
Requires: glib2

%description
fs-mgr provides an interface for filesystem management.
The fs-mgr interface allows for querying the filesystem, mounting and
unmounting, and other functionality.

%package dev
Summary: %{summary} - Development files
Requires: %{name} = %{version}-%{release}

%description dev
fs-mgr provides an interface for filesystem management.
The fs-mgr interface allows for querying the filesystem, mounting and
unmounting, and other functionality.
This package contains symbolic links, header files, and related items necessary
for software development.


%prep
%autosetup -n fs_mgr

%build
autoreconf -if
%configure --with-glib

%make_build

%install
%make_install

%files
%{_bindir}/fs_mgr
%{_libdir}/libfs_mgr.a
%{_libdir}/libfs_mgr.la
%{_libdir}/libfs_mgr.so.0
%{_libdir}/libfs_mgr.so.0.0.0

%files dev
%dir %{_includedir}/fs_mgr
%{_includedir}/fs_mgr/fs_mgr.h
%{_libdir}/pkgconfig/fs_mgr.pc
%{_libdir}/libfs_mgr.so
