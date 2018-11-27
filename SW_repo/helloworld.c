// PSC | Power Smart Control | JRF | 2018

//libraries
#include <string.h>
#include <stdio.h>
#include "platform.h"				//general SDK and Vivado files, drivers...
#include "xil_printf.h"				//default serial port
#include "xparameters.h"			//base address file
#include "NV_parameter_load.h"		//IP for sending parameters from uP to FPGA
#include "parameter_load_2.h"		//IP for sending parameters from uP to FPGA
#include "NV_io_controller.h"		//IP for communication between uP and FPGA (bidirectional)
#include "Digital_Outputs.h"		//IP for communication between uP and FPGA
#include "xscugic.h"				//interruptions
#include "xgpio.h"					//gpios
#include "xil_exception.h"
#include <xil_io.h>					//necessary for working with IPs

//function prototypes
static void 	FPGA_timer_Intr_Handler 		(void *InstancePtr);
static int  	InterruptSystemSetup			(XScuGic *XScuGicInstancePtr);
static int  	IntcInitFunction				(u16 DeviceId, XGpio *GpioInstancePtr);

//sending parameters from uP to FPGA (NV_parameter load IP driver, memory base position)
#define 	AXI_NV_PARAMETER_LOAD_BASEADDR		    XPAR_NV_PARAMETER_LOAD_0_S00_AXI_BASEADDR
//communication between FPGA and uP (bidirectional)
#define 	AXI_NV_IO_CONTROLLER_BASEADDR			XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR
//communication between FPGA and uP number 2 (bidirectional)
#define 	AXI_NV_PARAMETER_LOAD_2_BASEADDR		XPAR_PARAMETER_LOAD_2_0_S00_AXI_BASEADDR
//communication between FPGA and uP number 3
#define 	AXI_NV_DIGITAL_OUTPUTS_BASEADDR			XPAR_DIGITAL_OUTPUTS_0_S00_AXI_BASEADDR
//gpio
#define 	GPIO_FPGA_timer							XPAR_AXI_GPIO_0_DEVICE_ID
//interruptions
#define 	INTC_GPIO_INTERRUPT_ID_FPGA_timer		XPAR_FABRIC_AXI_GPIO_0_IP2INTC_IRPT_INTR
//interruption mask
#define 	INT 									XGPIO_IR_CH1_MASK
//interruptions
#define 	INTC_DEVICE_ID					XPAR_PS7_SCUGIC_0_DEVICE_ID

