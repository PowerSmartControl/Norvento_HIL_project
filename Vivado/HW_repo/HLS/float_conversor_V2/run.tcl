############################################################
## Script file to setup and run Vivado HLS.
## 26/02/2018
## Power Smart Control - JRF
############################################################

open_project float_conversor_prj
set_top float_conversor
add_files ./src/float_conversor.cpp
add_files ./src/float_conversor.h
add_files -tb src/tb_float_conversor.cpp

############################################################
# Synthesis solution
############################################################
open_solution "sol_IP_Vivado"
set_part {xc7z020clg400-1} -tool vivado
create_clock -period 13 -name default
config_rtl -encoding onehot -reset control -reset_level low

# source "./pmsm_prj/sol_sysgen/directives.tcl"
set_directive_interface -mode ap_none -register "float_conversor" out_2
set_directive_interface -mode ap_none -register "float_conversor" out_3
set_directive_interface -mode ap_none -register "float_conversor" out_1
set_directive_interface -mode ap_none -register "float_conversor" out_4
set_directive_interface -mode ap_none -register "float_conversor" out_5
set_directive_interface -mode ap_none -register "float_conversor" out_6


#csim_design
csynth_design
#cosim_design -setup -rtl vhdl
#export_design -rtl vhdl -format ip_catalog -description "wind_turb model" -vendor "PSC" -display_name "wind_turb"
export_design -rtl vhdl -format ip_catalog

############################################################
# Sysgen solution
############################################################
open_solution "sol_sysgen"
set_part {xc7z020clg400-1} -tool vivado
create_clock -period 13 -name default
config_rtl -encoding onehot -reset control -reset_level low

# source "./pmsm_prj/sol_sysgen/directives.tcl"
set_directive_interface -mode ap_none -register "float_conversor" out_2
set_directive_interface -mode ap_none -register "float_conversor" out_3
set_directive_interface -mode ap_none -register "float_conversor" out_1
set_directive_interface -mode ap_none -register "float_conversor" out_4
set_directive_interface -mode ap_none -register "float_conversor" out_5
set_directive_interface -mode ap_none -register "float_conversor" out_6


#csim_design
csynth_design
#cosim_design -setup -rtl vhdl
export_design -rtl vhdl -format sysgen

#close_project