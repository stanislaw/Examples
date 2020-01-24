cmake_minimum_required(VERSION 3.13)
project(untitled1 C)

set(CMAKE_C_STANDARD 99)

add_library(static_lib STATIC static_lib.c)
add_library(dynamic_lib SHARED dynamic_lib.c)

target_link_libraries(dynamic_lib static_lib)

add_executable(untitled1 main.c)
target_link_libraries(untitled1 static_lib)

add_dependencies(untitled1 dynamic_lib)