//	***	parameter variables per Vivado IP:	***
//general
float t_step_grid=0.0000005, t_step_PMSM=0.0000015;
char *charString = "01100101";
char my_chain[1024]= "";
//AXI_NV_PARAMETER_LOAD_BASEADDR
float j_P_Wind=192420, j_C_bus_dc=0.0051, j_L1=0.0005, j_L2=0.0001, j_C=0.000050, j_rC=0.5, j_freq_grid=74.0, j_Ampl_a=325.0, j_Ampl_b=325.0, j_Ampl_c=325.0, j_phaseStep=284.0, j_V_bus_voltage=800.0, ret_sel_marcha=1.0, mode_igbt_input=1.0, j_lamda_e=3.25, pole_pairs=16, lamda_e=7209.0, j_Lcc=0.00010, j_Rcc=0.010, Lcc_dt=200.0;
int j_DC_bus_fixed=0, j_phaseStep_on=0, j_inv_seq_grid=0, j_mode_L_LCL=0;
//XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR
float mode=0.0, potDig_output_value_1=500.0, potDig_output_value_2=500.0, potDig_output_value_3=500.0, potDig_output_value_4=500.0, Expansor_output_value_1=32.0, Expansor_output_value_2=32.0, Expansor_output_value_3=32.0, nc2=0.0, nc3=0.0, nc4=0.0;
//AXI_NV_PARAMETER_LOAD_2_BASEADDR
float j_rPrecarga=11.0, ena_chop_res=0.0, inv_R_eq=0.002, Download_RC=0.0, j_Ld=62.0, j_Lq=62.0, j_Ls=55.8, dT_Ls=893.8,  j_Rs=7.0, j_Wn=2000.0, j_fe=10.0;//15360.0;
//digital outputs
int dig_out_1=0, dig_out_2=0, dig_out_3=0, dig_out_4=0, dig_out_5=0, dig_out_6=0, dig_out_7=0, dig_out_8=0, dig_out_9=0, dig_out_10=0, dig_out_11=0, dig_out_12=0, dig_out_13=0, dig_out_14=0, dig_out_15=0, dig_out_16=0, dig_out_17=0, dig_out_18=0, dig_out_19=0, dig_out_20=0, dig_out_21=0, dig_out_22=0;
//extra
float j_W_Speed=10.0, j_Cp=0.5, j_R_blades=10.0, j_rL1=0.01, j_rL2=0.01;
int Fan_speed=86;
int counter=0;
int Fan_input_value_READ = 4021;
int Expansor_input_value_READ=0;
int c=0, k=0, n=0;
char expansor_values[7]= {0, 0, 0, 0, 0, 0, 0};
int initialized_flag=0;
int Dig_pot_1=0.0f, Dig_pot_2=0.0f, Dig_pot_3=0.0f, Dig_pot_4=0.0f;
//DAC gains
//float gain_current_grid=2.31648f, gain_voltage_grid=4.64022f, gain_dc_bus=1.365f, gain_current_pmsm=1.2715f,  gain_voltage_pmsm=1.6384f;  //antigua
float gain_current_grid=2.31670f, gain_voltage_grid=4.63400f, gain_dc_bus=1.365f, gain_current_pmsm=2.3367f, gain_voltage_pmsm=1.6384f;	//nueva y revisada
//Peripherals
XGpio 		GPIO_FPGA_timer_1;
XScuGic 	INTCInst;


//	**********************************************************************************************
//		MODE SELECTOR
int manual_or_console=1;	//1=>NV console / 0=>manual (serial terminal - not supported any more)
//	**********************************************************************************************

unsigned int float_to_u32 (float val){
	unsigned int result;
	union float_bytes{
		float v;
		unsigned char bytes[4];
	}
	data;
	data.v = val;
	result = (data.bytes[3]<<24) + (data.bytes[2]<<16) + (data.bytes[1]<<8) + (data.bytes[0]);
	return result;
}

