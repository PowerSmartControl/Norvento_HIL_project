############################################################
## Script file to setup and run Vivado HLS.
## 26/02/2018
## Power Smart Control - JRF
############################################################

open_project pmsm_inv_prj
set_top bridge3ph
add_files ./src/pmsm_inv.cpp
add_files ./src/pmsm_inv.h
add_files -tb ./src/tb_pmsm_inv.cpp

############################################################
# Synthesis solution
############################################################
open_solution "sol_IP_Vivado"
set_part {xc7z020clg400-1} -tool vivado
create_clock -period 10 -name default
config_rtl -encoding onehot -reset control -reset_level low

# source "./pmsm_prj/sol_sysgen/directives.tcl"



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



#csim_design
#csynth_design
#cosim_design -setup -rtl vhdl
#export_design -rtl vhdl -format sysgen

#close_project