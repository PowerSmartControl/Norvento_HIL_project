// PSC | Power Smart Control | JRF | 2018

#include "pmsm_pulses.h"





int main (){

	char cadena1 [100];
	char cadena2 [100];
	char cadena3 [100];
	char cadena4 [100];
	char cadena5 [100];
	char cadena6 [100];
	char cadena7 [100];
	char cadena8 [100];
	char index [100];
	FILE* fichero;
	fichero = fopen("pmsm_data_output.txt", "wt");

/*
	//Validate sin and cos calculating function							it works!!
	{
		float salida_1, salida_2, salida_3, salida_4, salida_5, salida_6, salida_7, salida_8;
		salida_1 = calc_sin_cos((AP_21_13)0.76794, 0);
		salida_2 = calc_sin_cos((AP_21_13)2.2689, 0);
		salida_3 = calc_sin_cos((AP_21_13)3.3685, 0);
		salida_4 = calc_sin_cos((AP_21_13)6.1261, 0);

		salida_5 = calc_sin_cos((AP_21_13)0.76794,1);
		salida_6 = calc_sin_cos((AP_21_13)2.2689, 1);
		salida_7 = calc_sin_cos((AP_21_13)3.3685, 1);
		salida_8 = calc_sin_cos((AP_21_13)6.1261, 1);

		printf ("\n\n\n%f_%f_%f_%f_%f_%f_%f_%f\n\n\n\n",(float)salida_1, (float)salida_2, (float)salida_3, (float)salida_4, (float)salida_5, (float)salida_6, (float)salida_7, (float)salida_8);
	}
*/

/*
	//Validate abc_2_dq function										it works!!
	{
		AP_24_14 d, q, o;
		//         a		b		c	theta  d   q   o
		abc_2_dqo((AP_24_14)-105.9737, (AP_24_14)321.369, (AP_24_14)-215.326, (AP_21_11)5.4948, &d, &q, &o);
		printf ("\n\n\n%f_%f_%f\n\n\n\n",(float)d,(float)q,(float)o);
	}
*/

/*
	//Validate dqo_2_abc function										it works!!
	{
		AP_24_14 a, b, c;
		//         			d				q					o	  theta 			a b  c
		dqo_2_abc((AP_24_14)9.13, (AP_24_14)-286.73, (AP_24_14)0.0, (AP_21_11)5.05, &a, &b, &c);
		printf ("\n\n\n%f_%f_%f\n\n\n\n",(float)a,(float)b,(float)c);
	}
*/

/*
	//validate derivative function										it works!!
	{
		static AP_24_14 aux=0.0;
		static AP_34_26 solution=0.0;
		for (int i=0;i<1000;i++){
			if (i<200)
				aux++;
			else if (i>=200 && i<400)
				aux--;
			else if (i>=400 && i<800)
				aux++;
			else
				aux--;
			solution=derivate_1(aux);
			//printf ("%i_%f\n",i, (float)solution);
			printf ("%f\n", (float)solution);
		}
		printf ("%f\n",(float)solution);
	}
*/

/*
	//validate integral function										it works!!
	{
		static AP_30_11 aux=0.00001;
		static AP_30_11 solution=0.00001;
		for (int i=0;i<1000;i++){
			aux++;
			//printf("%d\n", (int)aux);
			solution=integrate(aux);
			printf ("\n%f",(float)solution);
		}
		//printf ("%f\n\n\n",(float)solution);
	}
*/

/*
	//validate pmsm_2
	{
		AP_24_14 Fem_a, Fem_b, Fem_c;
		AP_32_18 Tem;
		//					Ia				Ib				Ic				theta				Ld					Lq
		for (int i=0;i<1000;i++){

			//clean the string
			for (int j=0;j<101;j++)
				cadena5[j]='\0';

			pmsm_2 ((AP_24_14)300.0, (AP_24_14)-128, (AP_24_14)-172, (AP_21_13)4.5, (AP_16_1)0.001895, (AP_16_1)0.001895, &Fem_a, &Fem_b, &Fem_c, &Tem);
			//printf ("\n\n\n%f_%f_%f_%f\n\n\n\n",(float)Fem_a,(float)Fem_b,(float)Fem_c,(float)Tem);

			//generate output data and write it to file
			gcvt((float)Fem_a, 10, cadena1);
			gcvt((float)Fem_b, 10, cadena2);
			gcvt((float)Fem_c, 10, cadena3);
			gcvt((float)Tem	 , 10, cadena4);
			gcvt((float)(i+1)	 , 10, index);
			strcat(cadena5, cadena1);
			strcat(cadena5, " ");
			strcat(cadena5, cadena2);
			strcat(cadena5, " ");
			strcat(cadena5, cadena3);
			strcat(cadena5, " ");
			strcat(cadena5, cadena4);
			strcat(cadena5, " ");
			strcat(cadena5, index);
			strcat(cadena5, "\n");
			//printf ("%s", cadena5);
			fputs(cadena5, fichero);
		}
	}
	printf("\ntodo correcto");
*/


/*
	//validate pmsm
	{
		AP_21_13 Is_a, Is_b, Is_c, Fem_a_r, Fem_b_r, Fem_c_r;
		AP_32_18 Tem;
		bool SG1, K2;
		//					Ia				Ib				Ic				theta				Ld					Lq
		for (int i=0;i<1000;i++){

			//clean the string
			for (int j=0;j<101;j++)
				cadena5[j]='\0';

			//pmsm ( 		Vs_a,  				Vs_b,  				Vs_c, 			VN_gnd, 		Wn_o, 	K2,  				Ld, 				Lq, 	SG1, 	&Is_a, 	 &Is_b,  &Is_c, &Tem, &Fem_a_r,  &Fem_b_r,  &Fem_c_r);
			pmsm ( (AP_21_13)230.0,  (AP_21_13)-125.6,  (AP_21_13)-104.4, (AP_21_13)10.0, (AP_21_13)4.5, (bool)1,  (AP_16_1)0.001895, (AP_16_1)0.001895, (bool)1, &Is_a, 	 &Is_b,  &Is_c, &Tem, &Fem_a_r,  &Fem_b_r,  &Fem_c_r);


			//generate output data and write it to file
			gcvt((float)Is_a, 10, cadena1);
			gcvt((float)Is_b, 10, cadena2);
			gcvt((float)Is_c, 10, cadena3);
			gcvt((float)Tem	 , 10, cadena4);
			gcvt((float)Fem_a_r, 10, cadena6);
			gcvt((float)Fem_b_r, 10, cadena7);
			gcvt((float)Fem_c_r, 10, cadena8);
			gcvt((float)(i+1)	 , 10, index);
			strcat(cadena5, cadena1);
			strcat(cadena5, " ");
			strcat(cadena5, cadena2);
			strcat(cadena5, " ");
			strcat(cadena5, cadena3);
			strcat(cadena5, " ");
			strcat(cadena5, cadena4);
			strcat(cadena5, " ");
			strcat(cadena5, cadena6);
			strcat(cadena5, " ");
			strcat(cadena5, cadena7);
			strcat(cadena5, " ");
			strcat(cadena5, cadena8);
			strcat(cadena5, " ");
			strcat(cadena5, index);
			strcat(cadena5, "\n");
			//printf ("%s", cadena5);
			fputs(cadena5, fichero);
		}
	}
	printf("\ntodo correcto");
*/





	return 0;	//0=> everything went fine	|	1=> at least an error occur
}

