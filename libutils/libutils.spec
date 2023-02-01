Name: libutils
Version: 1.0
Release: r0
Summary: Android Utility Function Library

License: Apache-2.0

URL: https://www.codelinaro.org/
#Source0: libutils-1.0.tar.gz
Source0: %{name}-%{version}.tar.gz

BuildRequires: autoconf automake libtool gcc-g++
# The source tarball must contain the utils/ and include/ directories
# for access to the necessary headers in include/utils/ and other headers
# libutils depends on

%description
This library provides miscellaneous utility functions and common
definitions, such as log, thread, buffer, vector and mutex.

%package -n libutils-dev
Summary: Android utils library for C - Development files
Requires: %{name} = %{version}-%{release}

%description -n libutils-dev
This library provides miscellaneous utility functions and common
definitions, such as log, thread, buffer, vector and mutex.
This package contains symbolic links, header files, and related
items necessary for software development.

%prep
%autosetup -n libutils

%build
autoreconf -if
%configure --with-system-core-includes=%{_builddir}/include

%make_build

%install
%make_install

%files
%license NOTICE
%{_libdir}/libutils.a
%{_libdir}/libutils.la
%{_libdir}/libutils.so.0
%{_libdir}/libutils.so.0.0.0

%files -n libutils-dev
%{_libdir}/libutils.so
%{_libdir}/pkgconfig/libutils.pc
%dir %{_includedir}/utils
%{_includedir}/utils/AndroidThreads.h
%{_includedir}/utils/ashmem.h
%{_includedir}/utils/Atomic.h
%{_includedir}/utils/BasicHashtable.h
%{_includedir}/utils/BitSet.h
%{_includedir}/utils/BlobCache.h
%{_includedir}/utils/ByteOrder.h
%{_includedir}/utils/CallStack.h
%{_includedir}/utils/Compat.h
%{_includedir}/utils/Condition.h
%{_includedir}/utils/Debug.h
%{_includedir}/utils/Endian.h
%{_includedir}/utils/Errors.h
%{_includedir}/utils/FileMap.h
%{_includedir}/utils/Flattenable.h
%{_includedir}/utils/Functor.h
%{_includedir}/utils/JenkinsHash.h
%{_includedir}/utils/KeyedVector.h
%{_includedir}/utils/LinearTransform.h
%{_includedir}/utils/List.h
%{_includedir}/utils/Log.h
%{_includedir}/utils/Looper.h
%{_includedir}/utils/LruCache.h
%{_includedir}/utils/misc.h
%{_includedir}/utils/Mutex.h
%{_includedir}/utils/NativeHandle.h
%{_includedir}/utils/Printer.h
%{_includedir}/utils/PropertyMap.h
%{_includedir}/utils/RefBase.h
%{_includedir}/utils/RWLock.h
%{_includedir}/utils/SharedBuffer.h
%{_includedir}/utils/Singleton.h
%{_includedir}/utils/SortedVector.h
%{_includedir}/utils/StopWatch.h
%{_includedir}/utils/String16.h
%{_includedir}/utils/String8.h
%{_includedir}/utils/StrongPointer.h
%{_includedir}/utils/SystemClock.h
%{_includedir}/utils/ThreadDefs.h
%{_includedir}/utils/Thread.h
%{_includedir}/utils/threads.h
%{_includedir}/utils/Timers.h
%{_includedir}/utils/Tokenizer.h
%{_includedir}/utils/Trace.h
%{_includedir}/utils/TypeHelpers.h
%{_includedir}/utils/Unicode.h
%{_includedir}/utils/Vector.h
%{_includedir}/utils/VectorImpl.h
