############################################################
## Script file to setup and run Vivado HLS.
## 26/02/2018
## Power Smart Control - JRF
############################################################

open_project pmsm_V2_prj
set_top pmsm
add_files ./src/pmsm.cpp
add_files ./src/pmsm.h
add_files -tb ./src/tb_pmsm.cpp

############################################################
# Synthesis solution
############################################################
open_solution "sol_IP_Vivado"
set_part {xc7z020clg400-1} -tool vivado
create_clock -period 5 -name default
config_rtl -encoding onehot -reset control -reset_level low

# source "./pmsm_prj/sol_sysgen/directives.tcl"


#csim_design
csynth_design
#cosim_design -setup -rtl vhdl
export_design -rtl vhdl -format ip_catalog

#close_project