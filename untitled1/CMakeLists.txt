cmake_minimum_required(VERSION 3.14)
project(untitled1 C)

add_compile_options("-fPIC")

set(CMAKE_C_STANDARD 99)

add_library(static_lib static_lib.c)
add_library(dynamic_lib SHARED dynamic_lib.c)

# THE ISSUE IS HERE:
# This target_link_libraries is intentionally commented out.
# on macOS the build process fails when linking dynamic_lib
# on Linux the build process fails when linking the
# 'untitled1' program.
#target_link_libraries(dynamic_lib static_lib)

add_executable(untitled1 main.c)
target_link_libraries(untitled1 dynamic_lib)

