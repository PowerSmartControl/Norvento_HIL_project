#include "grid.h"

void grid (
		bool phase_step_on, int phase_step,
		int counter_limit,
		float ampl_a, float ampl_b, float ampl_c,
		bool inv_seq, bool proof_flag_on,
		float *Grid_a_r, float *Grid_b_r, float *Grid_c_r,
		int18 *mod_a, int18 *mod_b, int18 *mod_c, float *I_out_proof
){
/*
	static AP_13_12 counter;
	static AP_13_12 index_a=0;
	static AP_13_12 index_b=333;//341
	static AP_13_12 index_c=167;//683
	static AP_25_16 aux_a, aux_b, aux_c;
	static bool phase_step_on_prev, flag_step=0;
*/
	static int counter=0;
	static int index_a=0.0f;
	static int index_b=333;//341
	static int index_c=167;//683
	static float aux_a, aux_b, aux_c=0.0f;
	static bool phase_step_on_prev, flag_step=0;

	if (counter>counter_limit){			//this establish the grid frequency
		counter=0;
		if (index_a>=499)	//1023
			index_a=0;
		else
			index_a++;
		if (index_b>=499)	//1023
			index_b=0;
		else
			index_b++;
		if (index_c>=499)	//1023
			index_c=0;
		else
			index_c++;
	}

	if (phase_step_on==1 and phase_step_on_prev==0 and index_a==0){
		flag_step=1;
	}

	if (flag_step==1 and index_a==0){
		index_a=index_a + phase_step;
		index_b=index_b + phase_step;
		index_c=index_c + phase_step;
		flag_step=0;
	}

	phase_step_on_prev=phase_step_on;

	counter=counter+1;

	aux_a = (ampl_a*full_sine[index_a]);
	aux_b = (ampl_b*full_sine[index_b]);
	aux_c = (ampl_c*full_sine[index_c]);

	if (inv_seq==0){
		*Grid_a_r = aux_a;
		*Grid_b_r = aux_b;
		*Grid_c_r = aux_c;
	}
	else{
		*Grid_a_r = aux_a;
		*Grid_b_r = aux_c;
		*Grid_c_r = aux_b;
	}

	//this allows the injection of active power to the grid
	static int new_index_a, new_index_b, new_index_c;
	static float theta = 1.1301; //0.1172691;
	static float k = 127.5558;
	//static AP_21_16 k;
	//k=k_aux/Vdc;
	const float ckt_1 = 0.012566;
	const float ckt_2 = 0.9999;//79.5781; //as is is multiplying by 1, it is neglected
	const float ckt_3 = 9.33205;
	//const float  ckt_4 = 151.515;

	//new_index_a=(( index_a * (360/500)*(2*3.14159/360) + theta ) * (180/1.14159))*(500/360);
	new_index_a= index_a +ckt_3;
	if (new_index_a>499)
		new_index_a=new_index_a-499;
	if (new_index_a>499)
		new_index_a=new_index_a-499;
	if (new_index_a<0)
		new_index_a=new_index_a+499;
	*mod_a = (int18)(full_sine[new_index_a] * 65535);

	new_index_b= index_b + ckt_3;
	if (new_index_b>499)
		new_index_b=new_index_b-499;
	if (new_index_b>499)
		new_index_b=new_index_b-499;
	if (new_index_b<0)
		new_index_b=new_index_b+499;
	*mod_b = (int18)(full_sine[new_index_b] * 65535);

	new_index_c= index_c + ckt_3;
	if (new_index_c>499)
		new_index_c=new_index_c-499;
	if (new_index_c>499)
		new_index_c=new_index_c-499;
	if (new_index_c<0)
		new_index_c=new_index_c+499;
	*mod_c = (int18)(full_sine[new_index_c] * 65535);
	
	*I_out_proof=0;

/*
	//injected current to dc bus from pmsm side
	if (proof_flag_on==1)
		*I_out_proof= ckt_4;
	else
		*I_out_proof= 0;
	
	
*/

//*mod_a=0;
//*mod_b=0;
//*mod_c=0;
//*I_out_proof=0;
}


