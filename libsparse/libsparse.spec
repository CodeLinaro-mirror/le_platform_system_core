Name: libsparse
Version: 1.0
Release: r0
Summary: Android Sparse library

License: Apache-2.0

URL: https://www.codelinaro.org/
#Source0: libsparse-1.0.tar.gz
Source0: %{name}-%{version}.tar.gz

BuildRequires: autoconf automake libtool gcc-g++ zlib-devel

%description
Libparse is a library in common use by the various Android core host
applications. It provides utilities to convert from raw to sparse images
and back.

%package -n libsparse-dev
Summary: Android Sparse library - Development files
License: Apache-2.0
Requires: %{name} = %{version}-%{release}

%description -n libsparse-dev
Libparse is a library in common use by the various Android core host
applications. It provides utilities to convert from raw to sparse images
and back.  This package contains symbolic links, header files, and related
items necessary for software development.

%prep
%autosetup -n libsparse

cp -rf ../NOTICE .

%build
autoreconf -if
%configure

%make_build

%install
%make_install

%files
%license NOTICE
%{_libdir}/libsparse.a
%{_libdir}/libsparse.la
%{_libdir}/libsparse.so.0
%{_libdir}/libsparse.so.0.0.0

%files -n libsparse-dev
%license NOTICE
%{_includedir}/sparse/sparse.h
%{_includedir}/sparse/sparse_crc32.h
%{_libdir}/libsparse.so
%{_libdir}/pkgconfig/libsparse.pc
