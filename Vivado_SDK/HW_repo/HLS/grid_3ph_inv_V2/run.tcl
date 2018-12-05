############################################################
## Script file to setup and run Vivado HLS.
## 27/02/2018
## Power Smart Control - JRF
############################################################

open_project grid_3ph_bridge_prj
set_top grid_bridge3ph
add_files ./src/grid_3ph_bridge.cpp
add_files ./src/grid_3ph_bridge.h
add_files -tb ./src/tb_grid_3ph_bridge.cpp

############################################################
# Synthesis solution
############################################################
open_solution "sol_IP_Vivado"
set_part {xc7z020clg400-1} -tool vivado
create_clock -period  10 -name default
config_rtl -encoding onehot -reset control -reset_level low

# source "./3ph_bridge_prj/sol_sysgen/directives.tcl"
set_directive_interface -mode ap_none -register "grid_bridge3ph" Vb_r
set_directive_interface -mode ap_none -register "grid_bridge3ph" Vc_r
set_directive_interface -mode ap_none -register "grid_bridge3ph" Idc_r
set_directive_interface -mode ap_none -register "grid_bridge3ph" V_n_gnd_r
set_directive_interface -mode ap_none -register "grid_bridge3ph" Va_r


#csim_design
csynth_design
#cosim_design -setup -rtl vhdl
#export_design -rtl vhdl -format ip_catalog -description "LCL filter model" -vendor "PSC" -display_name "3ph_bridge"
export_design -rtl vhdl -format ip_catalog

############################################################
# Sysgen solution
############################################################
open_solution "sol_sysgen"
set_part {xc7z020clg400-1} -tool vivado
create_clock -period 10 -name default
config_rtl -encoding onehot -reset control -reset_level low

# source "./3ph_bridge_prj/sol_sysgen/directives.tcl"
set_directive_interface -mode ap_none -register "grid_bridge3ph" Vb_r
set_directive_interface -mode ap_none -register "grid_bridge3ph" Vc_r
set_directive_interface -mode ap_none -register "grid_bridge3ph" Idc_r
set_directive_interface -mode ap_none -register "grid_bridge3ph" V_n_gnd_r
set_directive_interface -mode ap_none -register "grid_bridge3ph" Va_r



#csim_design
csynth_design
#cosim_design -setup -rtl vhdl
export_design -rtl vhdl -format sysgen

close_project