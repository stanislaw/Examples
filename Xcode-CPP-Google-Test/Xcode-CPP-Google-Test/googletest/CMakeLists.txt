message(STATUS "googletest> Creating google-test target...")

set(google_test_include_dirs
        "${CMAKE_CURRENT_SOURCE_DIR}"
        "${CMAKE_CURRENT_SOURCE_DIR}/include")

file(GLOB_RECURSE google_test_headers ${CMAKE_CURRENT_SOURCE_DIR}/*.h)

set(google_test_sources src/gtest-all.cc)

add_library(google-test STATIC ${google_test_sources} ${google_test_headers})
target_compile_options(google-test PUBLIC ${PTS_C_FLAGS} ${PTS_CXX_FLAGS} ${PTS_HW_FLAGS})

target_include_directories(google-test PUBLIC ${google_test_include_dirs})
