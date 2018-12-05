// PSC | Power Smart Control | JRF | 2018

#ifndef H_LCL_FILTER_H
#define H_LCL_FILTER_H

#include "ap_fixed.h"	//arbitrary precision data types
using namespace std;		//this namespace declaration is necessary for using Ap_fixed.h method for data type conversions

typedef  ap_fixed<21, 12, AP_TRN_ZERO, AP_SAT> 	AP_21_12;			//21 total bits. 12 integer bits
typedef  ap_fixed<18, 12, AP_TRN_ZERO, AP_SAT> 	AP_18_12;			//18 total bits. 12 integer bits
typedef  ap_fixed<16, 9, AP_TRN_ZERO, AP_SAT> 	AP_16_9;			//16 total bits. 7 integer bits
typedef  ap_fixed<16, 7, AP_TRN_ZERO, AP_SAT> 	AP_16_7;			//16 total bits. 7 integer bits
typedef  ap_fixed<16, 3, AP_TRN_ZERO, AP_SAT>	AP_16_3;			//16 total bits. 3 integer bits
typedef  ap_fixed<40, 12, AP_TRN_ZERO, AP_SAT>	AP_40_12;			//40 total bits. 12 integer bits
typedef  ap_fixed<47, 21, AP_TRN_ZERO, AP_SAT>	AP_47_21;			//47 total bits. 21 integer bits
typedef  ap_fixed<52, 26, AP_TRN_ZERO, AP_SAT>	AP_52_26;			//47 total bits. 21 integer bits
typedef  ap_fixed<21, 16, AP_TRN_ZERO, AP_SAT>	AP_21_16;			//47 total bits. 21 integer bits
typedef  ap_fixed<25, 16, AP_TRN_ZERO, AP_SAT>	AP_25_16;			//47 total bits. 21 integer bits
typedef  ap_fixed<27, 18, AP_TRN_ZERO, AP_SAT>	AP_27_18;			//47 total bits. 21 integer bits


typedef  ap_fixed<13, 5, AP_TRN_ZERO, AP_SAT> 	AP_13_5;			//21 total bits. 12 integer bits
typedef  ap_fixed<12, 4, AP_TRN_ZERO, AP_SAT> 	AP_12_4;
typedef  ap_fixed<10, 2, AP_TRN_ZERO, AP_SAT> 	AP_10_2;
typedef  ap_fixed<14, 4, AP_TRN_ZERO, AP_SAT> 	AP_14_4;
typedef  ap_fixed<18,11, AP_TRN_ZERO, AP_SAT> 	AP_18_11;
typedef  ap_fixed<16, 7, AP_TRN_ZERO, AP_SAT> 	AP_16_7;
typedef  ap_fixed<25,16, AP_TRN_ZERO, AP_SAT>	AP_25_16;
typedef  ap_fixed<16, 1, AP_TRN_ZERO, AP_SAT> 	AP_16_1;
typedef  ap_fixed< 4, 1, AP_TRN_ZERO, AP_SAT> 	AP_4_1;
typedef  ap_fixed< 2, 1, AP_TRN_ZERO, AP_SAT> 	AP_2_1;
typedef  ap_fixed< 8, 7, AP_TRN_ZERO, AP_SAT> 	AP_8_7;
typedef  ap_fixed< 3, 3, AP_TRN_ZERO, AP_SAT>	AP_3_3;
typedef  ap_fixed< 8, 1, AP_TRN_ZERO, AP_SAT>	AP_8_1;
typedef  ap_fixed<26, 1, AP_TRN_ZERO, AP_SAT>	AP_26_1;
typedef  ap_fixed<22,21, AP_TRN_ZERO, AP_SAT>	AP_22_21;
typedef  ap_fixed<15, 1, AP_TRN_ZERO, AP_SAT>	AP_15_1;
typedef  ap_fixed<10, 1, AP_TRN_ZERO, AP_SAT>	AP_10_1;
typedef  ap_fixed<20, 1, AP_TRN_ZERO, AP_SAT>	AP_20_1;
typedef  ap_fixed<28, 1, AP_TRN_ZERO, AP_SAT>	AP_28_1;




