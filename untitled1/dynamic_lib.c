#include "dynamic_lib.h"

#include "static_lib.h"

#include <stdio.h>

void dynamic_lib_func() {
  printf("SHARED: %p %s\n", &SHARED, SHARED);
}