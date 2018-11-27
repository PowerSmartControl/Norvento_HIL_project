// PSC | Power Smart Control | JRF | 2018

#ifndef H_PMSM_H
#define H_PMSM_H

//#include "hls_math.h"	//standard C data types
#include "ap_fixed.h"	//arbitrary precision data types
using namespace std;		//this namespace declaration is necessary for using Ap_fixed.h method for data type conversions



typedef  ap_fixed<21, 12, AP_RND_CONV, AP_SAT> 	AP_21_12;			//21 total bits. 12 integer bits
typedef  ap_fixed<32, 18, AP_RND_CONV, AP_SAT> 	AP_32_18;
typedef  ap_fixed<21, 20, AP_RND_CONV, AP_SAT> 	AP_21_20;
typedef  ap_fixed<21,  1, AP_RND_CONV, AP_SAT> 	AP_21_1;
typedef  ap_fixed< 6,  5, AP_RND_CONV, AP_SAT> 	AP_6_5;
typedef  ap_fixed<30, 18, AP_RND_CONV, AP_SAT> 	AP_30_18;
typedef  ap_fixed<30,  2, AP_RND_CONV, AP_SAT> 	AP_30_2;
typedef  ap_fixed<32, 16, AP_RND_CONV, AP_SAT> 	AP_32_16;
typedef  ap_fixed<21, 13, AP_RND_CONV, AP_SAT> 	AP_21_13;
typedef  ap_fixed<16,  7, AP_RND_CONV, AP_SAT> 	AP_16_7;
typedef  ap_fixed<21, 13, AP_RND_CONV, AP_SAT> 	AP_21_13;





void wind_turb (
		AP_32_18 Tem, AP_21_20 P_wind,
		AP_32_18 *Wn);
		
#endif //#ifndef H_PMSM_H		
