############################################################
## Script file to setup and run Vivado HLS.
## 26/02/2018
## Power Smart Control - JRF
############################################################

open_project grid_pulses_V2_prj
set_top top_grid_function
add_files ./src/grid_pulses.cpp
add_files ./src/grid_pulses.h
add_files -tb ./src/tb_grid_pulses.cpp

############################################################
# Synthesis solution
############################################################
open_solution "sol_IP_Vivado"
set_part {xc7z020clg400-1} -tool vivado
create_clock -period 10 -name default
config_rtl -encoding onehot -reset control -reset_level low

# source "./pmsm_prj/sol_sysgen/directives.tcl"
set_directive_allocation -limit 1 -type operation "calc_sin_cos" mul
set_directive_allocation -limit 1 -type operation "grid_calculation" mul
set_directive_allocation -limit 2 -type operation "top_function" mul
set_directive_resource -core RAM_2P_BRAM "calc_sin_cos" sin_func
set_directive_resource -core RAM_2P_BRAM "grid_calculation" full_sine
set_directive_interface -mode ap_none -register "top_grid_function" grid_c
set_directive_interface -mode ap_none -register "top_grid_function" mod_a
set_directive_interface -mode ap_none -register "top_grid_function" grid_b
set_directive_interface -mode ap_none -register "top_grid_function" mod_b
set_directive_interface -mode ap_none -register "top_grid_function" mod_c
set_directive_interface -mode ap_none -register "top_grid_function" grid_a

#csim_design
csynth_design
#cosim_design -setup -rtl vhdl
export_design -rtl vhdl -format ip_catalog -description "grid_pulses" -vendor "PSC" -display_name "grid_pulses"
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
set_directive_allocation -limit 1 -type operation "grid_calculation" mul
set_directive_allocation -limit 2 -type operation "top_function" mul
set_directive_resource -core RAM_2P_BRAM "calc_sin_cos" sin_func
set_directive_resource -core RAM_2P_BRAM "grid_calculation" full_sine
set_directive_interface -mode ap_none -register "top_grid_function" grid_c
set_directive_interface -mode ap_none -register "top_grid_function" mod_a
set_directive_interface -mode ap_none -register "top_grid_function" grid_b
set_directive_interface -mode ap_none -register "top_grid_function" mod_b
set_directive_interface -mode ap_none -register "top_grid_function" mod_c
set_directive_interface -mode ap_none -register "top_grid_function" grid_a


#csim_design
csynth_design
#cosim_design -setup -rtl vhdl
export_design -rtl vhdl -format sysgen

#close_project