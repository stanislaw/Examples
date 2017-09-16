#include <stdio.h>

#import "lib_private.h"

double __ieee754_acos(double x) {
 	printf("__ieee754_acos is called: %f\n", x);
  return x;
}

double __ieee754_custom_acos(double x) {
		printf("__ieee754_custom_acos is called: %f\n", x);
  return x;
}
