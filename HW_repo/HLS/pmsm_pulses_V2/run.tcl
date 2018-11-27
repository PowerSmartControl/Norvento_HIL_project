############################################################
## Script file to setup and run Vivado HLS.
## 26/02/2018
## Power Smart Control - JRF
############################################################

open_project pmsm_pulses_V2_prj
set_top top_pmsm_function
add_files ./src/pmsm_pulses.cpp
add_files ./src/pmsm_pulses.h
add_files -tb ./src/tb_pmsm_pulses.cpp

############################################################
# Synthesis solution
############################################################
open_solution "sol_IP_Vivado"
set_part {xc7z020clg400-1} -tool vivado
create_clock -period 10 -name default
config_rtl -encoding onehot -reset control -reset_level low

# source "./pmsm_prj/sol_sysgen/directives.tcl"
set_directive_allocation -limit 1 -type operation "calc_sin_cos" mul
set_directive_allocation -limit 1 -type operation "integrate" mul
set_directive_allocation -limit 1 -type operation "top_function" mul
set_directive_interface -mode ap_none -register "top_pmsm_function" mod_a
set_directive_interface -mode ap_none -register "top_pmsm_function" mod_b
set_directive_interface -mode ap_none -register "top_pmsm_function" mod_c


#csim_design
csynth_design
#cosim_design -setup -rtl vhdl
export_design -rtl vhdl -format ip_catalog -description "PMSM_pulses" -vendor "PSC" -display_name "PMSM_pulses"
#export_design -rtl vhdl -format ip_catalog

############################################################
# Sysgen solution
############################################################
open_solution "sol_sysgen"
set_part {xc7z020clg400-1} -tool vivado
create_clock -period 10 -name default
config_rtl -encoding onehot -reset control -reset_level low

# source "./pmsm_prj/sol_sysgen/directives.tcl"
set_directive_allocation -limit 1 -type operation "calc_sin_cos" mul
set_directive_allocation -limit 1 -type operation "integrate" mul
set_directive_allocation -limit 1 -type operation "top_function" mul
set_directive_interface -mode ap_none -register "top_pmsm_function" mod_a
set_directive_interface -mode ap_none -register "top_pmsm_function" mod_b
set_directive_interface -mode ap_none -register "top_pmsm_function" mod_c


#csim_design
csynth_design
#cosim_design -setup -rtl vhdl
export_design -rtl vhdl -format sysgen

#close_project