// PSC | Power Smart Control | JRF | 2018

#include "float_conversor.h"

void float_conversor (
		int13 in_1, int13 in_2, int13 in_3, int13 in_4, int13 in_5, int13 in_6,
		float *out_1, float *out_2, float *out_3, float *out_4, float *out_5, float *out_6
){
	*out_1 = (float) in_1;
	*out_2 = (float) in_2;
	*out_3 = (float) in_3;
	*out_4 = (float) in_4;
	*out_5 = (float) in_5;
	*out_6 = (float) in_6;

}

