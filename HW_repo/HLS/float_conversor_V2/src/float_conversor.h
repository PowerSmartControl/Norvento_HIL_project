// PSC | Power Smart Control | JRF | 2018

#ifndef H_float_conversor_H
#define H_float_conversor_H

#include "hls_math.h"	//standard C data types
#include "ap_fixed.h"	//arbitrary precision data types
#include "ap_cint.h"	//arbitrary precision data types

using namespace std;		//this namespace declaration is necessary for using Ap_fixed.h method for data type conversions


void float_conversor (
		int12 in_1, int12 in_2, int12 in_3, int12 in_4, int12 in_5, int12 in_6,
		float *out_1, float *out_2, float *out_3, float *out_4, float *out_5, float *out_6
);


#endif //#ifndef H_float_conversor_H
