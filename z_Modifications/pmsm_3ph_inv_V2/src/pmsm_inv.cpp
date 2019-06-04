// PSC | Power Smart Control | JRF | 2018

#include "pmsm_inv.h"



void bridge3ph (
		bool T1, bool T2,
		bool T3, bool T4,
		bool T5, bool T6,
		float Vdc_f,
		AP_21_13 Ia, AP_21_13 Ib, AP_21_13 Ic,
		AP_21_13 *Va, AP_21_13 *Vb, AP_21_13 *Vc,
		float *Idc,
		AP_21_13 *Vn_gnd){

#pragma HLS INTERFACE ap_none register port=Vn_gnd
#pragma HLS INTERFACE ap_none register port=Idc
#pragma HLS INTERFACE ap_none register port=Vc
#pragma HLS INTERFACE ap_none register port=Vb
#pragma HLS INTERFACE ap_none register port=Va
	//declaracion variables
	static AP_21_13 a=0, b=0, c=0, Vdc=0;
	const AP_22_1 un_terc = 0.33333;
	bool T1_eq=0, T2_eq=0, T3_eq=0, T4_eq=0, T5_eq=0, T6_eq=0;

	Vdc= (AP_21_13) Vdc_f;

	//conduction par T1
	if (T1==0 && T4==0 && Ia>0)
		T1_eq=1;									// diode
	else 							 	 // IGBT
		T1_eq=T1;	
				
	//conduction par T2
	if (T2==0 && T5==0 && Ib>0)
		T2_eq=1;									//mosfet / igbt
	else
		T2_eq=T2;		

	//conduction par T3
	if (T3==0 && T6==0 && Ic>0)
		T3_eq=1;									//mosfet / igbt
	else
		T3_eq=T3;		

	//generate outputs:
	if (T1_eq==1)
		a=Vdc;
	else
		a=0;

	if (T2_eq==1)
		b=Vdc;
	else
		b=0;

	if (T3_eq==1)
		c=Vdc;
	else
		c=0;

	*Idc= (float) ( Ia*T1_eq +  Ib*T2_eq +  Ic*T3_eq );
	*Vn_gnd=(a+b+c)*un_terc;
	*Va = a;
	*Vb = b;
	*Vc = c;


}
