// PSC | Power Smart Control | JRF | 2018

#ifndef H_DC_BUS_H
#define H_DC_BUS_H

//#include "hls_math.h"	//standard C data types
#include "ap_fixed.h"	//arbitrary precision data types
#include <hls_math.h>		//exp function
using namespace std;		//this namespace declaration is necessary for using Ap_fixed.h method for data type conversions



typedef  ap_fixed<21, 12, AP_RND_CONV, AP_SAT> 	AP_21_12;			//21 total bits. 12 integer bits
typedef  ap_fixed<18, 12, AP_RND_CONV, AP_SAT> 	AP_18_12;			//18 total bits. 12 integer bits
typedef  ap_fixed<16, 9, AP_RND_CONV, AP_SAT> 	AP_16_9;			//16 total bits. 7 integer bits
typedef  ap_fixed<16, 7, AP_RND_CONV, AP_SAT> 	AP_16_7;			//16 total bits. 7 integer bits
typedef  ap_fixed<16, 3, AP_RND_CONV, AP_SAT>	AP_16_3;			//16 total bits. 3 integer bits
typedef  ap_fixed<40, 12, AP_RND_CONV, AP_SAT>	AP_40_12;			//40 total bits. 12 integer bits
typedef  ap_fixed<47, 21, AP_RND_CONV, AP_SAT>	AP_47_21;			//47 total bits. 21 integer bits
typedef  ap_fixed<52, 26, AP_RND_CONV, AP_SAT>	AP_52_26;			//47 total bits. 21 integer bits
typedef  ap_fixed<21, 16, AP_RND_CONV, AP_SAT>	AP_21_16;			//47 total bits. 21 integer bits
typedef  ap_fixed<25, 16, AP_RND_CONV, AP_SAT>	AP_25_16;			//47 total bits. 21 integer bits
typedef  ap_fixed<27, 18, AP_RND_CONV, AP_SAT>	AP_27_18;			//47 total bits. 21 integer bits

typedef  ap_fixed<13, 5, AP_RND_CONV, AP_SAT> 	AP_13_5;			//21 total bits. 12 integer bits
typedef  ap_fixed<12, 4, AP_RND_CONV, AP_SAT> 	AP_12_4;
typedef  ap_fixed<10, 2, AP_RND_CONV, AP_SAT> 	AP_10_2;
typedef  ap_fixed<14, 4, AP_RND_CONV, AP_SAT> 	AP_14_4;
typedef  ap_fixed<18,11, AP_RND_CONV, AP_SAT> 	AP_18_11;
typedef  ap_fixed<16, 7, AP_RND_CONV, AP_SAT> 	AP_16_7;
typedef  ap_fixed<25,16, AP_RND_CONV, AP_SAT>	AP_25_16;
typedef  ap_fixed<16, 1, AP_RND_CONV, AP_SAT> 	AP_16_1;
typedef  ap_fixed< 4, 1, AP_RND_CONV, AP_SAT> 	AP_4_1;
typedef  ap_fixed< 2, 1, AP_RND_CONV, AP_SAT> 	AP_2_1;
typedef  ap_fixed< 8, 7, AP_RND_CONV, AP_SAT> 	AP_8_7;
typedef  ap_fixed< 3, 3, AP_RND_CONV, AP_SAT>	AP_3_3;
typedef  ap_fixed< 8, 1, AP_RND_CONV, AP_SAT>	AP_8_1;
typedef  ap_fixed<26, 1, AP_RND_CONV, AP_SAT>	AP_26_1;
typedef  ap_fixed<22,21, AP_RND_CONV, AP_SAT>	AP_22_21;
typedef  ap_fixed<15, 1, AP_RND_CONV, AP_SAT>	AP_15_1;
typedef  ap_fixed<10, 1, AP_RND_CONV, AP_SAT>	AP_10_1;
typedef  ap_fixed<20, 1, AP_RND_CONV, AP_SAT>	AP_20_1;
typedef  ap_fixed<28, 1, AP_RND_CONV, AP_SAT>	AP_28_1;




typedef  ap_fixed<21, 12, AP_RND_CONV, AP_SAT> 	AP_21_12;			//21 total bits. 12 integer bits
typedef  ap_fixed<18, 12, AP_RND_CONV, AP_SAT> 	AP_18_12;
typedef  ap_fixed<16,  9, AP_RND_CONV, AP_SAT> 	AP_16_9;
//typedef  ap_fixed<16,  7, AP_RND_CONV, AP_SAT> 	AP_16_7;
typedef  ap_fixed<16,  3, AP_RND_CONV, AP_SAT>	AP_16_3;
typedef  ap_fixed<40, 12, AP_RND_CONV, AP_SAT>	AP_40_12;
typedef  ap_fixed<47, 21, AP_RND_CONV, AP_SAT>	AP_47_21;
typedef  ap_fixed<52, 26, AP_RND_CONV, AP_SAT>	AP_52_26;
typedef  ap_fixed<21, 16, AP_RND_CONV, AP_SAT>	AP_21_16;

typedef  ap_fixed<27, 18, AP_RND_CONV, AP_SAT>	AP_27_18;

typedef  ap_fixed<21, 20, AP_RND_CONV, AP_SAT>	AP_21_20;
typedef  ap_fixed<30, 18, AP_RND_CONV, AP_SAT>	AP_30_18;
typedef  ap_fixed< 6,  5, AP_RND_CONV, AP_SAT>	AP_6_5;
typedef  ap_fixed<19,  1, AP_RND_CONV, AP_SAT>	AP_19_1;
typedef  ap_fixed< 2,  1, AP_RND_CONV, AP_SAT>	AP_2_1;
typedef  ap_fixed< 9,  1, AP_RND_CONV, AP_SAT>	AP_9_1;

typedef  ap_fixed< 16,  16, AP_RND_CONV, AP_SAT>	AP_16_16;
typedef  ap_fixed< 5,  5, AP_RND_CONV, AP_SAT>	AP_5_5;
typedef  ap_fixed< 22,  1, AP_RND_CONV, AP_SAT>	AP_22_1;
typedef  ap_fixed< 5,  1, AP_RND_CONV, AP_SAT>	AP_5_1;
typedef  ap_fixed< 8,  8, AP_RND_CONV, AP_SAT>	AP_8_8;

//typedef  ap_fixed< 32, 12, AP_RND_CONV, AP_SAT>	AP_32_12;
typedef  ap_fixed< 60, 20, AP_RND_CONV, AP_SAT>	AP_32_12;


void DCbus_dynamic (
		AP_32_12 I_in, AP_32_12 I_out, AP_19_1 t_step_C_NC, bool ena_chop_res, bool DC_bus_fixed_volt, AP_18_12 V_DC_voltage_in,
		AP_32_12 *V_bus);


#endif //#ifndef H_DC_BUS_H
