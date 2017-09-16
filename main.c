#include <stdio.h>

#include "lib.h"

void check_acos(double input, double output) {
	 printf("check_acos: %f %f\n", input, output);
}
void check_custom_acos(double input, double output) {
	 printf("check_custom_acos: %f %f\n", input, output);
}

void acos_test() {
	 double nan = 0.0 / 0.0;

	 check_acos(nan, acos(nan));
	 check_acos(1.1L, acos(1.1L));
	 check_acos(-1.1L, acos(-1.1L));
	 check_acos(0, acos(0));
	 check_acos(-0, acos(-0));
	 check_acos(1, acos(1));
	 check_acos(-1, acos(-1));
	 check_acos(0.5, acos(0.5));
	 check_acos(-0.5, acos(-0.5));
	 check_acos(0.7, acos(0.7));
	 check_acos(0.7L, acos(0.7L));

	 check_custom_acos(nan, custom_acos(nan));
	 check_custom_acos(1.1L, custom_acos(1.1L));
	 check_custom_acos(-1.1L, custom_acos(-1.1L));
	 check_custom_acos(0, custom_acos(0));
	 check_custom_acos(-0, custom_acos(-0));
	 check_custom_acos(1, custom_acos(1));
	 check_custom_acos(-1, custom_acos(-1));
	 check_custom_acos(0.5, custom_acos(0.5));
	 check_custom_acos(-0.5L, custom_acos(-0.5));
	 check_custom_acos(0.7, custom_acos(0.7));
	 check_custom_acos(0.7L, custom_acos(0.7L));
}

int main (int argc, char **argv) {

	 acos_test();

 	return 0;
}
