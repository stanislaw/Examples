#include "dynamic_lib.h"

#include <assert.h>
#include <dlfcn.h>
#include <stdio.h>

extern char *SHARED;

int main() {
  printf("Hello, World!\n");

  SHARED = "123";
  printf("SHARED: %p %s\n", &SHARED, SHARED);

  void *handle = dlopen("libdynamic_lib.dylib", 0);
  assert(handle != NULL);

  void *sym = dlsym(handle, "dynamic_lib_func");
  assert(sym != NULL);

  ((void (*)(void))sym)();

  return 0;
}