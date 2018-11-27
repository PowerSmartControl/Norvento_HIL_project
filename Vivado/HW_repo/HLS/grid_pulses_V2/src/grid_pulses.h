// PSC | Power Smart Control | JRF | 2018

#ifndef H_grid_pulses_H
#define H_grid_pulses_H

//#include "hls_math.h"	//standard C data types
#include "hls_math.h"	//standard C data types
#include "ap_fixed.h"	//arbitrary precision data types
#include "ap_cint.h"	//arbitrary precision data types
#include <stdlib.h>
#include <stdio.h>


using namespace std;		//this namespace declaration is necessary for using Ap_fixed.h method for data type conversions



typedef  ap_fixed<21, 12, AP_RND_CONV, AP_SAT> 	AP_21_12;			//21 total bits. 12 integer bits

typedef  ap_fixed<22, 12, AP_RND_CONV, AP_SAT> 	AP_24_14;
typedef  ap_fixed<21, 13, AP_RND_CONV, AP_SAT> 	AP_21_13;

typedef  ap_fixed<21,  5, AP_RND_CONV, AP_SAT> 	AP_21_5;


typedef  ap_fixed<32, 18, AP_RND_CONV, AP_SAT> 	AP_32_18;
typedef  ap_fixed<21,  1, AP_RND_CONV, AP_SAT> 	AP_21_1;
typedef  ap_fixed<16,  1, AP_RND_CONV, AP_SAT> 	AP_16_1;
typedef  ap_fixed<30, 12, AP_RND_CONV, AP_SAT> 	AP_30_12;
typedef  ap_fixed<52, 26, AP_RND_CONV, AP_SAT> 	AP_52_26;
typedef  ap_fixed<16,  7, AP_RND_CONV, AP_SAT> 	AP_16_7;
typedef  ap_fixed<16,  3, AP_RND_CONV, AP_SAT> 	AP_16_3;
typedef  ap_fixed<30, 18, AP_RND_CONV, AP_SAT> 	AP_30_18;
typedef  ap_fixed<33, 24, AP_RND_CONV, AP_SAT> 	AP_33_24;
typedef  ap_fixed<25,  3, AP_RND_CONV, AP_SAT> 	AP_25_3;
typedef  ap_fixed<13, 13, AP_RND_CONV, AP_SAT> 	AP_13_13;
typedef  ap_fixed<34, 26, AP_RND_CONV, AP_SAT> 	AP_34_26;
typedef  ap_fixed<26, 13, AP_RND_CONV, AP_SAT> 	AP_26_13;
typedef  ap_fixed<11, 11, AP_RND_CONV, AP_SAT> 	AP_11_11;
typedef  ap_fixed<20,  1, AP_RND_CONV, AP_SAT> 	AP_20_1;
typedef  ap_fixed<15,  3, AP_RND_CONV, AP_SAT> 	AP_15_3;
typedef  ap_fixed<18,  2, AP_RND_CONV, AP_SAT> 	AP_18_2;
typedef  ap_fixed<14,  4, AP_RND_CONV, AP_SAT> 	AP_14_4;
typedef  ap_fixed<21, 11, AP_RND_CONV, AP_SAT> 	AP_21_11;
typedef  ap_fixed<46, 26, AP_RND_CONV, AP_SAT> 	AP_46_26;
typedef  ap_fixed<30, 11, AP_RND_CONV, AP_SAT> 	AP_30_11;
typedef  ap_fixed< 8,  1, AP_RND_CONV, AP_SAT> 	AP_8_1;
typedef  ap_fixed< 8,  1, AP_RND_CONV, AP_SAT> 	AP_7_1;
typedef  ap_fixed<20, 12, AP_RND_CONV, AP_SAT> 	AP_20_12;
typedef  ap_fixed<15, 4, AP_RND_CONV, AP_SAT>  	AP_15_4;
typedef  ap_fixed< 8, 8, AP_RND_CONV, AP_SAT>  	AP_8_8;

typedef  ap_fixed<23,  1, AP_RND_CONV, AP_SAT> 	AP_23_1;
typedef  ap_fixed<21, 11, AP_RND_CONV, AP_SAT> 	AP_21_11;
typedef  ap_fixed<10, 10, AP_RND_CONV, AP_SAT> 	AP_10_10;
typedef  ap_fixed<10,  2, AP_RND_CONV, AP_SAT> 	AP_10_2;
typedef  ap_fixed< 5,  5, AP_RND_CONV, AP_SAT> 	AP_5_5;
typedef  ap_fixed<18,  4, AP_RND_CONV, AP_SAT>  AP_18_4;

void top_grid_function (AP_21_13 theta_grid, AP_21_13 Ma_grid, AP_10_10 *mod_a, AP_10_10 *mod_b, AP_10_10 *mod_c, float *grid_a, float *grid_b, float *grid_c);

void grid_calculation (AP_8_8 counter_limit, AP_20_12 *grid_a, AP_20_12 *grid_b, AP_20_12 *grid_c, AP_21_11 *theta_a_deg) ;
	
AP_21_11 calc_sin_cos_2 (AP_21_11 theta_aux, bool flag);



#endif //#ifndef H_grid_pulses_H		
