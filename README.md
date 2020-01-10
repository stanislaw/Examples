# Linking a dynamic library that links in symbols from a static library (macOS vs Linux)

This example is a simple CMake-based C project that demonstrates the difference in how dynamic linking works on macOS compared to Linux.

## Setup

The setup is as follows:

- Minimal C program with a main() function
- Dynamic library with one function
- Static library with one function
- The program calls a function from the dynamic library. The dynamic library is of course linked dynamically to the program.
- The dynamic library calls a function from the static library. The static library is linked statically to the dynamic library.

## Issue

If we stop linking the static library to dynamic library:

```
# This target_link_libraries is intentionally commented out.
#target_link_libraries(dynamic_lib static_lib)
```

we of course get errors when building a program. But the errors are different 
on macOS and Linux:

- macOS fails earlier at the step when the dynamic library gets linked
- Linux fails later at the step when the program gets linked

## Output on macOS

```
====================[ Build | untitled1 | Debug ]===============================
/Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake --build /Users/stanislaw/workspace/code/Examples/untitled1/cmake-build-debug --target untitled1 -- -j 2
/Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake -S/Users/stanislaw/workspace/code/Examples/untitled1 -B/Users/stanislaw/workspace/code/Examples/untitled1/cmake-build-debug --check-build-system CMakeFiles/Makefile.cmake 0
/Library/Developer/CommandLineTools/usr/bin/make -f CMakeFiles/Makefile2 untitled1
/Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake -S/Users/stanislaw/workspace/code/Examples/untitled1 -B/Users/stanislaw/workspace/code/Examples/untitled1/cmake-build-debug --check-build-system CMakeFiles/Makefile.cmake 0
/Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake -E cmake_progress_start /Users/stanislaw/workspace/code/Examples/untitled1/cmake-build-debug/CMakeFiles 4
/Library/Developer/CommandLineTools/usr/bin/make -f CMakeFiles/Makefile2 CMakeFiles/untitled1.dir/all
/Library/Developer/CommandLineTools/usr/bin/make -f CMakeFiles/dynamic_lib.dir/build.make CMakeFiles/dynamic_lib.dir/depend
cd /Users/stanislaw/workspace/code/Examples/untitled1/cmake-build-debug && /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake -E cmake_depends "Unix Makefiles" /Users/stanislaw/workspace/code/Examples/untitled1 /Users/stanislaw/workspace/code/Examples/untitled1 /Users/stanislaw/workspace/code/Examples/untitled1/cmake-build-debug /Users/stanislaw/workspace/code/Examples/untitled1/cmake-build-debug /Users/stanislaw/workspace/code/Examples/untitled1/cmake-build-debug/CMakeFiles/dynamic_lib.dir/DependInfo.cmake --color=
/Library/Developer/CommandLineTools/usr/bin/make -f CMakeFiles/dynamic_lib.dir/build.make CMakeFiles/dynamic_lib.dir/build
[ 25%] Building C object CMakeFiles/dynamic_lib.dir/dynamic_lib.c.o
/Library/Developer/CommandLineTools/usr/bin/cc -Ddynamic_lib_EXPORTS  -g -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk -fPIC   -fPIC -std=gnu99 -o CMakeFiles/dynamic_lib.dir/dynamic_lib.c.o   -c /Users/stanislaw/workspace/code/Examples/untitled1/dynamic_lib.c
[ 50%] Linking C shared library libdynamic_lib.dylib
/Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake -E cmake_link_script CMakeFiles/dynamic_lib.dir/link.txt --verbose=1
/Library/Developer/CommandLineTools/usr/bin/cc -g -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk -dynamiclib -Wl,-headerpad_max_install_names  -o libdynamic_lib.dylib -install_name @rpath/libdynamic_lib.dylib CMakeFiles/dynamic_lib.dir/dynamic_lib.c.o 
Undefined symbols for architecture x86_64:
  "_static_lib_func", referenced from:
      _dynamic_lib_func in dynamic_lib.c.o
ld: symbol(s) not found for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make[3]: *** [libdynamic_lib.dylib] Error 1
make[2]: *** [CMakeFiles/dynamic_lib.dir/all] Error 2
make[1]: *** [CMakeFiles/untitled1.dir/rule] Error 2
make: *** [untitled1] Error 2
```

## Output on Linux

```c
root@f2a745e8070d:/app/build.docccker# make
-- Configuring done
-- Generating done
-- Build files have been written to: /app/build.docccker
Scanning dependencies of target dynamic_lib
[ 16%] Linking C shared library libdynamic_lib.so
[ 33%] Built target dynamic_lib
Scanning dependencies of target untitled1
[ 50%] Linking C executable untitled1
libdynamic_lib.so: undefined reference to `static_lib_func'
collect2: error: ld returned 1 exit status
CMakeFiles/untitled1.dir/build.make:84: recipe for target 'untitled1' failed
make[2]: *** [untitled1] Error 1
CMakeFiles/Makefile2:77: recipe for target 'CMakeFiles/untitled1.dir/all' failed
make[1]: *** [CMakeFiles/untitled1.dir/all] Error 2
Makefile:83: recipe for target 'all' failed
make: *** [all] Error 2
```

