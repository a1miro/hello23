set(CMAKE_SYSTEM_NAME Darwin)

# Pin the Homebrew GCC 15 toolchain for macOS 26 builds.
set(CMAKE_C_COMPILER "/usr/local/bin/gcc-15" CACHE FILEPATH "C compiler")
set(CMAKE_CXX_COMPILER "/usr/local/bin/g++-15" CACHE FILEPATH "C++ compiler")

# Use Apple binutils for Mach-O archives; GNU ar can produce misaligned members.
set(CMAKE_AR "/usr/bin/ar" CACHE FILEPATH "Archiver")
set(CMAKE_RANLIB "/usr/bin/ranlib" CACHE FILEPATH "Ranlib")

# macOS SDK 26 headers may require rsize_t when GCC 15 builds std module units.
set(CMAKE_CXX_FLAGS_INIT "-Drsize_t=size_t")