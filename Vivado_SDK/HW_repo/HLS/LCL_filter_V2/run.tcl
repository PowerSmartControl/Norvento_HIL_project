############################################################
## Script file to setup and run Vivado HLS.
## 27/02/2018
## Power Smart Control - JRF
############################################################

open_project LCL_filter_prj
set_top lcl_filter
add_files ./src/lcl_filter.cpp
add_files ./src/lcl_filter.h
add_files -tb ./src/tb_lcl_filter.cpp
############################################################
# Synthesis solution
############################################################
open_solution "sol_IP_Vivado"
set_part {xc7z020clg400-1} -tool vivado
create_clock -period 10 -name default
set_clock_uncertainty 1
config_rtl -encoding onehot -reset control -reset_level low

# source "./lcl_filter_prj/sol_sysgen/directives.tcl"
set_directive_interface -mode ap_none -register "lcl_filter" IL1_c_r
set_directive_interface -mode ap_none -register "lcl_filter" IL2_c_r
set_directive_interface -mode ap_none -register "lcl_filter" IL2_a_r
set_directive_interface -mode ap_none -register "lcl_filter" IL1_a_r
set_directive_interface -mode ap_none -register "lcl_filter" IL2_b_r
set_directive_interface -mode ap_none -register "lcl_filter" IL1_b_r
set_directive_interface -mode ap_none -register "lcl_filter" Vp_a_r
set_directive_interface -mode ap_none -register "lcl_filter" Vp_b_r
set_directive_interface -mode ap_none -register "lcl_filter" Vp_c_r
set_directive_interface -mode ap_none -register "lcl_filter" V_grid_dac_b
set_directive_interface -mode ap_none -register "lcl_filter" V_grid_dac_c
set_directive_interface -mode ap_none -register "lcl_filter" V_grid_dac_a

#csim_design
csynth_design
#cosim_design -setup -rtl vhdl
#export_design -rtl vhdl -format ip_catalog -description "LCL filter model" -vendor "PSC" -display_name "lcl_filter"
export_design -rtl vhdl -format ip_catalog

############################################################
# Sysgen solution
############################################################
open_solution "sol_sysgen"
set_part {xc7z020clg400-1} -tool vivado
create_clock -period 10 -name default
set_clock_uncertainty 1
config_rtl -encoding onehot -reset control -reset_level low

# source "./lcl_filter_prj/sol_sysgen/directives.tcl"
set_directive_interface -mode ap_none -register "lcl_filter" IL1_c_r
set_directive_interface -mode ap_none -register "lcl_filter" IL2_c_r
set_directive_interface -mode ap_none -register "lcl_filter" IL2_a_r
set_directive_interface -mode ap_none -register "lcl_filter" IL1_a_r
set_directive_interface -mode ap_none -register "lcl_filter" IL2_b_r
set_directive_interface -mode ap_none -register "lcl_filter" IL1_b_r
set_directive_interface -mode ap_none -register "lcl_filter" Vp_a_r
set_directive_interface -mode ap_none -register "lcl_filter" Vp_b_r
set_directive_interface -mode ap_none -register "lcl_filter" Vp_c_r
set_directive_interface -mode ap_none -register "lcl_filter" V_grid_dac_b
set_directive_interface -mode ap_none -register "lcl_filter" V_grid_dac_c
set_directive_interface -mode ap_none -register "lcl_filter" V_grid_dac_a

#csim_design
csynth_design
#cosim_design -setup -rtl vhdl
export_design -rtl vhdl -format sysgen

close_project