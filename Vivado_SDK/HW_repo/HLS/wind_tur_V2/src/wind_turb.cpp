// PSC | Power Smart Control | JRF | 2018

#include "wind_turb.h"


void wind_turb (
		AP_32_18 Tem, AP_21_20 P_wind,
		AP_21_13 *Wn){	//Pi (input) = 0.5* Rblades* 3.14159* Vwind^3* airDensity* Cp

	const AP_21_1 dT_Ceq 	= 0.00003;	//t_step = 1.5e-6 / Ceq = 0.05 = 0.00003
	const AP_16_7  init_cond	= 10.0;	//initial conditions
	const AP_21_1 B = 0.001; 	//friction coefficient
	const AP_21_20 P_wind_ = 96111; 	

	static AP_30_18 V=0.01;
	static AP_30_2 AV=0.01;
	static AP_30_18 Ti=0.01;
	static AP_21_13 Wn_aux=1;
	
	Wn_aux = V + init_cond;			//speed of pmsm
	Ti = P_wind_/Wn_aux;				//Instantaneous torque
	AV = dT_Ceq * (Ti+Tem-B*Wn_aux);			//V torque bus
	V += AV;

	//Output:
	*Wn = Wn_aux;
}

//note: P_wind = (0.5*air_density*area*V_wind*V_wind*V_wind*Cp);	//power extracted from wind
