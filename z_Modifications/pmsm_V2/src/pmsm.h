// PSC | Power Smart Control | JRF | 2018

#ifndef H_PMSM_H
#define H_PMSM_H

//#include "hls_math.h"	//standard C data types
#include "hls_math.h"	//standard C data types
#include "ap_fixed.h"	//arbitrary precision data types
#include "ap_cint.h"	//arbitrary precision data types
#include <stdlib.h>
#include <stdio.h>


using namespace std;		//this namespace declaration is necessary for using Ap_fixed.h method for data type conversions


/*
typedef  ap_fixed <21, 11> 	AP_21_11;
typedef  ap_fixed <18,  2> 	AP_18_2;
typedef  ap_fixed <22, 12> 	AP_24_14;
typedef  ap_fixed <18, 11>  AP_18_11;
typedef  ap_fixed <30, 11>  AP_30_11;
typedef  ap_fixed <26, 12>  AP_26_12;
typedef  ap_fixed <17,  7>  AP_17_7;
typedef  ap_fixed <16,  1> 	AP_16_1;
typedef  ap_fixed <21, 13> 	AP_21_13;
typedef  ap_fixed <15,  4> 	AP_15_4;
typedef  ap_fixed < 8,  8> 	AP_8_8;

*/
typedef  ap_fixed <21, 13, AP_TRN> 	AP_21_13;
typedef  ap_fixed <16,  1, AP_TRN> 	AP_16_1;
typedef  ap_fixed <20,  1, AP_TRN> 	AP_20_1;
typedef  ap_fixed <26, 12, AP_TRN>  AP_26_12;
typedef  ap_fixed <15,  4, AP_TRN> 	AP_15_4;

typedef  ap_fixed <24, 11, AP_TRN> 	AP_21_11;
typedef  ap_fixed <21,  2, AP_TRN> 	AP_18_2;
typedef  ap_fixed <27, 14, AP_TRN> 	AP_24_14;
typedef  ap_fixed <21, 11, AP_TRN>  AP_18_11;
typedef  ap_fixed <33, 11, AP_TRN>  AP_30_11;
typedef  ap_fixed <20,  7, AP_TRN>  AP_17_7;
typedef  ap_fixed < 8,  8, AP_TRN> 	AP_8_8;

typedef  ap_fixed <24, 12, AP_TRN> 	AP_21_12;			//21 total bits. 12 integer bits
typedef  ap_fixed <24,  5, AP_TRN> 	AP_21_5;
typedef  ap_fixed <35, 18, AP_TRN> 	AP_32_18;
typedef  ap_fixed <24,  1, AP_TRN> 	AP_21_1;
typedef  ap_fixed <33, 12, AP_TRN> 	AP_30_12;
typedef  ap_fixed <55, 26, AP_TRN> 	AP_52_26;
typedef  ap_fixed <19,  7, AP_TRN> 	AP_16_7;
typedef  ap_fixed <19,  3, AP_TRN> 	AP_16_3;
typedef  ap_fixed <33, 18, AP_TRN> 	AP_30_18;
typedef  ap_fixed <36, 24, AP_TRN> 	AP_33_24;
typedef  ap_fixed <28,  3, AP_TRN> 	AP_25_3;
typedef  ap_fixed <16, 13, AP_TRN> 	AP_13_13;
typedef  ap_fixed <37, 26, AP_TRN> 	AP_34_26;
typedef  ap_fixed <29, 13, AP_TRN> 	AP_26_13;
typedef  ap_fixed <14, 11, AP_TRN> 	AP_11_11;
typedef  ap_fixed <18,  3, AP_TRN> 	AP_15_3;
typedef  ap_fixed <20,  4, AP_TRN> 	AP_17_4;
typedef  ap_fixed <49, 26, AP_TRN> 	AP_46_26;
typedef  ap_fixed <11,  1, AP_TRN> 	AP_8_1;
typedef  ap_fixed <10,  1, AP_TRN> 	AP_7_1;
typedef  ap_fixed <23, 12, AP_TRN> 	AP_20_12;
typedef  ap_fixed <32, 18, AP_TRN>  AP_29_18;
typedef  ap_fixed < 6,  1, AP_TRN>  AP_3_1;
typedef  ap_fixed <21,  5, AP_TRN>  AP_18_5;


