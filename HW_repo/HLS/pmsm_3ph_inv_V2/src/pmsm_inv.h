// PSC | Power Smart Control | JRF | 2018

#ifndef H_PMSM_INV_H
#define H_PMSM_INV_H

//#include "hls_math.h"	//standard C data types
#include "ap_fixed.h"	//arbitrary precision data types
using namespace std;		//this namespace declaration is necessary for using Ap_fixed.h method for data type conversions



typedef  ap_fixed<21, 12, AP_RND_CONV, AP_SAT> 	AP_21_12;			//21 total bits. 12 integer bits
typedef  ap_fixed<21, 13, AP_RND_CONV, AP_SAT> 	AP_21_13;
typedef  ap_fixed<22,  1, AP_RND_CONV, AP_SAT> 	AP_22_1;




void bridge3ph (
		bool T1, bool T2,
		bool T3, bool T4,
		bool T5, bool T6,
		float Vdc_f,
		AP_21_13 Ia, AP_21_13 Ib, AP_21_13 Ic,
		AP_21_13 *Va, AP_21_13 *Vb, AP_21_13 *Vc,
		float *Idc,
		AP_21_13 *Vn_gnd);

#endif //#ifndef H_PMSM_INV_H
