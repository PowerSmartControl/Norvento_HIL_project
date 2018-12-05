############################################################
## Script file to setup and run Vivado HLS.
## 27/02/2018
## Power Smart Control - JRF
############################################################

open_project grid_prj
set_top grid
add_files ./src/grid.cpp
add_files ./src/grid.h
add_files -tb ./src/tb_grid.cpp

############################################################
# Synthesis solution
############################################################
open_solution "sol_IP_Vivado"
set_part {xc7z020clg400-1} -tool vivado
create_clock -period 10 -name default
config_rtl -encoding onehot -reset control -reset_level low

# source "./3ph_bridge_prj/sol_sysgen/directives.tcl"
set_directive_interface -mode ap_none -register "grid" Grid_c_r
set_directive_interface -mode ap_none -register "grid" Grid_a_r
set_directive_interface -mode ap_none -register "grid" Grid_b_r
set_directive_interface -mode ap_none -register "grid" mod_b
set_directive_interface -mode ap_none -register "grid" mod_c
set_directive_interface -mode ap_none -register "grid" I_out_proof
set_directive_interface -mode ap_none -register "grid" mod_a

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
set_directive_interface -mode ap_none -register "grid" Grid_c_r
set_directive_interface -mode ap_none -register "grid" Grid_a_r
set_directive_interface -mode ap_none -register "grid" Grid_b_r
set_directive_interface -mode ap_none -register "grid" mod_b
set_directive_interface -mode ap_none -register "grid" mod_c
set_directive_interface -mode ap_none -register "grid" I_out_proof
set_directive_interface -mode ap_none -register "grid" mod_a

#csim_design
csynth_design
#cosim_design -setup -rtl vhdl
export_design -rtl vhdl -format sysgen

close_project