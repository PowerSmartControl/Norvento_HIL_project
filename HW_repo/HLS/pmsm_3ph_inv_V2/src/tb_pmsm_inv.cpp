// PSC | Power Smart Control | JRF | 2018

#include "pmsm_inv.h"




int main (){
//	int i;
//
//	ap_uint<3> state = 0;
//	data_typ Ia, Ib, Ic;
/*
	void pmsm (
			AP_25_16 Vs_a, 		AP_25_16 Vs_b, 	AP_25_16 Vs_c,
			AP_18_12 VN_gnd,	AP_16_9 Wn_o,	AP_1_1 K2_SG1,
			AP_16_1 Ld, 		AP_16_1 Lq, 	AP_10_1 	Rs,
			AP_25_16 *Is_a, 	AP_25_16 *Is_b, AP_25_16 *Is_c, AP_27_18 *Tem, AP_25_16 *theta);
			*/


/*
	pmsm (
			(AP_25_16) 5.0, (AP_25_16) -3.0, (AP_25_16) -1.0,
			(AP_18_12) 100.0,	(AP_16_9) 0.9,	(AP_2_1) 1,
			(AP_16_1) 0.001895, (AP_16_1) 0.001895, (AP_10_1) 	0.05,
			 &Is_a, 	 &Is_b,  &Is_c,  &Tem,  &theta);



	printf ("\n%f_____%f____%f____%f____%f\n",(float)Is_a, (float)Is_b, (float)Is_c, (float)Tem, (float)theta);*/
	/*
	//Validate sin and cos calculating function							it works!!
	{
		data_typ salida;
		salida = calc_sin_cos((ap_fixed<16, 7, AP_RND_CONV, AP_SAT>)0.65589, 1);
		printf ("\n\n\n%f\n\n\n\n",(float)salida);
	}


	//Validate abc_2_dq function										it works!!
	{
		AP_21_12 d, q, o;
		//         a		b		c	theta  d   q   o
		abc_2_dqo((AP_21_12)5.01, (AP_21_12)8.025, (AP_21_12)45.25, (AP_16_7)0.65589, &d, &q, &o);
		printf ("\n\n\n%f________%f________%f\n\n\n\n",(float)d,(float)q,(float)o);
	}

	//Validate abc_2_dq function										it works!!
	{
		AP_21_12 a, b, c;
		//         a		b		c	theta  d   q   o
		dqo_2_abc((AP_21_12)5.01, (AP_21_12)8.025, (AP_21_12)45.25, (AP_16_7)0.65589, &a, &b, &c);
		printf ("\n\n\n%f________%f________%f\n\n\n\n",(float)a,(float)b,(float)c);
	}

	//validate integral function										it works!!
	{
		AP_40_12 aux, solution;

		aux=(AP_40_12)1.0;

		for (int i=0;i<100000;i++){

			solution=integrate(aux);
			//printf ("%f\n\n\n",(float)solution);
			//printf ("%f\n\n\n",(float)aux);
		}
		printf ("%f\n\n\n",(float)solution);
	}

	//validate derivative function										it works!!
	{
		AP_47_21 aux, solution=(AP_47_21)1.0;
		for (int i=0;i<100000;i++){

			aux=aux+1;

			solution=derivate_1(aux);

		}
		printf ("%f\n",(float)solution);
	}
	 */
	/*
	//validate pmsm_2
	{
		AP_25_16 Fem_a, Fem_b, Fem_c, Tem;
		AP_25_16 theta;
		//		Ia		Ib	Ic		theta
		pmsm_2 ((AP_25_16)5.01, (AP_25_16)8.025, (AP_25_16)45.25, (AP_16_9)0.65589, &Fem_a, &Fem_b, &Fem_c, &Tem, &theta);
		//printf ("\n\n\n%f________%f________%f________%f________%f\n\n\n\n",(float)Fem_a,(float)Fem_b,(float)Fem_c,(float)Tem, (float)theta);
	}

	 */
/*

	//validate pmsm
	{
		AP_25_16 Is_a, Is_b, Is_c, Tem, theta;
		//		Va	Vb		Vc		VN_gnd  Wo
		pmsm ((AP_25_16)5.01, (AP_25_16)8.025, (AP_25_16)45.25, (AP_18_12)24.25, (AP_16_9)0.65589, &Is_a, &Is_b, &Is_c, &Tem, &theta);
		printf ("\n\n\n%f________%f________%f________%f________%f\n\n\n\n",(float)Is_a,(float)Is_b,(float)Is_c,(float)Tem, (float)theta);
	}
*/


	return 0;	//0=> everything went fine	|	1=> at least an error occur
}

