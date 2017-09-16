# Possible bug related to LTO in LLVM 5.0.0, mac OS Sierra 10.12.6 (16G29)

## Issue

This project is a very simplified setup extracted from [openlibm](https://github.com/JuliaLang/openlibm) library:

> High quality system independent, portable, open source libm implementation http://www.openlibm.org

This repo has a function `acos`, certain calls to which seem to get shadowed by `acos` function from the standard library given the `-flto` flag is added. What is weird that there is no symmetry between compilation with and without `-flto` flag: only certain calls are shadowed while the rest still go through the custom `acos` function. For a contrast another function `custom_acos` is added - it is always called consistently with or without `-flto` flag (no shadowing occurs). 

This issue is likely to affect all of the functions from openlibm library which interfere with the their corresponding functions from math.h.

Important observation: valid inputs for acos function from the standard library are within range [-1, 1], for all other inputs it produces `nan`. In the logs for `-flto` below the calls of this function with invalid inputs like `nan`, `-1.1`, `1.1` do not get shadowed!

## Setup

```makefile
CC:=/opt/llvm-5.0.0/bin/clang
CFLAGS:=-O0 -g -flto -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk # with -flto the results look weird
# CFLAGS:=-O0 -g -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk # without -flto the results look consistent
```

## Running with -flto

```
$ make
rm -rfv *.o
lib.o
rm -rfv *.dylib
libStan.dylib
rm -rfv main
main
/opt/llvm-5.0.0/bin/clang -O0 -g -flto -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk  -c lib.c -o lib.o
/opt/llvm-5.0.0/bin/clang -shared lib.o -o libStan.dylib
/opt/llvm-5.0.0/bin/clang -O0 -g -flto -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk  -L./ -lStan main.c -o main
./main
__ieee754_acos is called: nan
check_acos: nan nan
__ieee754_acos is called: 1.100000
check_acos: 1.100000 1.100000
__ieee754_acos is called: -1.100000
check_acos: -1.100000 -1.100000
check_acos: 0.000000 1.570796
check_acos: 0.000000 1.570796
check_acos: 1.000000 0.000000
check_acos: -1.000000 3.141593
check_acos: 0.500000 1.047198
check_acos: -0.500000 2.094395
check_acos: 0.700000 0.795399
check_acos: 0.700000 0.795399
__ieee754_custom_acos is called: nan
check_custom_acos: nan nan
__ieee754_custom_acos is called: 1.100000
check_custom_acos: 1.100000 1.100000
__ieee754_custom_acos is called: -1.100000
check_custom_acos: -1.100000 -1.100000
__ieee754_custom_acos is called: 0.000000
check_custom_acos: 0.000000 0.000000
__ieee754_custom_acos is called: 0.000000
check_custom_acos: 0.000000 0.000000
__ieee754_custom_acos is called: 1.000000
check_custom_acos: 1.000000 1.000000
__ieee754_custom_acos is called: -1.000000
check_custom_acos: -1.000000 -1.000000
__ieee754_custom_acos is called: 0.500000
check_custom_acos: 0.500000 0.500000
__ieee754_custom_acos is called: -0.500000
check_custom_acos: -0.500000 -0.500000
__ieee754_custom_acos is called: 0.700000
check_custom_acos: 0.700000 0.700000
__ieee754_custom_acos is called: 0.700000
check_custom_acos: 0.700000 0.700000
```

## Running without -flto

```
$ make
rm -rfv *.o
lib.o
rm -rfv *.dylib
libStan.dylib
rm -rfv main
main
/opt/llvm-5.0.0/bin/clang -O0 -g -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk  -c lib.c -o lib.o
/opt/llvm-5.0.0/bin/clang -shared lib.o -o libStan.dylib
/opt/llvm-5.0.0/bin/clang -O0 -g -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk  -L./ -lStan main.c -o main
./main
__ieee754_acos is called: nan
check_acos: nan nan
__ieee754_acos is called: 1.100000
check_acos: 1.100000 1.100000
__ieee754_acos is called: -1.100000
check_acos: -1.100000 -1.100000
__ieee754_acos is called: 0.000000
check_acos: 0.000000 0.000000
__ieee754_acos is called: 0.000000
check_acos: 0.000000 0.000000
__ieee754_acos is called: 1.000000
check_acos: 1.000000 1.000000
__ieee754_acos is called: -1.000000
check_acos: -1.000000 -1.000000
__ieee754_acos is called: 0.500000
check_acos: 0.500000 0.500000
__ieee754_acos is called: -0.500000
check_acos: -0.500000 -0.500000
__ieee754_acos is called: 0.700000
check_acos: 0.700000 0.700000
__ieee754_acos is called: 0.700000
check_acos: 0.700000 0.700000
__ieee754_custom_acos is called: nan
check_custom_acos: nan nan
__ieee754_custom_acos is called: 1.100000
check_custom_acos: 1.100000 1.100000
__ieee754_custom_acos is called: -1.100000
check_custom_acos: -1.100000 -1.100000
__ieee754_custom_acos is called: 0.000000
check_custom_acos: 0.000000 0.000000
__ieee754_custom_acos is called: 0.000000
check_custom_acos: 0.000000 0.000000
__ieee754_custom_acos is called: 1.000000
check_custom_acos: 1.000000 1.000000
__ieee754_custom_acos is called: -1.000000
check_custom_acos: -1.000000 -1.000000
__ieee754_custom_acos is called: 0.500000
check_custom_acos: 0.500000 0.500000
__ieee754_custom_acos is called: -0.500000
check_custom_acos: -0.500000 -0.500000
__ieee754_custom_acos is called: 0.700000
check_custom_acos: 0.700000 0.700000
__ieee754_custom_acos is called: 0.700000
check_custom_acos: 0.700000 0.700000
```

