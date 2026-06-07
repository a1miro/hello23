cmake_minimum_required(VERSION 3.30 FATAL_ERROR)

# 1. Enable experimental `import std` support for this CMake version.
# This must be set before project() enables CXX.
set(CMAKE_EXPERIMENTAL_CXX_IMPORT_STD "451f2fe2-a8a2-47c3-bc32-94786d8fc91b")

# 2. Tell CMake to initialize the project, but explicitly list LANGUAGES CXX here
project(Cpp23PrintArray LANGUAGES CXX)

# Export compile commands so IDE language servers can pick up C++23 flags.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# 3. Request automatic management of C++23 standard library modules
set(CMAKE_CXX_MODULE_STD ON)

# GCC on macOS SDK 26 may expose C11 Annex K declarations that require rsize_t
# during std module compilation. This alias unblocks GCC's `import std` build.
if(APPLE AND CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    string(APPEND CMAKE_CXX_FLAGS " -Drsize_t=size_t")

    # Use Apple binutils for Mach-O archives; GNU ar can produce misaligned members.
    set(CMAKE_AR /usr/bin/ar)
    set(CMAKE_RANLIB /usr/bin/ranlib)
endif()

# 4. Define the executable target
add_executable(print_array_demo)

target_sources(print_array_demo 
    PRIVATE 
        main.cpp
)

# Enforce C++23 features
target_compile_features(print_array_demo PRIVATE cxx_std_23)

# Ensure CMake scans the source code to map the dependencies of 'import std;'
set_target_properties(print_array_demo PROPERTIES CXX_SCAN_FOR_MODULES ON)