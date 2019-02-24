# Xcode, C++, GoogleTest: "hello world" project

The example project can be found in `Xcode-CPP-Google-Test` folder.

## Issue

How to setup a blank Xcode C++ project that has unit tests based on Google Test.

Source:
[Unit - тесты для C++ и Xcode [требует правки] (Russian StackOverflow)](https://ru.stackoverflow.com/questions/948179/unit-%d1%82%d0%b5%d1%81%d1%82%d1%8b-%d0%b4%d0%bb%d1%8f-c-%d0%b8-xcode)

**Note:** While this example is very simple and works, normally people setup
CMake for their project to make sure they are not bound to Xcode as the only
IDE. Go ahead and read about using C++ with CMake.

## Steps

- Create blank Xcode C++ command-line project
- Copy the Google Test files to the project, don't forget to add them to the
target so that they are compiled. The example project in this repository
has them copied to `googletest` folder.
- Add `googletest` and `googletest/include` folders to the header search paths
as shown on the screenshot [screenshot 1](Screenshot-1-header-search-paths.png)

**If you don't include these headers, you will get "gtest/gtest.h not found"
errors**.

- Add the following lines to you main.cpp file:

```cpp
#include "gtest/gtest.h"

#include <iostream>

TEST(Hello, World) {
  EXPECT_TRUE(true);
}

int main(int argc, char **argv) {
  printf("Running main() from %s\n", __FILE__);
  testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
```

- Exclude files `gtest_main.cc` and `gtest-all.cc` files from your target
so that they are not compiled. You don't need those files because we provide
our own `main` function that calls `InitGoogleTest` and then `RUN_ALL_TESTS()`.
See [screenshot 2](Screenshot-2-uncheck-gt-main-and-all.png)

**If you don't exclude these files, you will get duplicate linker errors**.

Checkout the example project in this repository and then try to replicate
this steps using you own project.
