// PSC | Power Smart Control | JRF | 2018

#include "dc_bus.h"

void DCbus_dynamic (
		float I_in, float I_out_, float t_step_C, bool ena_chop_res, bool DC_bus_fixed_volt, float V_DC_voltage_in, float inv_R_eq, bool 
download_RC,
		float *V_bus){

	static float Delta_C, V_C, V_bus_dc, aux, auxx, V_R, I_in_aux, I_out_aux, V_R2, V_bus_dc_aux, AVbus=0.0f, V_bus_dc_init=0.0f, 
number=0.0f, expo=0.0f;
	static bool flag=0;
	static int t=0;
	static int counter=0;

	//const float 	inv_R_eq=0.005f;			//engaged resistor (always connected)   =1/37kohm
	const float 	inv_R_eq_2 = 0.4f;//0.0909;		//chopping resistor						=1/11ohm
	const float 	rC = 0.01f;		//DC bus capacitor internal resistor
	//const float  	inv_rC = 10.0f;//100;		//	1/rC
	const float inv_RC = 188.7f;	//RC=37k*5.1m=188.7
	
	//const float I_out = 300.0;
	//const float I_in_ = 0.0;

	//I_out=I_out+cero_cinco;

	if (DC_bus_fixed_volt ==1){
		V_bus_dc = V_DC_voltage_in;
		auxx=1;
		aux=1;
		V_C=1;
		flag=0;
	}	
	else if (download_RC==1 && ena_chop_res==0){	//chopper resistor off
		if (flag==0){
			flag=1;
			counter=0;
			V_bus_dc_init=V_bus_dc;
			t=0;
			expo=0.0f;
			number=0.0f;
		}
		else{						
			if (V_bus_dc>=0.1f){
				
				if (counter>9999){	//time step reduction by factor: 100 ( 0.5us(real t_step) -> 0.005s(effective t_step) )
					counter=0;
					t+=5;
				}
				else
					counter++;
				
				expo=exp(number);	//1kohm*5.1m = 5.1 = tao   1/5.1 = 0.19608
				number=(-0.00000297*t);// /3366000000.0f;// 0.000000000594f;	//1/RC = 1/(66k/5.1mF)			3366000000
				V_bus_dc=V_bus_dc_init*expo;

				/*	ok psim
				expo=exp(number);	//1kohm*5.1m = 5.1 = tao   1/5.1 = 0.19608
				number=(-0.000000000297*t);// /3366000000.0f;// 0.000000000594f;	//1/RC = 1/(66k/5.1mF)			3366000000
				t+=5;	//time step increment
				V_bus_dc=V_bus_dc_init*expo;*/
			}
			else
				V_bus_dc=0.0f;	
		}		
	}
	else{
		flag=0;
		if (ena_chop_res==0){
			V_R = V_bus_dc*(inv_R_eq);
			auxx=(I_in - I_out_ - V_R)*rC;
			aux=(I_in - I_out_ - V_R);
		}
		else{
			V_R2 = V_bus_dc*(inv_R_eq_2);
			auxx=(I_in - I_out_ - V_R2)*rC;
			aux=(I_in - I_out_ - V_R2);
		}

		//capacitor:
		V_bus_dc = (auxx + V_C);
		V_C+=(t_step_C*aux);
		/*
		if (V_bus_dc< -0.1)
			V_bus_dc=0;
		if (V_bus_dc>2000)
			V_bus_dc=2000;*/
	}

	*V_bus=V_bus_dc;
}

