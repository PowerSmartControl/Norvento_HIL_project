// PSC | Power Smart Control | JRF | 2018

#ifndef H_gain_offset_truncation_H
#define H_gain_offset_truncation_H

#include "hls_math.h"	//standard C data types
#include "ap_fixed.h"	//arbitrary precision data types
#include "ap_cint.h"	//arbitrary precision data types
using namespace std;		//this namespace declaration is necessary for using Ap_fixed.h method for data type conversions



typedef  ap_fixed<21, 12, AP_RND_CONV, AP_SAT> 	AP_21_12;			//21 total bits. 12 integer bits
typedef  ap_fixed<21, 13, AP_RND_CONV, AP_SAT> 	AP_21_13;
typedef  ap_ufixed<3, 3, AP_RND_CONV, AP_SAT> 	APu_3_3;


void gain_offset_truncation (
		float in_I_LCL_1_a,	float in_I_LCL_1_b, 	float in_I_LCL_1_c,
		float in_I_pmsm_a, 	float in_I_pmsm_b, 	float in_I_pmsm_c,
		float in_V_dc_bus,
		float in_I_LCL_2_a,	float in_I_LCL_2_b, 	float in_I_LCL_2_c,
		float in_V_grid_a, 	float in_V_grid_b, 	float in_V_grid_c,
		float in_Vp_a, 		float in_Vp_b, 		float in_Vp_c,
		float in_V_fem_a, 	float in_V_fem_b, 	float in_V_fem_c,
		float gain_dc_bus, float gain_voltage, float gain_current,
		APu_3_3 CB1_K1_K3,
		bool mode_L_LCL,

		uint12 *out_I_LCL_1_a, 	uint12 *out_I_LCL_1_b, 	uint12 *out_I_LCL_1_c,
		uint12 *out_I_pmsm_a, 	uint12 *out_I_pmsm_b, 	uint12 *out_I_pmsm_c,
		uint12 *out_V_dc_bus,
		uint12 *out_I_LCL_2_a, 	uint12 *out_I_LCL_2_b, 	uint12 *out_I_LCL_2_c,
		uint12 *out_V_grid_a, 	uint12 *out_V_grid_b, 	uint12 *out_V_grid_c,
		uint12 *out_V_fem_a, 	uint12 *out_V_fem_b, 	uint12 *out_V_fem_c
);


#endif //#ifndef H_gain_offset_truncation_H		
