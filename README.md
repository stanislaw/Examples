# How to share a global variable between a main process and a dynamic library via a static library (macOS) ?

This example is a simple CMake-based C project that demonstrates that by default
there are two copies of a global variable: one in a main process and one in a
dynamic library.

## Issue

There are two copies of the `SHARED` global variable and the question is
whether it is possible to have only one `SHARED` variable shared by the main
process and the dynamic library.

## Output on macOS

```
/Users/Stanislaw/workspace/inbox-active-code/Examples/untitled1/cmake-build-debug/untitled1
Hello, World!
SHARED: 0x103f85030 123
SHARED: 0x103fa0158 (null)

Process finished with exit code 0
```
