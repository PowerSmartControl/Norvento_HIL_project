// PSC | Power Smart Control | JRF | 2018

#include "gain_offset_truncation.h"

void gain_offset_truncation (
		float in_I_LCL_1_a,	float in_I_LCL_1_b, 	float in_I_LCL_1_c,
		float in_I_pmsm_a, 	float in_I_pmsm_b, 	float in_I_pmsm_c,
		float in_V_dc_bus,
		float in_I_LCL_2_a,	float in_I_LCL_2_b, 	float in_I_LCL_2_c,
		float in_V_grid_a, 	float in_V_grid_b, 	float in_V_grid_c,
		float in_Vp_a, 		float in_Vp_b, 		float in_Vp_c,
		float in_V_fem_a, 	float in_V_fem_b, 	float in_V_fem_c,
		float gain_dc_bus, float gain_voltage_grid, float gain_current_grid, float gain_voltage_pmsm, float gain_current_pmsm,
		APu_3_3 CB1_K1_K3,
		bool mode_L_LCL,

		uint12 *out_I_LCL_1_a, 	uint12 *out_I_LCL_1_b, 	uint12 *out_I_LCL_1_c,
		uint12 *out_I_pmsm_a, 	uint12 *out_I_pmsm_b, 	uint12 *out_I_pmsm_c,
		uint12 *out_V_dc_bus,
		uint12 *out_I_LCL_2_a, 	uint12 *out_I_LCL_2_b, 	uint12 *out_I_LCL_2_c,
		uint12 *out_V_grid_a, 	uint12 *out_V_grid_b, 	uint12 *out_V_grid_c,
		uint12 *out_V_fem_a, 	uint12 *out_V_fem_b, 	uint12 *out_V_fem_c
){

	const float offset_DAC		=     2048.0f;	//12bits=>4096 thus half span is 4096/2=2048
	const float hs = 2048;	//half span

	static float output_vector [16]={2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048};
	static int counter=0;

	if (counter>15)
		counter=0;
	else
		counter++;

	*out_I_LCL_1_a=(uint12)output_vector [0];
	*out_I_LCL_1_b=(uint12)output_vector [1];
	*out_I_LCL_1_c=(uint12)output_vector [2];

	*out_I_pmsm_a=(uint12)output_vector [3];
	*out_I_pmsm_b=(uint12)output_vector [4];
	*out_I_pmsm_c=(uint12)output_vector [5];

	*out_I_LCL_2_a=(uint12)output_vector [6];
	*out_I_LCL_2_b=(uint12)output_vector [7];
	*out_I_LCL_2_c=(uint12)output_vector [8];

	*out_V_dc_bus=(uint12)output_vector [9];

	*out_V_grid_a=(uint12)output_vector [10];
	*out_V_grid_b=(uint12)output_vector [11];
	*out_V_grid_c=(uint12)output_vector [12];

	*out_V_fem_a=(uint12)output_vector [13];
	*out_V_fem_b=(uint12)output_vector [14];
	*out_V_fem_c=(uint12)output_vector [15];


	switch (counter) {
	case 0:
		output_vector [0]	= (offset_DAC - in_I_LCL_1_a * gain_current_grid );
		break;

	case 1:
		output_vector [1]	= (offset_DAC - in_I_LCL_1_b * gain_current_grid );
		break;

	case 2:
		output_vector [2]	= (offset_DAC - in_I_LCL_1_c * gain_current_grid );
		break;
		///
	case 3:
		output_vector [3]	= (offset_DAC + in_I_pmsm_a	* gain_current_pmsm);
		break;

	case 4:
		output_vector [4]	= (offset_DAC + in_I_pmsm_b	* gain_current_pmsm);
		break;

	case 5:
		output_vector [5]	= (offset_DAC + in_I_pmsm_c	* gain_current_pmsm);
		break;
		///
	case 6:
		output_vector [6]	= (offset_DAC -  in_I_LCL_2_a * gain_current_grid );
		break;

	case 7:
		output_vector [7]	= (offset_DAC -  in_I_LCL_2_b * gain_current_grid );
		break;

	case 8:
		output_vector [8]	= (offset_DAC -  in_I_LCL_2_c * gain_current_grid );
		break;
		///
	case 9:
		output_vector [9]	= (in_V_dc_bus	* gain_dc_bus  + offset_DAC);
		break;
		///

	case 10:
		if (mode_L_LCL==1){	//LCL filter
			if (CB1_K1_K3==0)
				output_vector [10]	= 2048;
			else if (CB1_K1_K3==1 or CB1_K1_K3==2 or CB1_K1_K3==3)
				output_vector [10]	= (in_Vp_a	* gain_voltage_grid + offset_DAC);
			else
				output_vector [10]	= (in_V_grid_a	* gain_voltage_grid + offset_DAC);
		}
		else{	//LL filter mode
			if (CB1_K1_K3==0)
				output_vector [10]	= 2048;
			else if (CB1_K1_K3==1 or CB1_K1_K3==2 or CB1_K1_K3==3)
				output_vector [10]	= (in_Vp_a	* gain_voltage_grid + offset_DAC);
			else
				output_vector [10]	= (in_Vp_a	* gain_voltage_grid + offset_DAC);
		}
		break;

	case 11:
		if (mode_L_LCL==1){	//LCL filter
			if (CB1_K1_K3==0)
				output_vector [11]	= 2048;
			else if (CB1_K1_K3==1 or CB1_K1_K3==2 or CB1_K1_K3==3)
				output_vector [11]	= (in_Vp_b	* gain_voltage_grid + offset_DAC);
			else
				output_vector [11]	= (in_V_grid_b	* gain_voltage_grid + offset_DAC);
		}
		else{	//LL filter mode
			if (CB1_K1_K3==0)
				output_vector [11]	= 2048;
			else if (CB1_K1_K3==1 or CB1_K1_K3==2 or CB1_K1_K3==3)
				output_vector [11]	= (in_Vp_b	* gain_voltage_grid + offset_DAC);
			else
				output_vector [11]	= (in_Vp_b	* gain_voltage_grid + offset_DAC);
		}
		break;

	case 12:
		if (mode_L_LCL==1){	//LCL filter
			if (CB1_K1_K3==0)
				output_vector [12]	= 2048;
			else if (CB1_K1_K3==1 or CB1_K1_K3==2 or CB1_K1_K3==3)
				output_vector [12]	= (in_Vp_c	* gain_voltage_grid + offset_DAC);
			else
				output_vector [12]	= (in_V_grid_c	* gain_voltage_grid + offset_DAC);
		}
		else{	//LL filter mode
			if (CB1_K1_K3==0)
				output_vector [12]	= 2048;
			else if (CB1_K1_K3==1 or CB1_K1_K3==2 or CB1_K1_K3==3)
				output_vector [12]	= (in_Vp_c	* gain_voltage_grid + offset_DAC);
			else
				output_vector [12]	= (in_Vp_c	* gain_voltage_grid + offset_DAC);
		}
		break;
		///
	case 13:
		output_vector [13]	= ( in_V_fem_a	* gain_voltage_pmsm + offset_DAC);
		break;

	case 14:
		output_vector [14]	= (in_V_fem_b	* gain_voltage_pmsm + offset_DAC);	//this output should be disabled as it is unterminated the current driver in NV board
		break;

	case 15:
		output_vector [15]	= (in_V_fem_c * gain_voltage_pmsm + offset_DAC);	//this output should be disabled as it is unterminated the current driver in NV board
		break;
		///
	default:
		break;

	}
}