/*
typedef  ap_fixed<21, 12, AP_RND_CONV, AP_SAT> 	AP_21_12;			//21 total bits. 12 integer bits
typedef  ap_fixed<22, 12, AP_RND_CONV, AP_SAT> 	AP_24_14;
typedef  ap_fixed<21, 13, AP_RND_CONV, AP_SAT> 	AP_21_13;
typedef  ap_fixed<21,  5, AP_RND_CONV, AP_SAT> 	AP_21_5;
typedef  ap_fixed<32, 18, AP_TRN, AP_SAT> 	AP_32_18;
typedef  ap_fixed<21,  1, AP_TRN, AP_SAT> 	AP_21_1;
typedef  ap_fixed<16,  1, AP_TRN, AP_SAT> 	AP_16_1;
typedef  ap_fixed<30, 12, AP_TRN, AP_SAT> 	AP_30_12;
typedef  ap_fixed<52, 26, AP_TRN, AP_SAT> 	AP_52_26;
typedef  ap_fixed<16,  7, AP_TRN, AP_SAT> 	AP_16_7;
typedef  ap_fixed<16,  3, AP_TRN, AP_SAT> 	AP_16_3;
typedef  ap_fixed<30, 18, AP_TRN, AP_SAT> 	AP_30_18;
typedef  ap_fixed<33, 24, AP_TRN, AP_SAT> 	AP_33_24;
typedef  ap_fixed<25,  3, AP_TRN, AP_SAT> 	AP_25_3;
typedef  ap_fixed<13, 13, AP_TRN, AP_SAT> 	AP_13_13;
typedef  ap_fixed<34, 26, AP_TRN, AP_SAT> 	AP_34_26;
typedef  ap_fixed<26, 13, AP_TRN, AP_SAT> 	AP_26_13;
typedef  ap_fixed<11, 11, AP_TRN, AP_SAT> 	AP_11_11;
typedef  ap_fixed<20,  1, AP_TRN, AP_SAT> 	AP_20_1;
typedef  ap_fixed<15,  3, AP_TRN, AP_SAT> 	AP_15_3;
typedef  ap_fixed<18,  2, AP_TRN, AP_SAT> 	AP_18_2;
typedef  ap_fixed<17,  4, AP_TRN, AP_SAT> 	AP_17_4;
typedef  ap_fixed<21, 11, AP_TRN, AP_SAT> 	AP_21_11;
typedef  ap_fixed<46, 26, AP_TRN, AP_SAT> 	AP_46_26;
typedef  ap_fixed<30, 11, AP_TRN, AP_SAT> 	AP_30_11;
typedef  ap_fixed< 8,  1, AP_TRN, AP_SAT> 	AP_8_1;
typedef  ap_fixed< 8,  1, AP_TRN, AP_SAT> 	AP_7_1;
typedef  ap_fixed<20, 12, AP_TRN, AP_SAT> 	AP_20_12;
typedef  ap_fixed<15,  4, AP_TRN, AP_SAT>  	AP_15_4;
typedef  ap_fixed< 8,  8, AP_TRN, AP_SAT>  	AP_8_8;
typedef  ap_fixed<29, 18, AP_TRN, AP_SAT>  AP_29_18;
typedef  ap_fixed<17,  7, AP_TRN, AP_SAT>  AP_17_7;
typedef  ap_fixed<18, 11, AP_TRN, AP_SAT>  AP_18_11;
typedef  ap_fixed<26, 12, AP_TRN, AP_SAT>  AP_26_12;
typedef  ap_fixed< 3,  1, AP_TRN, AP_SAT>  AP_3_1;
typedef  ap_fixed<18,  5, AP_TRN, AP_SAT>  AP_18_5;
*/

AP_18_2 calc_sin_cos (
		AP_21_11 theta_aux, bool flag);

void abc_2_dqo(
		AP_24_14 a,  	AP_24_14 b,  	AP_24_14 c,
		AP_21_11 theta,
		AP_24_14 *d, 	AP_24_14 *q, 	AP_24_14 *o);

void dqo_2_abc(
		AP_24_14 d,  AP_24_14 q, AP_24_14 o,
		AP_21_11 theta,
		AP_24_14 *a, AP_24_14 *b, AP_24_14 *c);

AP_30_11 integrate (
		AP_18_11 in_act);

AP_26_12 derivate_1 (
		AP_26_12 in_act);

AP_26_12 derivate_2 (
		AP_26_12 in_act);

void pmsm_2 (
		AP_24_14 Is_a, AP_24_14 Is_b, AP_24_14 Is_c,
		AP_17_7 Wn_o,
		AP_16_1 Ld, AP_16_1 Lq,	AP_16_1 Ls,// d and q axis inductance
		AP_15_4 landa_m,
		AP_8_8 Pole_pairs,
		AP_24_14 *Fem_a, AP_24_14 *Fem_b, AP_24_14 *Fem_c
		);

void pmsm (
		AP_21_13 Vs_a, 		AP_21_13 Vs_b, 	AP_21_13 Vs_c,
		AP_21_13 VN_gnd,
		AP_21_13 Wn_o,
		bool K2, 
		AP_16_1 Ld, AP_16_1 Lq, AP_16_1 Ls, AP_20_1 dT_Ls,
		bool SG1,
		AP_26_12 Rs,
		AP_15_4 landa_m,
		AP_8_8 Pole_pairs,
		AP_21_13 *Is_a, 	AP_21_13 *Is_b, AP_21_13 *Is_c,
		AP_21_13 *Fem_a_r, AP_21_13 *Fem_b_r, AP_21_13 *Fem_c_r);


#endif //#ifndef H_PMSM_H		
