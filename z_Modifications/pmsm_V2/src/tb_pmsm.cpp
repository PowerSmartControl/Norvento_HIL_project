// PSC | Power Smart Control | JRF | 2018

#include "pmsm.h"





int main (){



	printf("\n\n");

	/*
	//Validate sin and cos calculating function
	printf("\nValidate calc_sin_cos function:");
	printf("\n*******************************");
	{
		float salida[8];
		int acum=0;

		salida[0] = calc_sin_cos((AP_21_13)0.76794, 0);
		salida[1] = calc_sin_cos((AP_21_13)2.2689, 0);
		salida[2] = calc_sin_cos((AP_21_13)3.3685, 0);
		salida[3] = calc_sin_cos((AP_21_13)6.1261, 0);

		salida[4] = calc_sin_cos((AP_21_13)0.76794,1);
		salida[5] = calc_sin_cos((AP_21_13)2.2689, 1);
		salida[6] = calc_sin_cos((AP_21_13)3.3685, 1);
		salida[7] = calc_sin_cos((AP_21_13)6.1261, 1);

		//printf ("\n%f_%f_%f_%f_%f_%f_%f_%f",(float)salida[0], (float)salida[1], (float)salida[2], (float)salida[3], (float)salida[4], (float)salida[5], (float)salida[6], (float)salida[7]);

		if (salida[0]<( 0.69594*0.995) and salida[0]>( 0.69594*1.005)) acum++;	// 0.69594 / 1% error allowed
		if (salida[1]<( 0.76606*0.995) and salida[1]>( 0.76606*1.005)) acum++;	// 0.76606 / 1% error allowed
		if (salida[2]>(-0.22496*0.995) and salida[2]<(-0.22496*1.005)) acum++;	//-0.22496 / 1% error allowed
		if (salida[3]>(-0.15644*0.995) and salida[3]<(-0.15644*1.005)) acum++;	//-0.15644 / 1% error allowed

		if (salida[4]<( 0.71809*0.995) and salida[4]>( 0.71809*1.005)) acum++;	// 0.71809 / 1% error allowed
		if (salida[5]>(-0.64276*0.995) and salida[5]<(-0.64276*1.005)) acum++;	//-0.64276 / 1% error allowed
		if (salida[6]>(-0.97436*0.995) and salida[6]<(-0.97436*1.005)) acum++;	//-0.97436 / 1% error allowed
		if (salida[7]<( 0.98768*0.995) and salida[7]>( 0.98768*1.005)) acum++;	// 0.98768 / 1% error allowed

		if (acum==0) printf ("\nNo errors in calc_sin_cos function\n\n");
	}


	//Validate abc_2_dq function
	printf("\nValidate abc_2_dq function:");
	printf("\n***************************");
	{
		int acum_2=0;
		AP_24_14 d[3], q[3], o[3];
		//         a		b		c	theta  d   q   o
		abc_2_dqo((AP_24_14)-105.9737, (AP_24_14) 321.369, (AP_24_14)-215.326, (AP_21_11)5.4948, &d[0], &q[0], &o[0]);
		abc_2_dqo((AP_24_14) 105.9737, (AP_24_14)-321.369, (AP_24_14) 215.326, (AP_21_11)0.5687, &d[1], &q[1], &o[1]);
		abc_2_dqo((AP_24_14)-221.0430, (AP_24_14) 321.369, (AP_24_14)-100.326, (AP_21_11)3.5689, &d[2], &q[2], &o[2]);
		//printf ("\n%f_%f_%f\n_%f_%f_%f\n_%f_%f_%f",(float)d[0],(float)q[0],(float)o[0],(float)d[1],(float)q[1],(float)o[1],(float)d[2],(float)q[2],(float)o[2]);

		if (d[1]>-294.4855*0.995 and d[1]<-294.4855*1.005) acum_2++;
		if (d[2]> -77.5593*0.995 and d[2]< -77.5593*1.005) acum_2++;
		if (d[3]< 100.2695*0.995 and d[3]> 100.2695*1.005) acum_2++;

		if (q[1]< 143.2755*0.995 and q[1]> 143.2755*1.005) acum_2++;
		if (q[2]>-318.1732*0.995 and q[2]<-318.1732*1.005) acum_2++;
		if (q[3]>-313.1799*0.995 and q[3]<-313.1799*1.005) acum_2++;

		if (o[1]<   0.0231*0.995 and o[1]>   0.0231*1.005) acum_2++;
		if (o[2]>  -0.0231*0.995 and o[2]<  -0.0231*1.005) acum_2++;
		if (o[3]<   0.0000*0.995 and o[3]>   0.0000*1.005) acum_2++;

		if (acum_2==0) printf ("\nNo errors in abc_2_dq function\n\n");
	}


	//Validate dqo_2_abc function
	printf("\nValidate dqo_2_abc function:");
	printf("\n***************************");
	{
		int acum_3=0;
		AP_24_14 a[3], b[3], c[3];
		//         			    d				    q					 o	             theta 	   a       b      c
		dqo_2_abc((AP_24_14)-294.4855, (AP_24_14) 143.2755, (AP_24_14) 0.0231, (AP_21_11)5.4948, &a[0], &b[0], &c[0]);
		dqo_2_abc((AP_24_14) -77.5593, (AP_24_14)-318.1732, (AP_24_14)-0.0231, (AP_21_11)0.5687, &a[1], &b[1], &c[1]);
		dqo_2_abc((AP_24_14) 100.2695, (AP_24_14)-313.1799, (AP_24_14) 0.0000, (AP_21_11)3.5689, &a[2], &b[2], &c[2]);
		//printf ("\n%f_%f_%f\n%f_%f_%f\n%f_%f_%f",(float)a[0],(float)b[0],(float)c[0], (float)a[1],(float)b[1],(float)c[1],(float)a[2],(float)b[2],(float)c[2]);

		if (a[1]>-309.2000*0.995 and a[1]<-309.2000*1.005) acum_3++;
		if (a[2]>-236.7228*0.995 and a[2]<-236.7228*1.005) acum_3++;
		if (a[3]<  38.5347*0.995 and a[3]>  38.5347*1.005) acum_3++;

		if (b[1]< 248.0307*0.995 and b[1]> 248.0307*1.005) acum_3++;
		if (b[2]< 314.3292*0.995 and b[2]> 314.3292*1.005) acum_3++;
		if (b[3]>-302.0895*0.995 and b[3]<-302.0895*1.005) acum_3++;

		if (c[1]<  61.2358*0.995 and c[1]>  61.2358*1.005) acum_3++;
		if (c[2]> -77.6778*0.995 and c[2]< -77.6778*1.005) acum_3++;
		if (c[3]< 263.5551*0.995 and c[3]> 263.5551*1.005) acum_3++;

		if (acum_3==0) printf ("\nNo errors in abc_2_dq function\n\n");
	}


	//validate derivative function
	printf("\nValidate derivative function:");
	printf("\n***************************");
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
			//printf ("%f\n", (float)solution);
		}
		//printf ("%f\n",(float)solution);
		printf ("\nNo errors in derivative function\n\n");
	}



	//validate integral function
	printf("\nValidate integral function:");
	printf("\n***************************");
	{
		static AP_30_11 aux=0.00001;
		static AP_30_11 solution=0.00001;
		for (int i=0;i<1000;i++){
			aux++;
			//printf("%d\n", (int)aux);
			solution=integrate(aux);
			//printf ("\n%f",(float)solution);
		}
		//printf ("%f\n\n\n",(float)solution);

		if (solution>(0.7487*0.99) and solution<(0.7487*1.01)) printf ("\nNo errors in integral function\n\n");

	}


	 */
	/*
	//to verify this code, merge the data file generated with PSIM simulation
	//validate pmsm_2
	{
		AP_24_14 Fem_a, Fem_b, Fem_c;
		char cadena1 [100];
		char cadena2 [100];
		char cadena3 [100];
		char cadena4 [100];
		char cadena5 [100];
		//char cadena6 [100];
		//char cadena7 [100];
		//char cadena8 [100];
		//char index [100];
		static float timee=0;
		FILE* fichero;
		fichero = fopen("pmsm_data_output.txt", "wt");

		//clean the string
		for (int j=0;j<101;j++)
			cadena5[j]='\0';

		strcat(cadena5, "Time\t\t\tV1_c\t\t\tV2_C\t\t\tV3_C\n");
		fputs(cadena5, fichero);

		for (int i=0;i<50000;i++){

			//				Is_a				Is_b		Is_c			Wn_o			Ld					Lq				Ls				landa_m		Pole_pairs
			pmsm_2 ((AP_24_14)300.0, (AP_24_14)-128, (AP_24_14)-172, (AP_17_7)4.5, (AP_16_1)0.001895, (AP_16_1)0.001895, (AP_16_1)0.0017055, (AP_15_4)3.72, (AP_8_8)16,  &Fem_a, &Fem_b, &Fem_c);

			//printf ("\n%f_%f_%f_%f\n\n\n\n",(float)Fem_a,(float)Fem_b,(float)Fem_c,(float)timee);

			//generate output data and write it to file
			gcvt((float)Fem_a	, 10, cadena1);
			gcvt((float)Fem_b	, 10, cadena2);
			gcvt((float)Fem_c	, 10, cadena3);
			gcvt((float)timee	, 20, cadena4);
			//gcvt((float)(i+1)	, 10, index);

			//clean the string
			for (int j=0;j<101;j++)
				cadena5[j]='\0';

			strcat(cadena5, cadena4);
			strcat(cadena5, "\t");
			strcat(cadena5, cadena1);
			strcat(cadena5, "\t");
			strcat(cadena5, cadena2);
			strcat(cadena5, "\t");
			strcat(cadena5, cadena3);
			strcat(cadena5, "\n");

			fputs(cadena5, fichero);

			timee += 0.0000015;
		}
	}
	printf("\ntodo correcto");
	 */


	//to verify this code, merge the data file generated with PSIM simulation
	//validate pmsm
	{
		AP_21_13 Is_a, Is_b, Is_c, Fem_a_r, Fem_b_r, Fem_c_r;
		AP_32_18 Tem;
		bool SG1, K2;

		AP_24_14 Fem_a, Fem_b, Fem_c;
		char cadena11 [200];
		char cadena22 [200];
		char cadena33 [200];
		char cadena44 [200];
		char cadena55 [200];
		char cadena66 [200];
		char cadena77 [200];
		char cadena88 [200];
		char cadena99 [200];
		//char index [200];
		static float timeee=0;
		FILE* fichero;
		fichero = fopen("pmsm_data_output.txt", "wt");

		//clean the string
		for (int j=0;j<201;j++)
			cadena55[j]='\0';

		strcat(cadena55, "Time\t\t\tIs_a\t\t\tIs_b\t\t\tIs_c \t\t\tFem_a_C\t\t\tFem_b_C\t\t\tFem_c_C\n");
		fputs(cadena55, fichero);

		for (int i=0;i<50000;i++){

			//pmsm ( 		Vs_a,  			Vs_b,  			Vs_c, 			VN_gnd, 		Wn_o, 	K2,  				Ld, 				Lq, 			Ls  			dT_Ls		  SG1, 	 			Rs			lamba_e	    PolePairs &Is_a, 	 &Is_b,  &Is_c, &Fem_a_r,  &Fem_b_r,  &Fem_c_r);
			pmsm ( (AP_21_13)23.0,  (AP_21_13)-12.6,  (AP_21_13)-10.4, (AP_21_13)1.0, (AP_21_13)0.5, (bool)1,  (AP_16_1)0.001895, (AP_16_1)0.001895, (AP_16_1)0.001705, (AP_20_1)0.00087977, (bool)1, (AP_20_1) 0.055, (AP_15_4)3.72, (AP_8_8)16, &Is_a, 	 &Is_b,  &Is_c, &Fem_a_r,  &Fem_b_r,  &Fem_c_r);

			//printf ("\nnumero %f", (float)Fem_c_r);
			//printf("\n\nnumeros: %f %f %f", (float)Fem_a_r, (float)Fem_b_r, (float)Fem_c_r);
			//printf("\ncadena: %s %s %s", cadena99, cadena77, cadena88);

			//generate output data and write it to file
			gcvt((float)Is_a, 10, cadena11);
			gcvt((float)Is_b, 10, cadena22);
			gcvt((float)Is_c, 10, cadena33);

			gcvt((float)Fem_a_r, 10, cadena99);
			gcvt((float)Fem_b_r, 10, cadena77);
			gcvt((float)Fem_c_r, 10, cadena88);
			//gcvt((float)(i+1)	 , 10, index);
			gcvt((float)timeee	, 20, cadena44);

			//clean the string
			for (int j=0;j<201;j++)
				cadena55[j]='\0';

			strcat(cadena55, cadena44);	//time
			strcat(cadena55, "\t");

			strcat(cadena55, cadena11);	//Is_a
			strcat(cadena55, "\t");
			strcat(cadena55, cadena22);	//Is_b
			strcat(cadena55, "\t");
			strcat(cadena55, cadena33);	//Is_c
			strcat(cadena55, "\t");

			strcat(cadena55, cadena99);	//FEM_a
			strcat(cadena55, "\t");
			strcat(cadena55, cadena77);	//FEM_b
			strcat(cadena55, "\t");
			strcat(cadena55, cadena88);	//FEM_c
			strcat(cadena55, "\n");

			fputs(cadena55, fichero);

			timeee += 0.0000015;
		}
	}
	printf("\ntodo correcto");


	return 0;	//0=> everything went fine	|	1=> at least an error occur
}

