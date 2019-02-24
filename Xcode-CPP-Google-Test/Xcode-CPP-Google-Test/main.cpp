//
//  main.cpp
//  Xcode-CPP-Google-Test
//
//  Created by Stanislav Pankevich on 24.02.19.
//  Copyright © 2019 Stanislav Pankevich. All rights reserved.
//

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