int main()
{
	init_platform();
	int status;																		//status para para inicializar

	//Initialize GPIO
	status = XGpio_Initialize(&GPIO_FPGA_timer_1, GPIO_FPGA_timer);
	if(status != XST_SUCCESS) return XST_FAILURE;
	XGpio_SetDataDirection(&GPIO_FPGA_timer_1, 1, 0xFF);	// Set as input

	//initialize interrupts
	status = IntcInitFunction(INTC_DEVICE_ID, &GPIO_FPGA_timer_1);
	if(status != XST_SUCCESS) return XST_FAILURE;

	//Initializing IP NV_PARAMETER_LOAD
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR,  0, (int)j_P_Wind);
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR,  4, float_to_u32(t_step_grid/j_C_bus_dc));
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR,  8, float_to_u32(t_step_grid/j_L1));
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 12, float_to_u32(t_step_grid/j_L2));
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 16, float_to_u32(t_step_grid/j_C));
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 20, float_to_u32(j_rC));
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 24, (int)j_freq_grid);
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 28, float_to_u32(j_Ampl_a));
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 32, float_to_u32(j_Ampl_b));
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 36, float_to_u32(j_Ampl_c));
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 40, float_to_u32(Lcc_dt));
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 44, (int)j_phaseStep_on);
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 48, (int)j_phaseStep);
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 52, float_to_u32(j_V_bus_voltage));
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 56, (int)lamda_e);
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 60, (int)pole_pairs);
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 64, (int)j_inv_seq_grid);
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 68, (int)j_DC_bus_fixed);
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 72, 1);					//mode_igbt_input_PMSM (1=> NV pulses)
	NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 76, (int)mode_igbt_input);	//(1=> norvento PWM)

	//	***********************************************************************

	//charging default values in NV_IO_CONTROLLER IP
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 0,  (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 4,  (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 8,  (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 12, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 16, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 20, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 24, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 28, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 32, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 36, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 40, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 44, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 48, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 52, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 56, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 60, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 64, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 68, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 72, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 76, (int)10);//potDig_output_value_1);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 80, (int)10);//potDig_output_value_2);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 84, (int)10);//potDig_output_value_3);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 88, (int)10);//potDig_output_value_4);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 92, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 96, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 100, (int)0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 104, 25);		//input
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 108, 25);		//input

	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 112, 0);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 116, nc2);

	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 120, nc3);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 124, nc4);
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 128, 25);		//input
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 132, 25);		//input
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 136, 25);		//input
	NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 140, 25);		//input
	//inputs should be written for driver initializing

	//	***********************************************************************

	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  0, float_to_u32(0.15f));
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  4, float_to_u32(j_rPrecarga));
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  8, (int)ena_chop_res);
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  12, float_to_u32(0.2f));
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  16, float_to_u32(gain_current_grid));	//gains for grid currents and voltages
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  20, float_to_u32(gain_voltage_grid));	//gains for grid currents and voltages
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  24, float_to_u32(gain_dc_bus));			//gains for DC_bus voltage
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  28, float_to_u32(inv_R_eq));
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  32, (int)j_mode_L_LCL);
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  36, (int)Download_RC);
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  40, (int)j_Ld);
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  44, (int)j_Lq);
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  48, (int)j_Rs);
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  52, (int)j_Wn);	//j_Wn -> AP21_13 -> in RPMs
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  56, float_to_u32(gain_current_pmsm));	//gains for pmsm currents and voltages
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  60, float_to_u32(gain_voltage_pmsm));	//gains for pmsm currents and voltages
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  64, (int)j_Ls);
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  68, (int)dT_Ls);
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  72, (int)20);	//ma inner modulator
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  76, (int)0);		//not connected
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  80, (int)0);		//not connected
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  84, (int)0);		//not connected
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  88, (int)0);		//not connected
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  92, (int)0);		//not connected
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  96, (int)0);		//not connected
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  100, (int)0);	//not connected
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  104, (int)0);	//not connected
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  108, (int)0);	//not connected
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  112, (int)0);	//not connected
	PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  116, (int)0);	//not connected

	//	***********************************************************************

	//DIGITAL_OUTPUTS IP
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 0, (int)dig_out_1);
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 4, (int)dig_out_2);
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 8, (int)dig_out_3);
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 12, (int)dig_out_4);
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 16, (int)dig_out_5);
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 20, (int)dig_out_6);
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 24, (int)dig_out_7);
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 28, (int)dig_out_8);

	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 32, (int)dig_out_9);
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 36, (int)dig_out_10);
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 40, (int)dig_out_11);
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 44, (int)dig_out_12);
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 48, (int)dig_out_13);
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 52, (int)dig_out_14);
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 56, (int)dig_out_15);
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 60, (int)dig_out_16);

	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 64, (int)dig_out_22);	//not used
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 68, (int)0);			//not connected
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 72, (int)dig_out_17);	//start_stop
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 76, (int)dig_out_18);	//R_Reset
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 80, (int)dig_out_19);	//not used
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 84, (int)dig_out_20);	//not used
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 88, (int)dig_out_21);	//not used
	DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 92, (int)0);			//not connected

	//Initialization finished
	initialized_flag=1; //this enable the console communication
	//initialized_flag=0;

	//never-ending loop
	for (;;){

		if (manual_or_console==1){	//mode console

			//expansor of inputs read
			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR,  108, 25);
			Expansor_input_value_READ	= NV_IO_CONTROLLER_mReadReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR,  108);
			//convert decimal to binary for digital inputs
			n=Expansor_input_value_READ;
			for (c = 7; c >= 0; c--)
			{
				k = n >> c;
				if (k & 1){
					expansor_values[7-c] = '1';
				}
				else{
					expansor_values[7-c] = '0';
				}
			}
			strcpy(charString,expansor_values);

			//fan read
			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR,  104, 25);
			Fan_input_value_READ 		= NV_IO_CONTROLLER_mReadReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR,  104);
			Fan_speed =  (int)(((float)Fan_input_value_READ*100)/4096);

			//update FPGA values from console:
			// NV_PARAMETER_LOAD IP
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR,  0, (int)j_P_Wind);
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR,  4, float_to_u32(t_step_grid/j_C_bus_dc));
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR,  8, float_to_u32(t_step_grid/j_L1));
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 12, float_to_u32(t_step_grid/j_L2));
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 16, float_to_u32(t_step_grid/j_C));
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 20, float_to_u32(j_rC));
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 24, (int)j_freq_grid);
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 28, float_to_u32(j_Ampl_a));	//peak value
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 32, float_to_u32(j_Ampl_b));	//peak value
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 36, float_to_u32(j_Ampl_c));	//peak value
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 40, float_to_u32(Lcc_dt));
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 44, (int)j_phaseStep_on);
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 48, (int)j_phaseStep);
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 52, float_to_u32(j_V_bus_voltage));
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 56, (int)(lamda_e+0.5));			//0.5 is used as a rounding method
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 60, (int)pole_pairs);
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 64, (int)j_inv_seq_grid);
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 68, (int)j_DC_bus_fixed);
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 72, 1);	//PMSM side inverter); (1=> NV connector PMSM pulses)
			NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR, 76, 1);	//Grid side inverter); (1=> NV connector GRID pulses)

			///////

			// NV_IO_CONTROLLER IP
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 0, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 4, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 8, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 12, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 16, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 20, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 24, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 28, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 32, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 36, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 40, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 44, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 48, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 52, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 56, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 60, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 64, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 68, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 72, (int)0);
			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 76, (int)Dig_pot_1);//potDig_output_value_1);	//U73
			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 80, (int)Dig_pot_2);//potDig_output_value_2);	//U74
			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 84, (int)Dig_pot_3);//potDig_output_value_3);	//U75
			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 88, (int)Dig_pot_4);//potDig_output_value_4);	//U76
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 92, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 96, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 100, (int)0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 104, 25);		//input
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 108, 25);		//input
			//
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 112, 0);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 116, nc2);
			//
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 120, nc3);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 124, nc4);
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 128, 25);		//input
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 132, 25);		//input
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 136, 25);		//input
			//			NV_IO_CONTROLLER_mWriteReg (XPAR_NV_IO_CONTROLLER_0_S00_AXI_BASEADDR, 140, 25);		//input

			///////

			int KK1 =charString[7];
			int KK2 =charString[6];
			int KK3 =charString[5];
			int CCB1 =charString[0];

			Download_RC=0;

			//For LCL filter
			if (j_mode_L_LCL==1){
				if (CCB1=='1')
					inv_R_eq=(float)(1.0f/150.0f);
				else if (KK1=='0' && KK3=='0' && KK2=='0'){
					Download_RC=1;
					inv_R_eq=(float)(1.0f/1800.0f);
				}
				else if (KK1=='0' && KK3=='0' && KK2=='1'){
					Download_RC=0;
					inv_R_eq=(float)(1.0f/500.0f);//2000
				}
				else if (KK1=='0' && KK3=='1')
					inv_R_eq=(float)(1.0f/300.0f);//300
				else if (KK1=='1' && KK3=='0')
					inv_R_eq=(float)(1.0f/100.0f);//180
				else if (KK1=='1' && KK3=='1')
					inv_R_eq=(float)(1.0f/1100.0f);//180
			}
			else{	//LL filter
				if (CCB1=='1')
					inv_R_eq=(float)(1.0f/150.0f);
				else if (KK1=='0' && KK3=='0' && KK2=='0'){
					Download_RC=1;
					inv_R_eq=(float)(1.0f/1800.0f);
				}
				else if (KK1=='0' && KK3=='0' && KK2=='1'){
					Download_RC=0;
					inv_R_eq=(float)(1.0f/2000.0f);
				}
				else if (KK1=='0' && KK3=='1')
					inv_R_eq=(float)(1.0f/250.0f);//270
				else if (KK1=='1' && KK3=='0')
					inv_R_eq=(float)(1.0f/180.0f);//180
				else if (KK1=='1' && KK3=='1')
					inv_R_eq=(float)(1.0f/80.0f);//100
			}


			//inv_R_eq=(float)(1.0f/10000.0f);

			// NV_PARAMETER_LOAD_2
			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  0, float_to_u32(j_rL2));//0.0078125f*j_rL2));
			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  4, float_to_u32(j_rPrecarga));
			//			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  8, ena_chop_res);
			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  12, float_to_u32(j_rL1));//0.0078125f*));
			//			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  16, float_to_u32(gain_current_grid));
			//			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  20, float_to_u32(gain_voltage_grid));
			//			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  24, float_to_u32(gain_dc_bus));
			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  28, float_to_u32(inv_R_eq));
			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  32, (int)j_mode_L_LCL);
			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  36, (int)Download_RC);
			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  40, (int)(j_Ld+0.5));			//0.5 is used as a rounding method
			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  44, (int)(j_Lq+0.5));			//0.5 is used as a rounding method
			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  48, (int)(j_Rs+0.5));			//0.5 is used as a rounding method
			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  52, (int)(j_Wn+0.5));			//0.5 is used as a rounding method
			//			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  56, float_to_u32(gain_current_pmsm));
			//			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  60, float_to_u32(gain_voltage_pmsm));
			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  64, (int)(j_Ls+0.5));			//0.5 is used as a rounding method
			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  68, (int)(dT_Ls+0.5));			//0.5 is used as a rounding method
			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  72, (int)50);					//ma inner modulator ma belongs to (0-255)
			//			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  76, sp_2_19);
			//			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  80, sp_2_20);
			//			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  84, sp_2_21);
			//			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  88, sp_2_22);
			//			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  92, sp_2_23);
			//			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  96, sp_2_24);
			//			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  100, sp_2_25);
			//			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  104, sp_2_26);
			//			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  108, sp_2_27);
			//			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  112, sp_2_28);
			//			PARAMETER_LOAD_2_mWriteReg (AXI_NV_PARAMETER_LOAD_2_BASEADDR,  116, sp_2_29);

			///////

			//DIGITAL_OUTPUTS IP
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 0, (int)dig_out_1);
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 4, (int)dig_out_2);
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 8, (int)dig_out_3);
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 12, (int)dig_out_4);
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 16, (int)dig_out_5);
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 20, (int)dig_out_6);
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 24, (int)dig_out_7);
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 28, (int)dig_out_8);

			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 32, (int)dig_out_9);
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 36, (int)dig_out_10);
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 40, (int)dig_out_11);
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 44, (int)dig_out_12);
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 48, (int)dig_out_13);
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 52, (int)dig_out_14);
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 56, (int)dig_out_15);
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 60, (int)dig_out_16);

			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 64, (int)dig_out_22);	//spare 4
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 68, (int)0);			//not connected
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 72, (int)dig_out_17);	//start_stop
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 76, (int)dig_out_18);	//R_Reset
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 80, (int)dig_out_19);	//spare 1
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 84, (int)dig_out_20);	//spare 2
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 88, (int)dig_out_21);	//spare 3
			DIGITAL_OUTPUTS_mWriteReg (AXI_NV_DIGITAL_OUTPUTS_BASEADDR, 92, (int)0);			//not connected

		}
		else{	//IN THIS VERSION SERIAL TERMINAL CAPABILITY IS NOT SUPPORTED
			/*
			printf("DAC_analog_output_maxValue_14 (1 to 4095):\t%i->%fV\t\tchoose->270\n", analog_output_maxValue_14, ((float)analog_output_maxValue_14*5/4096));
			printf("\nSelect parameter to modify ->");
			scanf(" %d", &aux);
			switch (aux)
			{
			case 1:{
				Pi=aux_2;
				NV_PARAMETER_LOAD_mWriteReg (AXI_NV_PARAMETER_LOAD_BASEADDR,  0, Pi);
			}
			break;
			 */
		}

	}	//for loop end

	cleanup_platform();
	return 0;

}	//main end