typedef  ap_fixed<21, 12, AP_TRN_ZERO, AP_SAT> 	AP_21_12;			//21 total bits. 12 integer bits
typedef  ap_fixed<18, 12, AP_TRN_ZERO, AP_SAT> 	AP_18_12;
typedef  ap_fixed<16,  9, AP_TRN_ZERO, AP_SAT> 	AP_16_9;
//typedef  ap_fixed<16,  7, AP_TRN_ZERO, AP_SAT> 	AP_16_7;
typedef  ap_fixed<16,  3, AP_TRN_ZERO, AP_SAT>	AP_16_3;
typedef  ap_fixed<40, 12, AP_TRN_ZERO, AP_SAT>	AP_40_12;
typedef  ap_fixed<47, 21, AP_TRN_ZERO, AP_SAT>	AP_47_21;
typedef  ap_fixed<52, 26, AP_TRN_ZERO, AP_SAT>	AP_52_26;
typedef  ap_fixed<21, 16, AP_TRN_ZERO, AP_SAT>	AP_21_16;

typedef  ap_fixed<27, 18, AP_TRN_ZERO, AP_SAT>	AP_27_18;

typedef  ap_fixed<21, 20, AP_TRN_ZERO, AP_SAT>	AP_21_20;
typedef  ap_fixed<30, 18, AP_TRN_ZERO, AP_SAT>	AP_30_18;
typedef  ap_fixed< 6,  5, AP_TRN_ZERO, AP_SAT>	AP_6_5;
typedef  ap_fixed<19,  1, AP_TRN_ZERO, AP_SAT>	AP_19_1;
typedef  ap_fixed< 2,  1, AP_TRN_ZERO, AP_SAT>	AP_2_1;
typedef  ap_fixed< 26,  1, AP_TRN_ZERO, AP_SAT>	AP_26_1;
typedef  ap_fixed<39, 26, AP_TRN_ZERO, AP_SAT>	AP_39_26;
typedef  ap_fixed<52, 28, AP_TRN_ZERO, AP_SAT>	AP_52_28;
typedef  ap_fixed<31, 21, AP_TRN_ZERO, AP_SAT>	AP_31_21;
typedef  ap_fixed<32, 25, AP_TRN_ZERO, AP_SAT>	AP_32_25;
typedef  ap_fixed<3, 3, AP_TRN_ZERO, AP_SAT>	APu_3_3;
typedef  ap_fixed<32, 6, AP_TRN_ZERO, AP_SAT>	AP_32_6;
typedef  ap_fixed<11, 1, AP_TRN_ZERO, AP_SAT>	AP_11_1;
typedef  ap_fixed< 6, 1, AP_TRN_ZERO, AP_SAT>	AP_6_1;
typedef  ap_fixed<30,23, AP_TRN_ZERO, AP_SAT>	AP_30_23;
typedef  ap_fixed<27, 1, AP_TRN_ZERO, AP_SAT>	AP_27_1;
typedef  ap_fixed< 5, 5, AP_TRN_ZERO, AP_SAT>	AP_5_5;
typedef  ap_fixed<36,16, AP_TRN_ZERO, AP_SAT>	AP_36_16;
typedef  ap_fixed<60,30, AP_TRN_ZERO, AP_SAT>	AP_60_30;
typedef  ap_fixed<32, 1, AP_TRN_ZERO, AP_SAT>	AP_32_1;
typedef  ap_fixed< 7, 1, AP_TRN_ZERO, AP_SAT>	AP_7_1;

//typedef  ap_fixed< 32, 12, AP_RND_CONV, AP_SAT>	AP_32_12;
typedef  ap_fixed< 60, 20, AP_RND_CONV, AP_SAT>	AP_32_12;


//typedef ap_fixed<16,2, AP_RND, AP_SAT> trig_typ;
//typedef ap_fixed<16,5, AP_RND, AP_SAT> scp_typ;

void lcl_filter (
		AP_32_12 V1_a, AP_32_12 V1_b, AP_32_12 V1_c,
		AP_32_12 V2_a_, AP_32_12 V2_b_, AP_32_12 V2_c_,
		AP_32_12 VN_gnd,
		AP_16_1 dT_L1, AP_16_1 dT_L2, AP_16_1 dT_C, AP_31_21 rC, AP_30_23 rL1_NC, AP_30_23 rL2, AP_32_25 Preload,
		AP_5_5 CB1_K1_K3,
		AP_32_12 *IL1_a_r, AP_32_12 *IL1_b_r, AP_32_12 *IL1_c_r,
		AP_32_12 *IL2_a_r, AP_32_12 *IL2_b_r, AP_32_12 *IL2_c_r,
		AP_32_12 *Vp_a_r, AP_32_12 *Vp_b_r, AP_32_12 *Vp_c_r

);


#endif //#ifndef H_LCL_FILTER_H
