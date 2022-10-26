Name: libmincrypt
Version: 1.0
Release: r0
Summary: Android library for mincrypt

License: BSD-3-Clause

URL: https://www.codelinaro.org/
#Source0: libmincrypt-1.0.tar.gz
Source0: %{name}-%{version}.tar.gz
# The source tarball must contain the libmincrypt/ and include/ directories
# for access to the necessary headers in include/mincrypt/ and other headers
# libmincrypt depends on

BuildRequires: autoconf automake libtool gcc-g++

%description
This library provides minimalistic encryption support and
implements SHA1 and SHA-256 hash algoraithm

%package -n libmincrypt-dev
Summary: Android utils library for C - Development files
Requires: %{name} = %{version}-%{release}

%description -n libmincrypt-dev
This library provides minimalistic encryption support and
implements SHA1 and SHA-256 hash algoraithm
This package contains symbolic links, header files, and related
items necessary for software development.

%prep
%autosetup -n libmincrypt

%build
autoreconf -if
%configure --with-core-includes=%{_builddir}/include

%make_build

%install
%make_install

%files
%license NOTICE
%{_libdir}/libmincrypt.a
%{_libdir}/libmincrypt.la
%{_libdir}/libmincrypt.so.0
%{_libdir}/libmincrypt.so.0.0.0

%files -n libmincrypt-dev
%{_libdir}/libmincrypt.so
%{_libdir}/pkgconfig/libmincrypt.pc
%dir %{_includedir}/mincrypt
%{_includedir}/mincrypt/dsa_sig.h
%{_includedir}/mincrypt/hash-internal.h
%{_includedir}/mincrypt/p256_ecdsa.h
%{_includedir}/mincrypt/p256.h
%{_includedir}/mincrypt/rsa.h
%{_includedir}/mincrypt/sha256.h
%{_includedir}/mincrypt/sha.h
