// PSC | Power Smart Control | JRF | 2018

#include "three_ph_mod.h"

void three_ph_modu (
		AP_18_18 mod_a, AP_18_18 mod_b, AP_18_18 mod_c,
		bool enable, AP_12_12 counter_limit_tri,
		AP_18_18 *tri, AP_18_18 *modu_a,
		bool *T1, bool *T2,  bool *T3, bool *T4,  bool *T5, bool *T6
){

	static AP_12_12 counter;
	static AP_12_12 index_tri;
	static AP_18_18 triangular;

	if (counter>counter_limit_tri){			//this establish the grid frequency
		counter=0;
		if (index_tri>=999)	//1023
			index_tri=0;
		else
			index_tri++;
	}

	/*
	if (index_tri>=999)	//1023
		index_tri=0;
	else
		index_tri++;
*/
	counter=counter+1;
	triangular = full_tri[index_tri];

	if (enable==1){
		if (mod_a> triangular){
			*T1=1;
			*T4=0;
		}
		else{
			*T1=0;
			*T4=1;
		}
		if (mod_b> triangular){
			*T2=1;
			*T5=0;
		}
		else{
			*T2=0;
			*T5=1;
		}
		if (mod_c> triangular){
			*T3=1;
			*T6=0;
		}
		else{
			*T3=0;
			*T6=1;
		}
	}
	else{
		*T1=0;
		*T2=0;
		*T3=0;
		*T4=0;
		*T5=0;
		*T6=0;
	}

	*modu_a=mod_a;
	*tri=triangular;
}

