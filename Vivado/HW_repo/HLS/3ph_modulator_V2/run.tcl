############################################################
## Script file to setup and run Vivado HLS.
## 26/02/2018
## Power Smart Control - JRF
############################################################

open_project three_ph_mod_prj
set_top three_ph_modu
add_files ./src/three_ph_mod.cpp
add_files ./src/three_ph_mod.h
add_files -tb src/tb_three_ph_mod.cpp

############################################################
# Synthesis solution
############################################################
open_solution "sol_IP_Vivado"
set_part {xc7z020clg400-1} -tool vivado
create_clock -period 10 -name default
config_rtl -encoding onehot -reset control -reset_level low

# source "./pmsm_prj/sol_sysgen/directives.tcl"
set_directive_interface -mode ap_none -register "three_ph_modu" modu_a
set_directive_interface -mode ap_none -register "three_ph_modu" T1
set_directive_interface -mode ap_none -register "three_ph_modu" T2
set_directive_interface -mode ap_none -register "three_ph_modu" T3
set_directive_interface -mode ap_none -register "three_ph_modu" T5
set_directive_interface -mode ap_none -register "three_ph_modu" T6
set_directive_interface -mode ap_none -register "three_ph_modu" tri
set_directive_interface -mode ap_none -register "three_ph_modu" T4


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
set_directive_interface -mode ap_none -register "three_ph_modu" modu_a
set_directive_interface -mode ap_none -register "three_ph_modu" T1
set_directive_interface -mode ap_none -register "three_ph_modu" T2
set_directive_interface -mode ap_none -register "three_ph_modu" T3
set_directive_interface -mode ap_none -register "three_ph_modu" T5
set_directive_interface -mode ap_none -register "three_ph_modu" T6
set_directive_interface -mode ap_none -register "three_ph_modu" tri
set_directive_interface -mode ap_none -register "three_ph_modu" T4


#csim_design
csynth_design
#cosim_design -setup -rtl vhdl
export_design -rtl vhdl -format sysgen

#close_project