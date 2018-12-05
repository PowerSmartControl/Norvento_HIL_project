#include "lcl_filter.h"

void lcl_filter (
		float V1_a, float V1_b, float V1_c,
		float V2_a_, float V2_b_, float V2_c_,
		float VN_gnd,
		float dT_L1, float dT_L2, float Lcc_dT, float dT_C, float rC, float rL1, float rL2, float Preload,
		bool mode_L_LCL,
		AP_5_5 CB1_K1_K3,
		float *IL1_a_r, float *IL1_b_r, float *IL1_c_r,
		float *IL2_a_r, float *IL2_b_r, float *IL2_c_r,
		float *Vp_a_r, float *Vp_b_r, float *Vp_c_r,
		float *V_grid_dac_a, float *V_grid_dac_b, float *V_grid_dac_c
){

	static float A_I_L1_a, A_I_L1_b, A_I_L1_c;//=0.0f;
	static float A_I_L2_a, A_I_L2_b, A_I_L2_c;//=0.0f;
	static float A_Vc_a, A_Vc_b, A_Vc_c;//=0.0f;
	static float aux_1_a, aux_1_b, aux_1_c, aux_2_a, aux_2_b, aux_2_c;//=0.0f;
	static float auxx_1_a, auxx_1_b, auxx_1_c, auxx_2_a, auxx_2_b, auxx_2_c;//=0.0f;

	static float I_L1_a, I_L1_b, I_L1_c;//=0.0f;
	static float I_L2_a, I_L2_b, I_L2_c, I_L2_a_prev, I_L2_b_prev, I_L2_c_prev;//=0.0f;
	static float Vp_a, Vp_b, Vp_c;//=0.0f;
	static float VC_a, VC_b, VC_c;//=0.0f;
	static float rL2_real;//=0.0f;
	static float aux_a, aux_b, aux_c, Vp_a_r_aux, Vp_b_r_aux, Vp_c_r_aux;

	const  float  	cero_uno = 0.01f;
	const  float  	cero_nueve = 0.99f;
	const  float	R_open_contactor = 10000.0f;	//before 5000.0f

	if (CB1_K1_K3==0 or CB1_K1_K3==1 or CB1_K1_K3==2 or CB1_K1_K3==3 or CB1_K1_K3==4)
		rL2_real=R_open_contactor;	//1kohm
	else if (CB1_K1_K3==5)
		rL2_real=Preload;
	else
		rL2_real=rL2;

	aux_2_a = I_L2_a*rL2_real;
	aux_2_b = I_L2_b*rL2_real;
	aux_2_c = I_L2_c*rL2_real;

	//including 100uH grid inductance
	//  (0.0001*Delta_IL2_a/t_step);   1/t_step = 1/0.5e-6 = 2_000_000
	*V_grid_dac_a =aux_a+V2_a_;
	*V_grid_dac_b =aux_b+V2_b_;
	*V_grid_dac_c =aux_c+V2_c_;	
	//grid inductance effect
	/*aux_a=I_L2_a*Lcc_dT;	//voltage through grid inductance and grid resistance
	aux_b=I_L2_b*Lcc_dT;
	aux_c=I_L2_c*Lcc_dT;*/
	aux_a=A_I_L2_a*Lcc_dT;	//voltage through grid inductance and grid resistance
	aux_b=A_I_L2_b*Lcc_dT;
	aux_c=A_I_L2_c*Lcc_dT;
	
	if (mode_L_LCL==1){	//LCL filter		

		aux_1_a = I_L1_a*rL1;
		aux_1_b = I_L1_b*rL1;
		aux_1_c = I_L1_c*rL1;

		//First LCL inductor:
		A_I_L1_a = dT_L1 * (V1_a - Vp_a - aux_1_a);
		A_I_L1_b = dT_L1 * (V1_b - Vp_b - aux_1_b);
		A_I_L1_c = dT_L1 * (V1_c - Vp_c - aux_1_c);

		//Second LCL inductor and grid inductor:
		A_I_L2_a = dT_L2 * (Vp_a - (V2_a_ + VN_gnd) - aux_2_a);
		A_I_L2_b = dT_L2 * (Vp_b - (V2_b_ + VN_gnd) - aux_2_b);
		A_I_L2_c = dT_L2 * (Vp_c - (V2_c_ + VN_gnd) - aux_2_c);

		//LCL capacitor:
		A_Vc_a = dT_C*(I_L1_a - I_L2_a);
		A_Vc_b = dT_C*(I_L1_b - I_L2_b);
		A_Vc_c = dT_C*(I_L1_c - I_L2_c);

		//Voltage between LCL inductors:
		Vp_a = (I_L1_a-I_L2_a)*rC + VC_a + VN_gnd;
		Vp_b = (I_L1_b-I_L2_b)*rC + VC_b + VN_gnd;
		Vp_c = (I_L1_c-I_L2_c)*rC + VC_c + VN_gnd;

		//Accumulation:
		I_L1_a += A_I_L1_a;
		I_L1_b += A_I_L1_b;
		I_L1_c += A_I_L1_c;

		I_L2_a += A_I_L2_a;
		I_L2_b += A_I_L2_b;
		I_L2_c += A_I_L2_c;

		VC_a += A_Vc_a;
		VC_b += A_Vc_b;
		VC_c += A_Vc_c;
		
		Vp_a_r_aux=Vp_a-VN_gnd;
		Vp_b_r_aux=Vp_b-VN_gnd;
		Vp_c_r_aux=Vp_c-VN_gnd;
	}

	else{	//LL filter
		
		//Second LCL inductor and grid inductor:
		A_I_L2_a = dT_L2 * (V1_a - (V2_a_ + VN_gnd) - aux_2_a);
		A_I_L2_b = dT_L2 * (V1_b - (V2_b_ + VN_gnd) - aux_2_b);
		A_I_L2_c = dT_L2 * (V1_c - (V2_c_ + VN_gnd) - aux_2_c);

		if (CB1_K1_K3==0 or CB1_K1_K3==1 or CB1_K1_K3==2 or CB1_K1_K3==3 or CB1_K1_K3==4){
			I_L2_a=0.0f;
			I_L2_b=0.0f;
			I_L2_c=0.0f;
			
			A_I_L2_a=0.0f;
			A_I_L2_b=0.0f;
			A_I_L2_c=0.0f;
		}
		else{
			I_L2_a += A_I_L2_a;
			I_L2_b += A_I_L2_b;
			I_L2_c += A_I_L2_c;
		}

		Vp_a=V2_a_;
		Vp_b=V2_b_;
		Vp_c=V2_c_;

		I_L1_a = I_L2_a;
		I_L1_b = I_L2_b;
		I_L1_c = I_L2_c;
		
		Vp_a_r_aux=V2_a_;
		Vp_b_r_aux=V2_b_;
		Vp_c_r_aux=V2_c_;
	}

	if (rL2_real>12){
		I_L2_a = (I_L2_a*cero_uno+I_L2_a_prev);
		I_L2_b = (I_L2_b*cero_uno+I_L2_b_prev);
		I_L2_c = (I_L2_c*cero_uno+I_L2_c_prev);

		I_L2_a_prev=I_L2_a*cero_nueve;
		I_L2_b_prev=I_L2_b*cero_nueve;
		I_L2_c_prev=I_L2_c*cero_nueve;
	}

	//Outputs
	*IL1_a_r = I_L1_a;
	*IL1_b_r = I_L1_b;
	*IL1_c_r = I_L1_c;

	*IL2_a_r = I_L2_a;
	*IL2_b_r = I_L2_b;
	*IL2_c_r = I_L2_c;

	*Vp_a_r=Vp_a_r_aux;
	*Vp_b_r=Vp_b_r_aux;
	*Vp_c_r=Vp_c_r_aux;



}
