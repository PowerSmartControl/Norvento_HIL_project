############################################################
## Script file to setup and run Vivado HLS.
## 26/02/2018
## Power Smart Control - JRF
############################################################

open_project gain_offset_truncation_prj
set_top gain_offset_truncation
add_files ./src/gain_offset_truncation.cpp
add_files ./src/gain_offset_truncation.h
add_files -tb ./src/tb_gain_offset_truncation.cpp

############################################################
# Synthesis solution
############################################################
open_solution "sol_IP_Vivado"
set_part {xc7z020clg400-1} -tool vivado
create_clock -period 10 -name default
config_rtl -encoding onehot -reset control -reset_level low

# source "./pmsm_prj/sol_sysgen/directives.tcl"
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_LCL_1_c
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_V_grid_a
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_LCL_1_a
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_pmsm_b
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_V_grid_b
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_V_fem_b
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_V_dc_bus
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_pmsm_a
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_LCL_2_a
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_V_grid_c
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_LCL_2_c
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_V_fem_c
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_V_fem_a
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_pmsm_c
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_LCL_2_b
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_LCL_1_b
set_directive_resource -core RAM_2P_BRAM -latency 2 "gain_offset_truncation" output_vector
set_directive_latency -min 70 -max 75 "gain_offset_truncation"
set_directive_pipeline -off "gain_offset_truncation"

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
create_clock -period 10 -name default
config_rtl -encoding onehot -reset control -reset_level low

# source "./pmsm_prj/sol_sysgen/directives.tcl"
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_LCL_1_c
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_V_grid_a
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_LCL_1_a
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_pmsm_b
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_V_grid_b
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_V_fem_b
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_V_dc_bus
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_pmsm_a
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_LCL_2_a
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_V_grid_c
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_LCL_2_c
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_V_fem_c
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_V_fem_a
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_pmsm_c
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_LCL_2_b
set_directive_interface -mode ap_none -register "gain_offset_truncation" out_I_LCL_1_b
set_directive_resource -core RAM_2P_BRAM -latency 2 "gain_offset_truncation" output_vector
set_directive_latency -min 70 -max 75 "gain_offset_truncation"
set_directive_pipeline -off "gain_offset_truncation"

#csim_design
csynth_design
#cosim_design -setup -rtl vhdl
export_design -rtl vhdl -format sysgen


#close_project