//gpio interrupt handler -> ticker 1seg
void FPGA_timer_Intr_Handler(void *InstancePtr)
{
	XGpio_InterruptDisable(&GPIO_FPGA_timer_1, INT);										//DESHABILITAR LA INTERRUPCION
	if ((XGpio_InterruptGetStatus(&GPIO_FPGA_timer_1) & INT) != INT) {return;} 			//Ignore additional button presses

	char ch;
	if (manual_or_console==1 && initialized_flag==1){	//mode console
		counter++;

		//Digital inputs signals
		printf("%c\n", charString[7]);	//K1
		printf("%c\n", charString[6]);	//K2
		printf("%c\n", charString[5]);	//K3
		printf("%c\n", charString[4]);	//K4
		printf("%c\n", charString[3]);	//K5
		printf("%c\n", charString[2]);	//K6
		printf("%c\n", charString[0]);	//CB1
		printf("%c\n", charString[1]);	//Emergency lamp

		//fan speed
		printf("%i\n", Fan_speed);

		//shaft speed
		printf("%.2f\n", (float)(j_Wn/256.0f));

		printf("P pp %i\n", counter);		//send data command for console

		scanf("%s", &my_chain);
		sscanf(my_chain, "%d", &dig_out_1);	//R_vent_break
		scanf("%d%c", &dig_out_3, &ch);		//R_dif
		scanf("%d%c", &dig_out_5, &ch);		//r_SG1
		scanf("%d%c", &dig_out_6, &ch);		//R_emerg
		scanf("%d%c", &dig_out_10, &ch);	//R_var
		scanf("%d%c", &dig_out_11, &ch);	//R_UAC
		scanf("%d%c", &dig_out_12, &ch);	//R_temp_max
		scanf("%d%c", &dig_out_13, &ch);	//R_temp_min
		scanf("%d%c", &dig_out_14, &ch);	//R_hydr
		scanf("%d%c", &dig_out_15, &ch);	//R_break_heat
		scanf("%d%c", &dig_out_17, &ch);	//R_start_stop
		scanf("%d%c", &dig_out_18, &ch);	//R_reset

		scanf("%d%c", &dig_out_19, &ch);	//spare_1
		scanf("%d%c", &dig_out_20, &ch);	//spare_2
		scanf("%d%c", &dig_out_21, &ch);	//spare_3
		scanf("%d%c", &dig_out_22, &ch);	//spare_4

		scanf("%d%c", &dig_out_7, &ch);		//CB1
		scanf("%d%c", &dig_out_8, &ch);		//R_grid_K1
		scanf("%d%c", &dig_out_4, &ch);		//R_gen_k2
		scanf("%d%c", &dig_out_9, &ch);		//R_pre_K3
		scanf("%d%c", &dig_out_16, &ch);	//R_heat_K4
		scanf("%d%c", &dig_out_2, &ch);		//R_vent_K5

		scanf("%f%c", &potDig_output_value_1, &ch);
		scanf("%f%c", &potDig_output_value_2, &ch);
		scanf("%f%c", &potDig_output_value_3, &ch);
		scanf("%f%c", &potDig_output_value_4, &ch);

		scanf("%d%c", &j_DC_bus_fixed, &ch);
		scanf("%d%c", &j_phaseStep_on, &ch);
		scanf("%d%c", &j_inv_seq_grid, &ch);
		scanf("%d%c", &j_mode_L_LCL, &ch);

		scanf("%f%c", &j_Ld, &ch);
		scanf("%f%c", &j_Lq, &ch);
		scanf("%f%c", &j_Rs, &ch);
		scanf("%f%c", &j_fe, &ch);
		scanf("%f%c", &j_lamda_e, &ch);
		scanf("%f%c", &pole_pairs, &ch);

		scanf("%f%c", &j_C_bus_dc, &ch);
		scanf("%f%c", &j_V_bus_voltage, &ch);
		scanf("%f%c", &j_L1, &ch);
		scanf("%f%c", &j_L2, &ch);
		scanf("%f%c", &j_C, &ch);
		scanf("%f%c", &j_rL1, &ch);
		scanf("%f%c", &j_rL2, &ch);
		scanf("%f%c", &j_rPrecarga, &ch);
		scanf("%f%c", &j_rC, &ch);
		scanf("%f%c", &j_phaseStep, &ch);
		scanf("%f%c", &j_freq_grid, &ch);
		scanf("%f%c", &j_Ampl_a, &ch);
		scanf("%f%c", &j_Ampl_b, &ch);
		scanf("%f%c", &j_Ampl_c, &ch);

		scanf("%f%c", &j_Lcc, &ch);
		scanf("%f%c", &j_Rcc, &ch);

		//calculate mechanical speed from electrical frequency
		j_Wn = (int)(3217.0*j_fe/(pole_pairs*2));	//Wn (rad/s) = (120*f*2*pi*2^8 / pole_number*60) = 3217.0*f/pole_number

		j_Ampl_a=(j_Ampl_a*1.4142);
		j_Ampl_b=(j_Ampl_b*1.4142);
		j_Ampl_c=(j_Ampl_c*1.4142);

		lamda_e=(j_lamda_e*2048.0);

		//j_C = (3.0f*j_C);	//Convert delta to star values of capacitor branch in LCL filter - not necessary!

		j_freq_grid=(4000.0f/j_freq_grid-1);
		j_phaseStep=(5.6888f*j_phaseStep);

		j_Ls=j_Ld*0.9; 				//still no fixed point conversion / Ls=0.9*Ld
		j_Ld=(j_Ld*32768.0);
		j_Lq=(j_Lq*32768.0);		//fixed point conversion '32768'

		j_Rs=(j_Rs*16384.0);		//fixed point conversion '16384'

		dT_Ls = (0.0000015 / j_Ls)*524288.0;   //fixed point conversion '524288' / 0.0000015 is pmsm t_step

		j_Ls=j_Ls*32768.0;			//fixed point conversion '32768'

		Lcc_dt = j_Lcc/0.000005;	//Lcc/time_step

		Dig_pot_1 = (potDig_output_value_1*1024*9100)/(20080*9100-potDig_output_value_1*20080);	//NTC1 ISO	//the potentiometer whole resistance is 20kohm. 80ohm is the wiper resistance => R=20080
		Dig_pot_2 = (potDig_output_value_2*1024*6800)/(20080*6800-potDig_output_value_2*20080);	//PTC ISO
		Dig_pot_3 = (potDig_output_value_3*1024*9100)/(20080*9100-potDig_output_value_3*20080);	//NTC MED
		Dig_pot_4 = (potDig_output_value_4*1024*1650)/(20080*1650-potDig_output_value_4*20080);	//PT1000 NISO

		//printf ("NV_1_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d_%f_%f_%f_%f_1_\n", dig_out_1, dig_out_2, dig_out_3, dig_out_4, dig_out_5, dig_out_6, dig_out_7, dig_out_8, dig_out_9, dig_out_10, dig_out_11, dig_out_12, dig_out_13, dig_out_14, dig_out_15, dig_out_16, dig_out_17, dig_out_18, NTC_0, NTC_1, NTC_2, NTC_3);
		//printf ("NV_2_%d_%d_%d_%d_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_2_\n", j_DC_bus_fixed, j_mode_L_LCL, j_phaseStep_on, j_inv_seq_grid, j_C_bus_dc, j_V_bus_voltage, j_L1, j_L2, j_C, j_rL1, j_rL2, j_rPrecarga, j_rC, j_phaseStep, j_freq_grid, j_Ampl_a, j_Ampl_b, j_Ampl_c);
		//printf ("NV_3_%d_%d_%d_%d_3_\n",  j_DC_bus_fixed, j_phaseStep_on, j_inv_seq_grid, j_mode_L_LCL);
		/*printf ("NV_4_%d_%d_%d_%d_%d_%d_%d_%d_%d_4_\n",  dig_out_1, dig_out_2, dig_out_3, dig_out_4, dig_out_5, dig_out_6, dig_out_7, dig_out_8, dig_out_9);
		printf ("NV_5_%d_%d_%d_%d_%d_%d_%d_%d_%d_5_\n",  dig_out_10, dig_out_11, dig_out_12, dig_out_13, dig_out_14, dig_out_15, dig_out_16, dig_out_17, dig_out_18);
		printf ("NV_6_%d_%d_%d_%d_%d_%d_%d_%d_%d_6_\n",  dig_out_19, dig_out_20, dig_out_21, dig_out_22, dig_out_14, dig_out_15, dig_out_16, dig_out_17, dig_out_18);*/
		//printf ("NV_6_%d_%d_%d_%d_6_\n",  Dig_pot_1, Dig_pot_2, Dig_pot_3, Dig_pot_4);
		printf ("NV Test terminal V2... OK \n");

		//mode selector and grid effect addition
		if (j_mode_L_LCL==0){
			j_L2=j_L2+j_L1+j_Lcc;	//L2 eq in LL filter with grid contribution
			j_rL2 = j_rL1 + j_Rcc;
		}
		else{

		}
		j_L2=j_L2+j_Lcc;	//LCL filter with grid contribution
		j_rL2 = j_rL1 + j_Rcc;
	}

	(void)XGpio_InterruptClear(&GPIO_FPGA_timer_1, INT);
	XGpio_InterruptEnable(&GPIO_FPGA_timer_1, INT);

}

