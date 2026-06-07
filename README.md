# C++23 `import std` Demo (macOS + GCC 15 + CMake)

This project demonstrates C++23 `import std;` using CMake module support.

## Prerequisites

- macOS with Xcode Command Line Tools installed
- CMake 4.3+
- Ninja
- Homebrew GCC 15 (`g++-15`)

Check tools:

```bash
cmake --version
ninja --version
g++-15 --version
```

## Build (verified)

Configure with GCC 15 and Ninja:

```bash
cmake -S . -B build -G Ninja -DCMAKE_CXX_COMPILER=/usr/local/bin/g++-15
```

Build:

```bash
cmake --build build -v
```

Run:

```bash
./build/print_array_demo
```

## Why this works on macOS

`import std` is still experimental in CMake and requires:

- Experimental gate variable set before `project()`
- A generator/toolchain that supports C++ module dependency scanning (Ninja in this setup)

On macOS SDK 26 with Homebrew GCC 15, two additional issues were observed and handled in `CMakeLists.txt`:

1. SDK header `rsize_t` error while building standard library module units.
- Workaround: add `-Drsize_t=size_t` for GNU C++ on Apple platforms.

2. Link/archive failure from GNU `ar` (`not 8-byte aligned in ...a`) for Mach-O archives.
- Workaround: force `/usr/bin/ar` and `/usr/bin/ranlib`.

These workarounds are applied conditionally for `APPLE` + `GNU` in `CMakeLists.txt`.

## Troubleshooting

If configure fails with `CXX_MODULE_STD` errors:

1. Make sure you are using Ninja (`-G Ninja`).
2. Make sure `g++-15` is selected.
3. Reconfigure from a fresh build directory if toolchain settings changed.

Example fresh configure:

```bash
rm -rf build
cmake -S . -B build -G Ninja -DCMAKE_CXX_COMPILER=/usr/local/bin/g++-15
```
