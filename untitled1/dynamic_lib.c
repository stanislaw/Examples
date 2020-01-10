#include "dynamic_lib.h"

#include "static_lib.h"

#include <assert.h>

void dynamic_lib_func() {
  static_lib_func();
  assert(0);
}