//enable GPIO interrupts
int InterruptSystemSetup(XScuGic *XScuGicInstancePtr)
{
	XGpio_InterruptEnable(&GPIO_FPGA_timer_1, INT);

	XGpio_InterruptGlobalEnable(&GPIO_FPGA_timer_1);

	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT, (Xil_ExceptionHandler)XScuGic_InterruptHandler, XScuGicInstancePtr);
	Xil_ExceptionEnable();

	return XST_SUCCESS;
}

//=================================================================================================
//joining handlers to interrupt sources
int IntcInitFunction (u16 DeviceId, XGpio *GpioInstancePtr)
{
	XScuGic_Config *IntcConfig;
	int status;

	//initialize interrupt controller
	IntcConfig = XScuGic_LookupConfig(DeviceId);
	status = XScuGic_CfgInitialize(&INTCInst, IntcConfig, IntcConfig->CpuBaseAddress);
	if(status != XST_SUCCESS) return XST_FAILURE;

	status = InterruptSystemSetup(&INTCInst);
	if(status != XST_SUCCESS) return XST_FAILURE;

	// Connect BTN interrupt to handler
	status = XScuGic_Connect(&INTCInst, INTC_GPIO_INTERRUPT_ID_FPGA_timer, (Xil_ExceptionHandler)FPGA_timer_Intr_Handler, (void *)GpioInstancePtr);
	if(status != XST_SUCCESS) return XST_FAILURE;


	// Enable GPIO interrupts interrupt
	XGpio_InterruptEnable(GpioInstancePtr, 1);
	XGpio_InterruptGlobalEnable(GpioInstancePtr);

	// Enable GPIO interrupts in the controller
	XScuGic_Enable(&INTCInst, INTC_GPIO_INTERRUPT_ID_FPGA_timer);

	return XST_SUCCESS;
}

