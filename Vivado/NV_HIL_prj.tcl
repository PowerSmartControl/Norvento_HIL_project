#*****************************************************************************************
# 	Script to configure the project
#
#	PSC - JRF - 26/11/2018
#
#*****************************************************************************************

# 	use the following path for regenerating the project: C:\NV_HIL
#   all paths are referred to run_prj.tcl file

#*****************************************************************************************

# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir [file dirname [info script]]

# Use origin directory path location variable, if specified in the tcl shell
if { [info exists ::origin_dir_loc] } {
  set origin_dir $::origin_dir_loc
}

# Set the project name
set project_name "NV_HIL_project"

# Use project name variable, if specified in the tcl shell
if { [info exists ::user_project_name] } {
  set project_name $::user_project_name
}

variable script_file
set script_file "NV_HIL_prj.tcl"

# Help information for this script
proc help {} {
  variable script_file
  puts "\nDescription:"
  puts "Recreate a Vivado project from this script. The created project will be"
  puts "functionally equivalent to the original project for which this script was"
  puts "generated. The script contains commands for creating a project, filesets,"
  puts "runs, adding/importing sources and setting properties on various objects.\n"
  puts "Syntax:"
  puts "$script_file"
  puts "$script_file -tclargs \[--origin_dir <path>\]"
  puts "$script_file -tclargs \[--project_name <name>\]"
  puts "$script_file -tclargs \[--help\]\n"
  puts "Usage:"
  puts "Name                   Description"
  puts "-------------------------------------------------------------------------"
  puts "\[--origin_dir <path>\]  Determine source file paths wrt this path. Default"
  puts "                       origin_dir path value is \".\", otherwise, the value"
  puts "                       that was set with the \"-paths_relative_to\" switch"
  puts "                       when this script was generated.\n"
  puts "\[--project_name <name>\] Create project with the specified name. Default"
  puts "                       name is the name of the project from where this"
  puts "                       script was generated.\n"
  puts "\[--help\]               Print help information for this script"
  puts "-------------------------------------------------------------------------\n"
  exit 0
}

if { $::argc > 0 } {
  for {set i 0} {$i < [llength $::argc]} {incr i} {
    set option [string trim [lindex $::argv $i]]
    switch -regexp -- $option {
      "--origin_dir"   { incr i; set origin_dir [lindex $::argv $i] }
      "--project_name" { incr i; set project_name [lindex $::argv $i] }
      "--help"         { help }
      default {
        if { [regexp {^-} $option] } {
          puts "ERROR: Unknown option '$option' specified, please type '$script_file -tclargs --help' for usage info.\n"
          return 1
        }
      }
    }
  }
}

# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/"]"

# Create project
#create_project ${project_name} ./${project_name} -part xc7z020clg400-1
create_project NV_HIL_prj $origin_dir/NV_HIL_prj -part xc7z020clg400-1

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Reconstruct message rules
# None

# Set project properties
set obj [current_project]
set_property -name "board_part" -value "em.avnet.com:microzed_7020:part0:1.1" -objects $obj
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "dsa.num_compute_units" -value "60" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$proj_dir/${project_name}.cache/ip" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "target_language" -value "VHDL" -objects $obj
set_property -name "xpm_libraries" -value "XPM_CDC XPM_FIFO XPM_MEMORY" -objects $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set IP repository paths
set obj [get_filesets sources_1]
set_property "ip_repo_paths" "[file normalize "$origin_dir/HW_repo/IP_repo/Digital_Outputs/Digital_Outputs_1.0"] [file normalize "$origin_dir/HW_repo/HLS/pmsm_pulses_V2/pmsm_pulses_V2_prj/sol_IP_Vivado"] [file normalize "$origin_dir/HW_repo/HLS/grid_pulses_V2/grid_pulses_V2_prj/sol_IP_Vivado"] [file normalize "$origin_dir/HW_repo/IP_repo/parameter_load_2/parameter_load_2_1.0"] [file normalize "$origin_dir/HW_repo/HLS/float_conversor_V2/float_conversor_prj/sol_IP_Vivado"] [file normalize "$origin_dir/HW_repo/HLS/3ph_modulator_V2/three_ph_mod_prj/sol_IP_Vivado"] [file normalize "$origin_dir/HW_repo/IP_repo/IP_AD5293/IP_AD5293"] [file normalize "$origin_dir/HW_repo/IP_repo/TCA_9538_inputs"] [file normalize "$origin_dir/HW_repo/HLS/grid_3ph_inv_V2/grid_3ph_bridge_prj/sol_IP_Vivado"] [file normalize "$origin_dir/HW_repo/HLS/LCL_filter_V2/LCL_filter_prj/sol_IP_Vivado"] [file normalize "$origin_dir/HW_repo/HLS/DC_bus_V2/dc_bus_prj/sol_IP_Vivado"] [file normalize "$origin_dir/HW_repo/HLS/grid_V2/grid_prj/sol_IP_Vivado"] [file normalize "$origin_dir/HW_repo/IP_repo/IP_TCA9538"] [file normalize "$origin_dir/HW_repo/HLS/gain_offset_truncation_V2/gain_offset_truncation_prj/sol_IP_Vivado"] [file normalize "$origin_dir/HW_repo/IP_repo/IP_NV_io_controller/NV_io_controller_1.0"] [file normalize "$origin_dir/HW_repo/IP_repo/IP_DAC121S101/IP_DAC121S101"] [file normalize "$origin_dir/HW_repo/IP_repo/IP_parameter_load/NV_parameter_load_1.0"] [file normalize "$origin_dir/HW_repo/HLS/wind_tur_V2/wind_turb_V2_prj/sol_IP_Vivado"] [file normalize "$origin_dir/HW_repo/HLS/pmsm_V2/pmsm_V2_prj/sol_IP_Vivado"] [file normalize "$origin_dir/HW_repo/HLS/pmsm_3ph_inv_V2/pmsm_inv_prj/sol_IP_Vivado"]" $obj

# Rebuild user ip_repo's index before adding any source files
update_ip_catalog -rebuild

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
# Import local files from the original project
set files [list \
 "[file normalize "$origin_dir/HW_repo/VHDL_codes/Modulator.vhd"]"\
 "[file normalize "$origin_dir/HW_repo/VHDL_codes/start_peripheral.vhd"]"\
 "[file normalize "$origin_dir/HW_repo/VHDL_codes/NOT.vhd"]"\
 "[file normalize "$origin_dir/HW_repo/VHDL_codes/DAC121s101_V2.vhd"]"\
 "[file normalize "$origin_dir/HW_repo/VHDL_codes/AD5293_v2.vhd"]"\
 "[file normalize "$origin_dir/HW_repo/VHDL_codes/AD_7476_input.vhd"]"\
 "[file normalize "$origin_dir/HW_repo/VHDL_codes/DeMultiplexer_8bits.vhd"]"\
 "[file normalize "$origin_dir/HW_repo/VHDL_codes/IGBT_input_selector.vhd"]"\
 "[file normalize "$origin_dir/HW_repo/VHDL_codes/bit_order_adjust_tca9538.vhd"]"\
 "[file normalize "$origin_dir/HW_repo/VHDL_codes/serial_interrupt.vhd"]"\
 "[file normalize "$origin_dir/HW_repo/VHDL_codes/truncate_bits.vhd"]"\
 "[file normalize "$origin_dir/HW_repo/VHDL_codes/start_200ns.vhd"]"\
 "[file normalize "$origin_dir/HW_repo/VHDL_codes/Start_PMSM.vhd"]"\
 "[file normalize "$origin_dir/HW_repo/VHDL_codes/Multiplier.vhd"]"\
 "[file normalize "$origin_dir/HW_repo/VHDL_codes/IP_test_mode.vhd"]"\
 "[file normalize "$origin_dir/HW_repo/VHDL_codes/3ph_modulator.vhd"]"\
 "[file normalize "$origin_dir/HW_repo/VHDL_codes/FSM.vhd"]"\
 "[file normalize "$origin_dir/HW_repo/wrapper/NV_project_wrapper.vhd"]"\
]
set imported_files [import_files -fileset sources_1 $files]

# Set 'sources_1' fileset file properties for remote files
# None

# Set 'sources_1' fileset file properties for local files
set file "Modulator.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "start_peripheral.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "NOT.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "DAC121s101_V2.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "AD5293_v2.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "AD_7476_input.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "DeMultiplexer_8bits.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "IGBT_input_selector.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "bit_order_adjust_tca9538.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "serial_interrupt.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "truncate_bits.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "start_200ns.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "Start_PMSM.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "Multiplier.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "NV_project_wrapper.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "IP_test_mode.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "3ph_modulator.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "FSM.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj


# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property -name "top" -value "NV_project_wrapper" -objects $obj

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
set file "[file normalize "$origin_dir/HW_repo/constraints/NV_constraints.xdc"]"
set file_imported [import_files -fileset constrs_1 $file]
set file "NV_constraints.xdc"
set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
set_property -name "file_type" -value "XDC" -objects $file_obj

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]
set_property -name "target_constrs_file" -value "[get_files *NV_constraints.xdc]" -objects $obj

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
# Empty (no sources present)

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property -name "top" -value "NV_project_wrapper" -objects $obj


# # Adding sources referenced in BDs, if not already added
# if { [get_files Modulator.vhd] == "" } {
  # import_files -quiet -fileset sources_1 C:/Users/Jorge/Documents/GitHub/nvHIL/Vivado/NV_project/NV_project/NV_project.srcs/sources_1/new/Modulator.vhd
# }
# if { [get_files start_peripheral.vhd] == "" } {
  # import_files -quiet -fileset sources_1 C:/Users/Jorge/Documents/GitHub/nvHIL/Vivado/NV_project/NV_project/NV_project.srcs/sources_1/new/start_peripheral.vhd
# }
# if { [get_files NOT.vhd] == "" } {
  # import_files -quiet -fileset sources_1 C:/Users/Jorge/Documents/GitHub/nvHIL/Vivado/NV_project/NV_project/NV_project.srcs/sources_1/new/NOT.vhd
# }
# if { [get_files DAC121s101_V2.vhd] == "" } {
  # import_files -quiet -fileset sources_1 C:/Users/Jorge/Documents/GitHub/nvHIL/Vivado/NV_project/NV_project/NV_project.srcs/sources_1/new/DAC121s101_V2.vhd
# }
# if { [get_files AD5293_v2.vhd] == "" } {
  # import_files -quiet -fileset sources_1 C:/Users/Jorge/Documents/GitHub/nvHIL/Vivado/NV_project/NV_project/NV_project.srcs/sources_1/new/AD5293_v2.vhd
# }
# if { [get_files AD_7476_input.vhd] == "" } {
  # import_files -quiet -fileset sources_1 C:/Users/Jorge/Documents/GitHub/nvHIL/Vivado/NV_project/NV_project/NV_project.srcs/sources_1/new/AD_7476_input.vhd
# }
# if { [get_files DeMultiplexer_8bits.vhd] == "" } {
  # import_files -quiet -fileset sources_1 C:/Users/Jorge/Documents/GitHub/nvHIL/Vivado/NV_project/NV_project/NV_project.srcs/sources_1/new/DeMultiplexer_8bits.vhd
# }
# if { [get_files IGBT_input_selector.vhd] == "" } {
  # import_files -quiet -fileset sources_1 C:/Users/Jorge/Documents/GitHub/nvHIL/Vivado/NV_project/NV_project/NV_project.srcs/sources_1/new/IGBT_input_selector.vhd
# }
# if { [get_files bit_order_adjust_tca9538.vhd] == "" } {
  # import_files -quiet -fileset sources_1 C:/Users/Jorge/Documents/GitHub/nvHIL/Vivado/NV_project/NV_project/NV_project.srcs/sources_1/new/bit_order_adjust_tca9538.vhd
# }
# if { [get_files serial_interrupt.vhd] == "" } {
  # import_files -quiet -fileset sources_1 C:/Users/Jorge/Documents/GitHub/nvHIL/Vivado/NV_project/NV_project/NV_project.srcs/sources_1/new/serial_interrupt.vhd
# }
# if { [get_files truncate_bits.vhd] == "" } {
  # import_files -quiet -fileset sources_1 C:/Users/Jorge/Documents/GitHub/nvHIL/Vivado/NV_project/NV_project/NV_project.srcs/sources_1/new/truncate_bits.vhd
# }
# if { [get_files start_200ns.vhd] == "" } {
  # import_files -quiet -fileset sources_1 C:/Users/Jorge/Documents/GitHub/nvHIL/Vivado/NV_project/NV_project/NV_project.srcs/sources_1/new/start_200ns.vhd
# }
# if { [get_files Start_PMSM.vhd] == "" } {
  # import_files -quiet -fileset sources_1 C:/Users/Jorge/Documents/GitHub/nvHIL/Vivado/NV_project/NV_project/NV_project.srcs/sources_1/new/Start_PMSM.vhd
# }
# if { [get_files IGBT_input_selector.vhd] == "" } {
  # import_files -quiet -fileset sources_1 C:/Users/Jorge/Documents/GitHub/nvHIL/Vivado/NV_project/NV_project/NV_project.srcs/sources_1/new/IGBT_input_selector.vhd
# }
# if { [get_files Multiplier.vhd] == "" } {
  # import_files -quiet -fileset sources_1 C:/Users/Jorge/Documents/GitHub/nvHIL/Vivado/NV_project/NV_project/NV_project.srcs/sources_1/new/Multiplier.vhd
# }
# if { [get_files Modulator.vhd] == "" } {
  # import_files -quiet -fileset sources_1 C:/Users/Jorge/Documents/GitHub/nvHIL/Vivado/NV_project/NV_project/NV_project.srcs/sources_1/new/Modulator.vhd
# }
# Adding sources referenced in BDs, if not already added

if { [get_files Modulator.vhd] == "" } { 
  import_files -quiet -fileset sources_1 "[file normalize "$origin_dir/HW_repo/VHDL_codes/Modulator.vhd"]"
}
if { [get_files start_peripheral.vhd] == "" } {
  import_files -quiet -fileset sources_1 "[file normalize "$origin_dir/HW_repo/VHDL_codes/start_peripheral.vhd"]"
}
if { [get_files NOT.vhd] == "" } {
  import_files -quiet -fileset sources_1 "[file normalize "$origin_dir/HW_repo/VHDL_codes/NOT.vhd"]"
}
if { [get_files DAC121s101_V2.vhd] == "" } {
  import_files -quiet -fileset sources_1 "[file normalize "$origin_dir/HW_repo/VHDL_codes/DAC121s101_V2.vhd"]"
}
if { [get_files AD5293_v2.vhd] == "" } {
  import_files -quiet -fileset sources_1 "[file normalize "$origin_dir/HW_repo/VHDL_codes/AD5293_v2.vhd"]"
}
if { [get_files AD_7476_input.vhd] == "" } {
  import_files -quiet -fileset sources_1 "[file normalize "$origin_dir/HW_repo/VHDL_codes/AD_7476_input.vhd"]"
}
if { [get_files DeMultiplexer_8bits.vhd] == "" } {
  import_files -quiet -fileset sources_1 "[file normalize "$origin_dir/HW_repo/VHDL_codes/DeMultiplexer_8bits.vhd"]"
}
if { [get_files IGBT_input_selector.vhd] == "" } {
  import_files -quiet -fileset sources_1 "[file normalize "$origin_dir/HW_repo/VHDL_codes/IGBT_input_selector.vhd"]"
}
if { [get_files bit_order_adjust_tca9538.vhd] == "" } {
  import_files -quiet -fileset sources_1 "[file normalize "$origin_dir/HW_repo/VHDL_codes/bit_order_adjust_tca9538.vhd"]"
}
if { [get_files serial_interrupt.vhd] == "" } {
  import_files -quiet -fileset sources_1 "[file normalize "$origin_dir/HW_repo/VHDL_codes/serial_interrupt.vhd"]"
}
if { [get_files truncate_bits.vhd] == "" } {
  import_files -quiet -fileset sources_1 "[file normalize "$origin_dir/HW_repo/VHDL_codes/truncate_bits.vhd"]"
}
if { [get_files start_200ns.vhd] == "" } {
  import_files -quiet -fileset sources_1 "[file normalize "$origin_dir/HW_repo/VHDL_codes/start_200ns.vhd"]"
}
if { [get_files Start_PMSM.vhd] == "" } {
  import_files -quiet -fileset sources_1 "[file normalize "$origin_dir/HW_repo/VHDL_codes/Start_PMSM.vhd"]"
}
if { [get_files Multiplier.vhd] == "" } {
  import_files -quiet -fileset sources_1 "[file normalize "$origin_dir/HW_repo/VHDL_codes/Multiplier.vhd"]"
}


# Proc to create BD NV_project
proc cr_bd_NV_project { parentCell } {
# The design that will be created by this Tcl proc contains the following 
# module references:
# AD1RefComp, AD_5293_v2, DAC_121s101, De_Multiplexer_8b, IGBT_input_selector, IGBT_input_selector, NOT_8, NV_multiplier, bit_order_adjust_tca9538, gen_referencias, gen_referencias, serial_interrupt, start_GRID, start_PMSM, start_peripheral, truncate_bits



  # CHANGE DESIGN NAME HERE
  set design_name NV_project

  common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

  create_bd_design $design_name

  # Add USER_COMMENTS on $design_name
  set_property USER_COMMENTS.comment_0 " " [get_bd_designs $design_name]
  set_property USER_COMMENTS.comment_1 " " [get_bd_designs $design_name]

  set bCheckIPsPassed 1
  ##################################################################
  # CHECK IPs
  ##################################################################
  set bCheckIPs 1
  if { $bCheckIPs == 1 } {
     set list_check_ips "\ 
  xilinx.com:hls:DCbus_dynamic:1.0\
  xilinx.com:user:Digital_Outputs:1.0\
  xilinx.com:user:NV_io_controller:1.0\
  xilinx.com:user:NV_parameter_load:1.0\
  xilinx.com:user:TCA9538_driver:1.0\
  xilinx.com:user:TCA9538_driver_input:1.0\
  xilinx.com:ip:axi_gpio:2.0\
  xilinx.com:hls:bridge3ph:1.0\
  xilinx.com:hls:float_conversor:1.0\
  xilinx.com:hls:gain_offset_truncation:1.0\
  xilinx.com:hls:grid:1.0\
  xilinx.com:hls:grid_bridge3ph:1.0\
  xilinx.com:hls:lcl_filter:1.0\
  xilinx.com:user:parameter_load_2:1.0\
  xilinx.com:hls:pmsm:1.0\
  xilinx.com:ip:processing_system7:5.5\
  xilinx.com:ip:proc_sys_reset:5.0\
  xilinx.com:ip:system_ila:1.1\
  xilinx.com:ip:xlconcat:2.1\
  xilinx.com:ip:xlconstant:1.1\
  "

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

  }

  ##################################################################
  # CHECK Modules
  ##################################################################
  set bCheckModules 1
  if { $bCheckModules == 1 } {
     set list_check_mods "\ 
  AD1RefComp\
  AD_5293_v2\
  DAC_121s101\
  De_Multiplexer_8b\
  IGBT_input_selector\
  IGBT_input_selector\
  NOT_8\
  NV_multiplier\
  bit_order_adjust_tca9538\
  gen_referencias\
  gen_referencias\
  serial_interrupt\
  start_GRID\
  start_PMSM\
  start_peripheral\
  truncate_bits\
  "

   set list_mods_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_msg_id "BD_TCL-008" "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

  if { $bCheckIPsPassed != 1 } {
    common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
    return 3
  }

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR_0 ]
  set FIXED_IO_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO_0 ]

  # Create ports
  set DRIVER_DOWN_00 [ create_bd_port -dir I DRIVER_DOWN_00 ]
  set DRIVER_DOWN_01 [ create_bd_port -dir I DRIVER_DOWN_01 ]
  set DRIVER_DOWN_02 [ create_bd_port -dir I DRIVER_DOWN_02 ]
  set DRIVER_DOWN_03 [ create_bd_port -dir I DRIVER_DOWN_03 ]
  set DRIVER_DOWN_04 [ create_bd_port -dir I DRIVER_DOWN_04 ]
  set DRIVER_DOWN_05 [ create_bd_port -dir I DRIVER_DOWN_05 ]
  set DRIVER_DOWN_06 [ create_bd_port -dir I DRIVER_DOWN_06 ]
  set DRIVER_UP_00 [ create_bd_port -dir I DRIVER_UP_00 ]
  set DRIVER_UP_01 [ create_bd_port -dir I DRIVER_UP_01 ]
  set DRIVER_UP_02 [ create_bd_port -dir I DRIVER_UP_02 ]
  set DRIVER_UP_03 [ create_bd_port -dir I DRIVER_UP_03 ]
  set DRIVER_UP_04 [ create_bd_port -dir I DRIVER_UP_04 ]
  set DRIVER_UP_05 [ create_bd_port -dir I DRIVER_UP_05 ]
  set DRIVER_UP_06 [ create_bd_port -dir I DRIVER_UP_06 ]
  set Din_out_0 [ create_bd_port -dir O Din_out_0 ]
  set Din_out_1 [ create_bd_port -dir O Din_out_1 ]
  set Din_out_2 [ create_bd_port -dir O Din_out_2 ]
  set Din_out_3 [ create_bd_port -dir O Din_out_3 ]
  set Din_out_4 [ create_bd_port -dir O Din_out_4 ]
  set Din_out_5 [ create_bd_port -dir O Din_out_5 ]
  set Din_out_6 [ create_bd_port -dir O Din_out_6 ]
  set Din_out_7 [ create_bd_port -dir O Din_out_7 ]
  set Din_out_8 [ create_bd_port -dir O Din_out_8 ]
  set Din_out_9 [ create_bd_port -dir O Din_out_9 ]
  set Din_out_10 [ create_bd_port -dir O Din_out_10 ]
  set Din_out_11 [ create_bd_port -dir O Din_out_11 ]
  set Din_out_12 [ create_bd_port -dir O Din_out_12 ]
  set Din_out_13 [ create_bd_port -dir O Din_out_13 ]
  set Din_out_14 [ create_bd_port -dir O Din_out_14 ]
  set Din_out_15 [ create_bd_port -dir O Din_out_15 ]
  set Din_out_16 [ create_bd_port -dir O Din_out_16 ]
  set Din_out_17 [ create_bd_port -dir O -from 0 -to 0 Din_out_17 ]
  set Din_out_18 [ create_bd_port -dir O Din_out_18 ]
  set Din_out_19 [ create_bd_port -dir O Din_out_19 ]
  set Din_out_20 [ create_bd_port -dir O Din_out_20 ]
  set SCLK_0 [ create_bd_port -dir O SCLK_0 ]
  set SCLK_out_0 [ create_bd_port -dir O SCLK_out_0 ]
  set SCLK_out_1 [ create_bd_port -dir O SCLK_out_1 ]
  set SCLK_out_2 [ create_bd_port -dir O SCLK_out_2 ]
  set SCLK_out_3 [ create_bd_port -dir O SCLK_out_3 ]
  set SCLK_out_4 [ create_bd_port -dir O SCLK_out_4 ]
  set SCLK_out_6 [ create_bd_port -dir O SCLK_out_6 ]
  set SCLK_out_7 [ create_bd_port -dir O SCLK_out_7 ]
  set SDATA1_0 [ create_bd_port -dir I SDATA1_0 ]
  set nCS_0 [ create_bd_port -dir O nCS_0 ]
  set nRST_out_0 [ create_bd_port -dir O nRST_out_0 ]
  set nRST_out_1 [ create_bd_port -dir O nRST_out_1 ]
  set nSync_out_0 [ create_bd_port -dir O nSync_out_0 ]
  set nSync_out_6 [ create_bd_port -dir O nSync_out_6 ]
  set scl_0 [ create_bd_port -dir IO scl_0 ]
  set scl_1 [ create_bd_port -dir IO scl_1 ]
  set sda_0 [ create_bd_port -dir IO sda_0 ]
  set sda_1 [ create_bd_port -dir IO sda_1 ]

  # Create instance: AD1RefComp_0, and set properties
  set block_name AD1RefComp
  set block_cell_name AD1RefComp_0
  if { [catch {set AD1RefComp_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AD1RefComp_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AD_5293_v2_0, and set properties
  set block_name AD_5293_v2
  set block_cell_name AD_5293_v2_0
  if { [catch {set AD_5293_v2_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AD_5293_v2_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: DAC_121s101_0, and set properties
  set block_name DAC_121s101
  set block_cell_name DAC_121s101_0
  if { [catch {set DAC_121s101_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $DAC_121s101_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: DCbus_dynamic_0, and set properties
  set DCbus_dynamic_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:DCbus_dynamic:1.0 DCbus_dynamic_0 ]

  # Create instance: De_Multiplexer_8b_0, and set properties
  set block_name De_Multiplexer_8b
  set block_cell_name De_Multiplexer_8b_0
  if { [catch {set De_Multiplexer_8b_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $De_Multiplexer_8b_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Digital_Outputs_0, and set properties
  set Digital_Outputs_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:Digital_Outputs:1.0 Digital_Outputs_0 ]

  # Create instance: IGBT_input_selector_0, and set properties
  set block_name IGBT_input_selector
  set block_cell_name IGBT_input_selector_0
  if { [catch {set IGBT_input_selector_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $IGBT_input_selector_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: IGBT_input_selector_1, and set properties
  set block_name IGBT_input_selector
  set block_cell_name IGBT_input_selector_1
  if { [catch {set IGBT_input_selector_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $IGBT_input_selector_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: NOT_8_0, and set properties
  set block_name NOT_8
  set block_cell_name NOT_8_0
  if { [catch {set NOT_8_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $NOT_8_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: NV_io_controller_0, and set properties
  set NV_io_controller_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:NV_io_controller:1.0 NV_io_controller_0 ]

  # Create instance: NV_multiplier_0, and set properties
  set block_name NV_multiplier
  set block_cell_name NV_multiplier_0
  if { [catch {set NV_multiplier_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $NV_multiplier_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: NV_parameter_load_0, and set properties
  set NV_parameter_load_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:NV_parameter_load:1.0 NV_parameter_load_0 ]

  # Create instance: TCA9538_driver_0, and set properties
  set TCA9538_driver_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:TCA9538_driver:1.0 TCA9538_driver_0 ]

  # Create instance: TCA9538_driver_input_0, and set properties
  set TCA9538_driver_input_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:TCA9538_driver_input:1.0 TCA9538_driver_input_0 ]

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {1} \
   CONFIG.C_ALL_OUTPUTS {0} \
   CONFIG.C_GPIO_WIDTH {1} \
   CONFIG.C_INTERRUPT_PRESENT {1} \
 ] $axi_gpio_0

  # Create instance: bit_order_adjust_tca9538_1, and set properties
  set block_name bit_order_adjust_tca9538
  set block_cell_name bit_order_adjust_tca9538_1
  if { [catch {set bit_order_adjust_tca9538_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $bit_order_adjust_tca9538_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: bridge3ph_0, and set properties
  set bridge3ph_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:bridge3ph:1.0 bridge3ph_0 ]

  # Create instance: float_conversor_0, and set properties
  set float_conversor_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:float_conversor:1.0 float_conversor_0 ]

  # Create instance: gain_offset_truncation_1, and set properties
  set gain_offset_truncation_1 [ create_bd_cell -type ip -vlnv xilinx.com:hls:gain_offset_truncation:1.0 gain_offset_truncation_1 ]

  # Create instance: gen_referencias_0, and set properties
  set block_name gen_referencias
  set block_cell_name gen_referencias_0
  if { [catch {set gen_referencias_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $gen_referencias_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: gen_referencias_1, and set properties
  set block_name gen_referencias
  set block_cell_name gen_referencias_1
  if { [catch {set gen_referencias_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $gen_referencias_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: grid_0, and set properties
  set grid_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:grid:1.0 grid_0 ]

  # Create instance: grid_bridge3ph_0, and set properties
  set grid_bridge3ph_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:grid_bridge3ph:1.0 grid_bridge3ph_0 ]

  # Create instance: lcl_filter_0, and set properties
  set lcl_filter_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:lcl_filter:1.0 lcl_filter_0 ]

  # Create instance: parameter_load_2_0, and set properties
  set parameter_load_2_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:parameter_load_2:1.0 parameter_load_2_0 ]

  # Create instance: pmsm_0, and set properties
  set pmsm_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:pmsm:1.0 pmsm_0 ]

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
   CONFIG.PCW_ACT_APU_PERIPHERAL_FREQMHZ {666.666687} \
   CONFIG.PCW_ACT_CAN_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_DCI_PERIPHERAL_FREQMHZ {10.158730} \
   CONFIG.PCW_ACT_ENET0_PERIPHERAL_FREQMHZ {125.000000} \
   CONFIG.PCW_ACT_ENET1_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_FPGA0_PERIPHERAL_FREQMHZ {100.000000} \
   CONFIG.PCW_ACT_FPGA1_PERIPHERAL_FREQMHZ {50.000000} \
   CONFIG.PCW_ACT_FPGA2_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_FPGA3_PERIPHERAL_FREQMHZ {2.500000} \
   CONFIG.PCW_ACT_PCAP_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_QSPI_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_SDIO_PERIPHERAL_FREQMHZ {25.000000} \
   CONFIG.PCW_ACT_SMC_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_SPI_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_TPIU_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_TTC0_CLK0_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC0_CLK1_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC0_CLK2_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC1_CLK0_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC1_CLK1_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC1_CLK2_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_UART_PERIPHERAL_FREQMHZ {50.000000} \
   CONFIG.PCW_ACT_WDT_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_APU_CLK_RATIO_ENABLE {6:2:1} \
   CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {667} \
   CONFIG.PCW_ARMPLL_CTRL_FBDIV {40} \
   CONFIG.PCW_CAN_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_CAN_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_CLK0_FREQ {100000000} \
   CONFIG.PCW_CLK1_FREQ {50000000} \
   CONFIG.PCW_CLK2_FREQ {10000000} \
   CONFIG.PCW_CLK3_FREQ {2500000} \
   CONFIG.PCW_CPU_CPU_6X4X_MAX_RANGE {667} \
   CONFIG.PCW_CPU_CPU_PLL_FREQMHZ {1333.333} \
   CONFIG.PCW_CPU_PERIPHERAL_CLKSRC {ARM PLL} \
   CONFIG.PCW_CPU_PERIPHERAL_DIVISOR0 {2} \
   CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {33.333333} \
   CONFIG.PCW_DCI_PERIPHERAL_DIVISOR0 {15} \
   CONFIG.PCW_DCI_PERIPHERAL_DIVISOR1 {7} \
   CONFIG.PCW_DDRPLL_CTRL_FBDIV {32} \
   CONFIG.PCW_DDR_DDR_PLL_FREQMHZ {1066.667} \
   CONFIG.PCW_DDR_PERIPHERAL_CLKSRC {DDR PLL} \
   CONFIG.PCW_DDR_PERIPHERAL_DIVISOR0 {2} \
   CONFIG.PCW_DDR_RAM_HIGHADDR {0x3FFFFFFF} \
   CONFIG.PCW_DM_WIDTH {4} \
   CONFIG.PCW_DQS_WIDTH {4} \
   CONFIG.PCW_DQ_WIDTH {32} \
   CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
   CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
   CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} \
   CONFIG.PCW_ENET0_PERIPHERAL_CLKSRC {IO PLL} \
   CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR0 {8} \
   CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {1000 Mbps} \
   CONFIG.PCW_ENET0_RESET_ENABLE {0} \
   CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_ENET1_RESET_ENABLE {0} \
   CONFIG.PCW_ENET_RESET_ENABLE {1} \
   CONFIG.PCW_ENET_RESET_SELECT {Share reset pin} \
   CONFIG.PCW_EN_CLK0_PORT {1} \
   CONFIG.PCW_EN_CLK1_PORT {1} \
   CONFIG.PCW_EN_CLK2_PORT {1} \
   CONFIG.PCW_EN_CLK3_PORT {1} \
   CONFIG.PCW_EN_DDR {1} \
   CONFIG.PCW_EN_EMIO_TTC0 {1} \
   CONFIG.PCW_EN_ENET0 {1} \
   CONFIG.PCW_EN_GPIO {1} \
   CONFIG.PCW_EN_QSPI {1} \
   CONFIG.PCW_EN_RST0_PORT {1} \
   CONFIG.PCW_EN_RST1_PORT {0} \
   CONFIG.PCW_EN_RST2_PORT {0} \
   CONFIG.PCW_EN_RST3_PORT {0} \
   CONFIG.PCW_EN_SDIO0 {1} \
   CONFIG.PCW_EN_TTC0 {1} \
   CONFIG.PCW_EN_UART1 {1} \
   CONFIG.PCW_EN_USB0 {1} \
   CONFIG.PCW_FCLK0_PERIPHERAL_CLKSRC {IO PLL} \
   CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR1 {2} \
   CONFIG.PCW_FCLK1_PERIPHERAL_CLKSRC {IO PLL} \
   CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR1 {4} \
   CONFIG.PCW_FCLK2_PERIPHERAL_CLKSRC {IO PLL} \
   CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR0 {10} \
   CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR1 {10} \
   CONFIG.PCW_FCLK3_PERIPHERAL_CLKSRC {IO PLL} \
   CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR0 {20} \
   CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR1 {20} \
   CONFIG.PCW_FCLK_CLK0_BUF {TRUE} \
   CONFIG.PCW_FCLK_CLK1_BUF {TRUE} \
   CONFIG.PCW_FCLK_CLK2_BUF {FALSE} \
   CONFIG.PCW_FCLK_CLK3_BUF {TRUE} \
   CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
   CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {50} \
   CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {10} \
   CONFIG.PCW_FPGA3_PERIPHERAL_FREQMHZ {2.5} \
   CONFIG.PCW_FPGA_FCLK0_ENABLE {1} \
   CONFIG.PCW_FPGA_FCLK1_ENABLE {1} \
   CONFIG.PCW_FPGA_FCLK2_ENABLE {1} \
   CONFIG.PCW_FPGA_FCLK3_ENABLE {1} \
   CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {0} \
   CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
   CONFIG.PCW_GPIO_MIO_GPIO_IO {MIO} \
   CONFIG.PCW_GPIO_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_I2C0_RESET_ENABLE {0} \
   CONFIG.PCW_I2C1_RESET_ENABLE {0} \
   CONFIG.PCW_I2C_PERIPHERAL_FREQMHZ {25} \
   CONFIG.PCW_I2C_RESET_ENABLE {0} \
   CONFIG.PCW_IOPLL_CTRL_FBDIV {30} \
   CONFIG.PCW_IO_IO_PLL_FREQMHZ {1000.000} \
   CONFIG.PCW_IRQ_F2P_INTR {1} \
   CONFIG.PCW_MIO_0_DIRECTION {inout} \
   CONFIG.PCW_MIO_0_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_0_PULLUP {disabled} \
   CONFIG.PCW_MIO_0_SLEW {slow} \
   CONFIG.PCW_MIO_10_DIRECTION {inout} \
   CONFIG.PCW_MIO_10_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_10_PULLUP {disabled} \
   CONFIG.PCW_MIO_10_SLEW {slow} \
   CONFIG.PCW_MIO_11_DIRECTION {inout} \
   CONFIG.PCW_MIO_11_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_11_PULLUP {disabled} \
   CONFIG.PCW_MIO_11_SLEW {slow} \
   CONFIG.PCW_MIO_12_DIRECTION {inout} \
   CONFIG.PCW_MIO_12_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_12_PULLUP {disabled} \
   CONFIG.PCW_MIO_12_SLEW {slow} \
   CONFIG.PCW_MIO_13_DIRECTION {inout} \
   CONFIG.PCW_MIO_13_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_13_PULLUP {disabled} \
   CONFIG.PCW_MIO_13_SLEW {slow} \
   CONFIG.PCW_MIO_14_DIRECTION {inout} \
   CONFIG.PCW_MIO_14_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_14_PULLUP {disabled} \
   CONFIG.PCW_MIO_14_SLEW {slow} \
   CONFIG.PCW_MIO_15_DIRECTION {inout} \
   CONFIG.PCW_MIO_15_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_15_PULLUP {disabled} \
   CONFIG.PCW_MIO_15_SLEW {slow} \
   CONFIG.PCW_MIO_16_DIRECTION {out} \
   CONFIG.PCW_MIO_16_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_16_PULLUP {disabled} \
   CONFIG.PCW_MIO_16_SLEW {slow} \
   CONFIG.PCW_MIO_17_DIRECTION {out} \
   CONFIG.PCW_MIO_17_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_17_PULLUP {disabled} \
   CONFIG.PCW_MIO_17_SLEW {slow} \
   CONFIG.PCW_MIO_18_DIRECTION {out} \
   CONFIG.PCW_MIO_18_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_18_PULLUP {disabled} \
   CONFIG.PCW_MIO_18_SLEW {slow} \
   CONFIG.PCW_MIO_19_DIRECTION {out} \
   CONFIG.PCW_MIO_19_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_19_PULLUP {disabled} \
   CONFIG.PCW_MIO_19_SLEW {slow} \
   CONFIG.PCW_MIO_1_DIRECTION {out} \
   CONFIG.PCW_MIO_1_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_1_PULLUP {disabled} \
   CONFIG.PCW_MIO_1_SLEW {slow} \
   CONFIG.PCW_MIO_20_DIRECTION {out} \
   CONFIG.PCW_MIO_20_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_20_PULLUP {disabled} \
   CONFIG.PCW_MIO_20_SLEW {slow} \
   CONFIG.PCW_MIO_21_DIRECTION {out} \
   CONFIG.PCW_MIO_21_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_21_PULLUP {disabled} \
   CONFIG.PCW_MIO_21_SLEW {slow} \
   CONFIG.PCW_MIO_22_DIRECTION {in} \
   CONFIG.PCW_MIO_22_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_22_PULLUP {disabled} \
   CONFIG.PCW_MIO_22_SLEW {slow} \
   CONFIG.PCW_MIO_23_DIRECTION {in} \
   CONFIG.PCW_MIO_23_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_23_PULLUP {disabled} \
   CONFIG.PCW_MIO_23_SLEW {slow} \
   CONFIG.PCW_MIO_24_DIRECTION {in} \
   CONFIG.PCW_MIO_24_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_24_PULLUP {disabled} \
   CONFIG.PCW_MIO_24_SLEW {slow} \
   CONFIG.PCW_MIO_25_DIRECTION {in} \
   CONFIG.PCW_MIO_25_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_25_PULLUP {disabled} \
   CONFIG.PCW_MIO_25_SLEW {slow} \
   CONFIG.PCW_MIO_26_DIRECTION {in} \
   CONFIG.PCW_MIO_26_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_26_PULLUP {disabled} \
   CONFIG.PCW_MIO_26_SLEW {slow} \
   CONFIG.PCW_MIO_27_DIRECTION {in} \
   CONFIG.PCW_MIO_27_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_27_PULLUP {disabled} \
   CONFIG.PCW_MIO_27_SLEW {slow} \
   CONFIG.PCW_MIO_28_DIRECTION {inout} \
   CONFIG.PCW_MIO_28_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_28_PULLUP {disabled} \
   CONFIG.PCW_MIO_28_SLEW {slow} \
   CONFIG.PCW_MIO_29_DIRECTION {in} \
   CONFIG.PCW_MIO_29_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_29_PULLUP {disabled} \
   CONFIG.PCW_MIO_29_SLEW {slow} \
   CONFIG.PCW_MIO_2_DIRECTION {inout} \
   CONFIG.PCW_MIO_2_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_2_PULLUP {disabled} \
   CONFIG.PCW_MIO_2_SLEW {slow} \
   CONFIG.PCW_MIO_30_DIRECTION {out} \
   CONFIG.PCW_MIO_30_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_30_PULLUP {disabled} \
   CONFIG.PCW_MIO_30_SLEW {slow} \
   CONFIG.PCW_MIO_31_DIRECTION {in} \
   CONFIG.PCW_MIO_31_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_31_PULLUP {disabled} \
   CONFIG.PCW_MIO_31_SLEW {slow} \
   CONFIG.PCW_MIO_32_DIRECTION {inout} \
   CONFIG.PCW_MIO_32_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_32_PULLUP {disabled} \
   CONFIG.PCW_MIO_32_SLEW {slow} \
   CONFIG.PCW_MIO_33_DIRECTION {inout} \
   CONFIG.PCW_MIO_33_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_33_PULLUP {disabled} \
   CONFIG.PCW_MIO_33_SLEW {slow} \
   CONFIG.PCW_MIO_34_DIRECTION {inout} \
   CONFIG.PCW_MIO_34_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_34_PULLUP {disabled} \
   CONFIG.PCW_MIO_34_SLEW {slow} \
   CONFIG.PCW_MIO_35_DIRECTION {inout} \
   CONFIG.PCW_MIO_35_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_35_PULLUP {disabled} \
   CONFIG.PCW_MIO_35_SLEW {slow} \
   CONFIG.PCW_MIO_36_DIRECTION {in} \
   CONFIG.PCW_MIO_36_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_36_PULLUP {disabled} \
   CONFIG.PCW_MIO_36_SLEW {slow} \
   CONFIG.PCW_MIO_37_DIRECTION {inout} \
   CONFIG.PCW_MIO_37_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_37_PULLUP {disabled} \
   CONFIG.PCW_MIO_37_SLEW {slow} \
   CONFIG.PCW_MIO_38_DIRECTION {inout} \
   CONFIG.PCW_MIO_38_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_38_PULLUP {disabled} \
   CONFIG.PCW_MIO_38_SLEW {slow} \
   CONFIG.PCW_MIO_39_DIRECTION {inout} \
   CONFIG.PCW_MIO_39_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_39_PULLUP {disabled} \
   CONFIG.PCW_MIO_39_SLEW {slow} \
   CONFIG.PCW_MIO_3_DIRECTION {inout} \
   CONFIG.PCW_MIO_3_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_3_PULLUP {disabled} \
   CONFIG.PCW_MIO_3_SLEW {slow} \
   CONFIG.PCW_MIO_40_DIRECTION {inout} \
   CONFIG.PCW_MIO_40_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_40_PULLUP {disabled} \
   CONFIG.PCW_MIO_40_SLEW {slow} \
   CONFIG.PCW_MIO_41_DIRECTION {inout} \
   CONFIG.PCW_MIO_41_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_41_PULLUP {disabled} \
   CONFIG.PCW_MIO_41_SLEW {slow} \
   CONFIG.PCW_MIO_42_DIRECTION {inout} \
   CONFIG.PCW_MIO_42_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_42_PULLUP {disabled} \
   CONFIG.PCW_MIO_42_SLEW {slow} \
   CONFIG.PCW_MIO_43_DIRECTION {inout} \
   CONFIG.PCW_MIO_43_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_43_PULLUP {disabled} \
   CONFIG.PCW_MIO_43_SLEW {slow} \
   CONFIG.PCW_MIO_44_DIRECTION {inout} \
   CONFIG.PCW_MIO_44_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_44_PULLUP {disabled} \
   CONFIG.PCW_MIO_44_SLEW {slow} \
   CONFIG.PCW_MIO_45_DIRECTION {inout} \
   CONFIG.PCW_MIO_45_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_45_PULLUP {disabled} \
   CONFIG.PCW_MIO_45_SLEW {slow} \
   CONFIG.PCW_MIO_46_DIRECTION {in} \
   CONFIG.PCW_MIO_46_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_46_PULLUP {disabled} \
   CONFIG.PCW_MIO_46_SLEW {slow} \
   CONFIG.PCW_MIO_47_DIRECTION {inout} \
   CONFIG.PCW_MIO_47_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_47_PULLUP {disabled} \
   CONFIG.PCW_MIO_47_SLEW {slow} \
   CONFIG.PCW_MIO_48_DIRECTION {out} \
   CONFIG.PCW_MIO_48_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_48_PULLUP {disabled} \
   CONFIG.PCW_MIO_48_SLEW {slow} \
   CONFIG.PCW_MIO_49_DIRECTION {in} \
   CONFIG.PCW_MIO_49_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_49_PULLUP {disabled} \
   CONFIG.PCW_MIO_49_SLEW {slow} \
   CONFIG.PCW_MIO_4_DIRECTION {inout} \
   CONFIG.PCW_MIO_4_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_4_PULLUP {disabled} \
   CONFIG.PCW_MIO_4_SLEW {slow} \
   CONFIG.PCW_MIO_50_DIRECTION {in} \
   CONFIG.PCW_MIO_50_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_50_PULLUP {disabled} \
   CONFIG.PCW_MIO_50_SLEW {slow} \
   CONFIG.PCW_MIO_51_DIRECTION {inout} \
   CONFIG.PCW_MIO_51_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_51_PULLUP {disabled} \
   CONFIG.PCW_MIO_51_SLEW {slow} \
   CONFIG.PCW_MIO_52_DIRECTION {out} \
   CONFIG.PCW_MIO_52_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_52_PULLUP {disabled} \
   CONFIG.PCW_MIO_52_SLEW {slow} \
   CONFIG.PCW_MIO_53_DIRECTION {inout} \
   CONFIG.PCW_MIO_53_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_53_PULLUP {disabled} \
   CONFIG.PCW_MIO_53_SLEW {slow} \
   CONFIG.PCW_MIO_5_DIRECTION {inout} \
   CONFIG.PCW_MIO_5_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_5_PULLUP {disabled} \
   CONFIG.PCW_MIO_5_SLEW {slow} \
   CONFIG.PCW_MIO_6_DIRECTION {out} \
   CONFIG.PCW_MIO_6_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_6_PULLUP {disabled} \
   CONFIG.PCW_MIO_6_SLEW {slow} \
   CONFIG.PCW_MIO_7_DIRECTION {out} \
   CONFIG.PCW_MIO_7_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_7_PULLUP {disabled} \
   CONFIG.PCW_MIO_7_SLEW {slow} \
   CONFIG.PCW_MIO_8_DIRECTION {out} \
   CONFIG.PCW_MIO_8_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_8_PULLUP {disabled} \
   CONFIG.PCW_MIO_8_SLEW {slow} \
   CONFIG.PCW_MIO_9_DIRECTION {inout} \
   CONFIG.PCW_MIO_9_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_9_PULLUP {disabled} \
   CONFIG.PCW_MIO_9_SLEW {slow} \
   CONFIG.PCW_MIO_PRIMITIVE {54} \
   CONFIG.PCW_MIO_TREE_PERIPHERALS {GPIO#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#USB Reset#Quad SPI Flash#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#GPIO#UART 1#UART 1#SD 0#GPIO#Enet 0#Enet 0} \
   CONFIG.PCW_MIO_TREE_SIGNALS {gpio[0]#qspi0_ss_b#qspi0_io[0]#qspi0_io[1]#qspi0_io[2]#qspi0_io[3]/HOLD_B#qspi0_sclk#reset#qspi_fbclk#gpio[9]#gpio[10]#gpio[11]#gpio[12]#gpio[13]#gpio[14]#gpio[15]#tx_clk#txd[0]#txd[1]#txd[2]#txd[3]#tx_ctl#rx_clk#rxd[0]#rxd[1]#rxd[2]#rxd[3]#rx_ctl#data[4]#dir#stp#nxt#data[0]#data[1]#data[2]#data[3]#clk#data[5]#data[6]#data[7]#clk#cmd#data[0]#data[1]#data[2]#data[3]#cd#gpio[47]#tx#rx#wp#gpio[51]#mdc#mdio} \
   CONFIG.PCW_NAND_GRP_D8_ENABLE {0} \
   CONFIG.PCW_NAND_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_A25_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_CS0_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_CS1_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_SRAM_CS0_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_SRAM_CS1_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_SRAM_INT_ENABLE {0} \
   CONFIG.PCW_NOR_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY0 {0.416} \
   CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY1 {0.408} \
   CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY2 {0.369} \
   CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY3 {0.370} \
   CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_0 {0.001} \
   CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_1 {0.037} \
   CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_2 {-0.074} \
   CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_3 {-0.098} \
   CONFIG.PCW_PACKAGE_NAME {clg400} \
   CONFIG.PCW_PCAP_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 3.3V} \
   CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
   CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1} \
   CONFIG.PCW_QSPI_GRP_FBCLK_IO {MIO 8} \
   CONFIG.PCW_QSPI_GRP_IO1_ENABLE {0} \
   CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
   CONFIG.PCW_QSPI_GRP_SINGLE_SS_IO {MIO 1 .. 6} \
   CONFIG.PCW_QSPI_GRP_SS1_ENABLE {0} \
   CONFIG.PCW_QSPI_PERIPHERAL_CLKSRC {IO PLL} \
   CONFIG.PCW_QSPI_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ {200} \
   CONFIG.PCW_QSPI_QSPI_IO {MIO 1 .. 6} \
   CONFIG.PCW_SD0_GRP_CD_ENABLE {1} \
   CONFIG.PCW_SD0_GRP_CD_IO {MIO 46} \
   CONFIG.PCW_SD0_GRP_POW_ENABLE {0} \
   CONFIG.PCW_SD0_GRP_WP_ENABLE {1} \
   CONFIG.PCW_SD0_GRP_WP_IO {MIO 50} \
   CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} \
   CONFIG.PCW_SDIO_PERIPHERAL_CLKSRC {IO PLL} \
   CONFIG.PCW_SDIO_PERIPHERAL_DIVISOR0 {40} \
   CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {25} \
   CONFIG.PCW_SDIO_PERIPHERAL_VALID {1} \
   CONFIG.PCW_SINGLE_QSPI_DATA_MODE {x4} \
   CONFIG.PCW_SMC_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_SPI_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_TPIU_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_TTC0_CLK0_PERIPHERAL_CLKSRC {CPU_1X} \
   CONFIG.PCW_TTC0_CLK0_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_TTC0_CLK1_PERIPHERAL_CLKSRC {CPU_1X} \
   CONFIG.PCW_TTC0_CLK1_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_TTC0_CLK2_PERIPHERAL_CLKSRC {CPU_1X} \
   CONFIG.PCW_TTC0_CLK2_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_TTC0_TTC0_IO {EMIO} \
   CONFIG.PCW_TTC_PERIPHERAL_FREQMHZ {50} \
   CONFIG.PCW_UART1_GRP_FULL_ENABLE {0} \
   CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_UART1_UART1_IO {MIO 48 .. 49} \
   CONFIG.PCW_UART_PERIPHERAL_CLKSRC {IO PLL} \
   CONFIG.PCW_UART_PERIPHERAL_DIVISOR0 {20} \
   CONFIG.PCW_UART_PERIPHERAL_FREQMHZ {50} \
   CONFIG.PCW_UART_PERIPHERAL_VALID {1} \
   CONFIG.PCW_UIPARAM_ACT_DDR_FREQ_MHZ {533.333374} \
   CONFIG.PCW_UIPARAM_DDR_BANK_ADDR_COUNT {3} \
   CONFIG.PCW_UIPARAM_DDR_BL {8} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.294} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.298} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.338} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.334} \
   CONFIG.PCW_UIPARAM_DDR_BUS_WIDTH {32 Bit} \
   CONFIG.PCW_UIPARAM_DDR_CL {7} \
   CONFIG.PCW_UIPARAM_DDR_CLOCK_0_LENGTH_MM {54.14} \
   CONFIG.PCW_UIPARAM_DDR_CLOCK_1_LENGTH_MM {54.14} \
   CONFIG.PCW_UIPARAM_DDR_CLOCK_2_LENGTH_MM {39.7} \
   CONFIG.PCW_UIPARAM_DDR_CLOCK_3_LENGTH_MM {39.7} \
   CONFIG.PCW_UIPARAM_DDR_COL_ADDR_COUNT {10} \
   CONFIG.PCW_UIPARAM_DDR_CWL {6} \
   CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY {4096 MBits} \
   CONFIG.PCW_UIPARAM_DDR_DQS_0_LENGTH_MM {50.05} \
   CONFIG.PCW_UIPARAM_DDR_DQS_1_LENGTH_MM {50.43} \
   CONFIG.PCW_UIPARAM_DDR_DQS_2_LENGTH_MM {50.10} \
   CONFIG.PCW_UIPARAM_DDR_DQS_3_LENGTH_MM {50.01} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {-0.073} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {-0.072} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {0.024} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {0.023} \
   CONFIG.PCW_UIPARAM_DDR_DQ_0_LENGTH_MM {49.59} \
   CONFIG.PCW_UIPARAM_DDR_DQ_1_LENGTH_MM {51.74} \
   CONFIG.PCW_UIPARAM_DDR_DQ_2_LENGTH_MM {50.32} \
   CONFIG.PCW_UIPARAM_DDR_DQ_3_LENGTH_MM {48.55} \
   CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH {16 Bits} \
   CONFIG.PCW_UIPARAM_DDR_ECC {Disabled} \
   CONFIG.PCW_UIPARAM_DDR_MEMORY_TYPE {DDR 3} \
   CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K256M16 RE-125} \
   CONFIG.PCW_UIPARAM_DDR_ROW_ADDR_COUNT {15} \
   CONFIG.PCW_UIPARAM_DDR_SPEED_BIN {DDR3_1066F} \
   CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} \
   CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} \
   CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} \
   CONFIG.PCW_UIPARAM_DDR_T_FAW {40.0} \
   CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN {35.0} \
   CONFIG.PCW_UIPARAM_DDR_T_RC {48.75} \
   CONFIG.PCW_UIPARAM_DDR_T_RCD {7} \
   CONFIG.PCW_UIPARAM_DDR_T_RP {7} \
   CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF {0} \
   CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_USB0_PERIPHERAL_FREQMHZ {60} \
   CONFIG.PCW_USB0_RESET_ENABLE {1} \
   CONFIG.PCW_USB0_RESET_IO {MIO 7} \
   CONFIG.PCW_USB0_USB0_IO {MIO 28 .. 39} \
   CONFIG.PCW_USB1_RESET_ENABLE {0} \
   CONFIG.PCW_USB_RESET_ENABLE {1} \
   CONFIG.PCW_USB_RESET_SELECT {Share reset pin} \
   CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
   CONFIG.PCW_USE_M_AXI_GP0 {1} \
   CONFIG.PCW_USE_M_AXI_GP1 {0} \
 ] $processing_system7_0

  # Create instance: ps7_0_axi_periph, and set properties
  set ps7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 ps7_0_axi_periph ]
  set_property -dict [ list \
   CONFIG.NUM_MI {5} \
 ] $ps7_0_axi_periph

  # Create instance: rst_ps7_0_100M, and set properties
  set rst_ps7_0_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps7_0_100M ]

  # Create instance: rst_ps7_0_50M, and set properties
  set rst_ps7_0_50M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps7_0_50M ]

  # Create instance: serial_interrupt_0, and set properties
  set block_name serial_interrupt
  set block_cell_name serial_interrupt_0
  if { [catch {set serial_interrupt_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $serial_interrupt_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: start_GRID_0, and set properties
  set block_name start_GRID
  set block_cell_name start_GRID_0
  if { [catch {set start_GRID_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $start_GRID_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: start_PMSM_0, and set properties
  set block_name start_PMSM
  set block_cell_name start_PMSM_0
  if { [catch {set start_PMSM_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $start_PMSM_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: start_peripheral_0, and set properties
  set block_name start_peripheral
  set block_cell_name start_peripheral_0
  if { [catch {set start_peripheral_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $start_peripheral_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: system_ila_0, and set properties
  set system_ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_0 ]
  set_property -dict [ list \
   CONFIG.C_MON_TYPE {NATIVE} \
   CONFIG.C_NUM_OF_PROBES {4} \
   CONFIG.C_PROBE0_TYPE {1} \
   CONFIG.C_PROBE1_TYPE {1} \
   CONFIG.C_PROBE2_TYPE {1} \
   CONFIG.C_PROBE3_TYPE {1} \
 ] $system_ila_0

  # Create instance: truncate_bits_0, and set properties
  set block_name truncate_bits
  set block_cell_name truncate_bits_0
  if { [catch {set truncate_bits_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $truncate_bits_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.IN0_WIDTH {3} \
   CONFIG.IN1_WIDTH {2} \
   CONFIG.NUM_PORTS {2} \
 ] $xlconcat_0

  # Create instance: xlconcat_1, and set properties
  set xlconcat_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_1 ]
  set_property -dict [ list \
   CONFIG.IN0_WIDTH {1} \
   CONFIG.IN1_WIDTH {1} \
   CONFIG.NUM_PORTS {3} \
 ] $xlconcat_1

  # Create instance: xlconcat_2, and set properties
  set xlconcat_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_2 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {8} \
 ] $xlconcat_2

  # Create instance: xlconcat_3, and set properties
  set xlconcat_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_3 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {8} \
 ] $xlconcat_3

  # Create instance: xlconcat_4, and set properties
  set xlconcat_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_4 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {8} \
 ] $xlconcat_4

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {10} \
   CONFIG.CONST_WIDTH {11} \
 ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {112} \
   CONFIG.CONST_WIDTH {7} \
 ] $xlconstant_1

  # Create instance: xlconstant_4, and set properties
  set xlconstant_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_4 ]

  # Create instance: xlconstant_6, and set properties
  set xlconstant_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_6 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {16} \
 ] $xlconstant_6

  # Create instance: xlconstant_11, and set properties
  set xlconstant_11 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_11 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {112} \
   CONFIG.CONST_WIDTH {7} \
 ] $xlconstant_11

  # Create instance: xlconstant_17, and set properties
  set xlconstant_17 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_17 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {113} \
   CONFIG.CONST_WIDTH {7} \
 ] $xlconstant_17

  # Create instance: xlconstant_19, and set properties
  set xlconstant_19 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_19 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {2} \
 ] $xlconstant_19

  # Create instance: xlconstant_21, and set properties
  set xlconstant_21 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_21 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {114} \
   CONFIG.CONST_WIDTH {7} \
 ] $xlconstant_21

  # Create instance: xlconstant_22, and set properties
  set xlconstant_22 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_22 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {2048} \
   CONFIG.CONST_WIDTH {12} \
 ] $xlconstant_22

  # Create interface connections
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR_0] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO_0] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins ps7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net ps7_0_axi_periph_M00_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins ps7_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net ps7_0_axi_periph_M01_AXI [get_bd_intf_pins NV_parameter_load_0/S00_AXI] [get_bd_intf_pins ps7_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net ps7_0_axi_periph_M02_AXI [get_bd_intf_pins NV_io_controller_0/S00_AXI] [get_bd_intf_pins ps7_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net ps7_0_axi_periph_M03_AXI [get_bd_intf_pins parameter_load_2_0/S00_AXI] [get_bd_intf_pins ps7_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net ps7_0_axi_periph_M04_AXI [get_bd_intf_pins Digital_Outputs_0/S00_AXI] [get_bd_intf_pins ps7_0_axi_periph/M04_AXI]

  # Create port connections
  connect_bd_net -net AD1RefComp_0_DATA1 [get_bd_pins AD1RefComp_0/DATA1] [get_bd_pins NV_io_controller_0/Fan_input_value]
  connect_bd_net -net AD1RefComp_0_SCLK [get_bd_ports SCLK_0] [get_bd_pins AD1RefComp_0/SCLK]
  connect_bd_net -net AD1RefComp_0_nCS [get_bd_ports nCS_0] [get_bd_pins AD1RefComp_0/nCS]
  connect_bd_net -net AD_5293_v2_0_CLK_OUT [get_bd_ports SCLK_out_7] [get_bd_pins AD_5293_v2_0/CLK_OUT]
  connect_bd_net -net AD_5293_v2_0_D1 [get_bd_ports Din_out_17] [get_bd_pins AD_5293_v2_0/D1]
  connect_bd_net -net AD_5293_v2_0_D2 [get_bd_ports Din_out_19] [get_bd_pins AD_5293_v2_0/D2]
  connect_bd_net -net AD_5293_v2_0_D3 [get_bd_ports Din_out_18] [get_bd_pins AD_5293_v2_0/D3]
  connect_bd_net -net AD_5293_v2_0_D4 [get_bd_ports Din_out_20] [get_bd_pins AD_5293_v2_0/D4]
  connect_bd_net -net AD_5293_v2_0_nSYNC [get_bd_ports nSync_out_6] [get_bd_pins AD_5293_v2_0/nSYNC]
  connect_bd_net -net DAC_121s101_0_CLK_OUT [get_bd_ports SCLK_out_0] [get_bd_ports SCLK_out_1] [get_bd_ports SCLK_out_2] [get_bd_ports SCLK_out_3] [get_bd_ports SCLK_out_4] [get_bd_ports SCLK_out_6] [get_bd_pins DAC_121s101_0/CLK_OUT]
  connect_bd_net -net DAC_121s101_0_D1 [get_bd_ports Din_out_0] [get_bd_pins DAC_121s101_0/D1]
  connect_bd_net -net DAC_121s101_0_D2 [get_bd_ports Din_out_6] [get_bd_pins DAC_121s101_0/D2]
  connect_bd_net -net DAC_121s101_0_D3 [get_bd_ports Din_out_5] [get_bd_pins DAC_121s101_0/D3]
  connect_bd_net -net DAC_121s101_0_D4 [get_bd_ports Din_out_4] [get_bd_pins DAC_121s101_0/D4]
  connect_bd_net -net DAC_121s101_0_D5 [get_bd_ports Din_out_3] [get_bd_pins DAC_121s101_0/D5]
  connect_bd_net -net DAC_121s101_0_D6 [get_bd_ports Din_out_2] [get_bd_pins DAC_121s101_0/D6]
  connect_bd_net -net DAC_121s101_0_D7 [get_bd_ports Din_out_1] [get_bd_pins DAC_121s101_0/D7]
  connect_bd_net -net DAC_121s101_0_D8 [get_bd_ports Din_out_7] [get_bd_pins DAC_121s101_0/D8]
  connect_bd_net -net DAC_121s101_0_D9 [get_bd_ports Din_out_10] [get_bd_pins DAC_121s101_0/D9]
  connect_bd_net -net DAC_121s101_0_D10 [get_bd_ports Din_out_11] [get_bd_pins DAC_121s101_0/D10]
  connect_bd_net -net DAC_121s101_0_D11 [get_bd_ports Din_out_15] [get_bd_pins DAC_121s101_0/D11]
  connect_bd_net -net DAC_121s101_0_D12 [get_bd_ports Din_out_9] [get_bd_pins DAC_121s101_0/D12]
  connect_bd_net -net DAC_121s101_0_D13 [get_bd_ports Din_out_8] [get_bd_pins DAC_121s101_0/D13]
  connect_bd_net -net DAC_121s101_0_D14 [get_bd_ports Din_out_14] [get_bd_pins DAC_121s101_0/D14]
  connect_bd_net -net DAC_121s101_0_D15 [get_bd_ports Din_out_13] [get_bd_pins DAC_121s101_0/D15]
  connect_bd_net -net DAC_121s101_0_D16 [get_bd_ports Din_out_12] [get_bd_pins DAC_121s101_0/D16]
  connect_bd_net -net DAC_121s101_0_D17 [get_bd_ports Din_out_16] [get_bd_pins DAC_121s101_0/D17]
  connect_bd_net -net DAC_121s101_0_nSYNC [get_bd_ports nSync_out_0] [get_bd_pins DAC_121s101_0/nSYNC]
  connect_bd_net -net DCbus_dynamic_0_V_bus [get_bd_pins DCbus_dynamic_0/V_bus] [get_bd_pins bridge3ph_0/Vdc_f] [get_bd_pins gain_offset_truncation_1/in_V_dc_bus] [get_bd_pins grid_bridge3ph_0/Vdc]
  connect_bd_net -net DRIVER_DOWN_00_1 [get_bd_ports DRIVER_DOWN_00] [get_bd_pins IGBT_input_selector_1/grid_T4_NV]
  connect_bd_net -net DRIVER_DOWN_01_1 [get_bd_ports DRIVER_DOWN_01] [get_bd_pins IGBT_input_selector_1/grid_T5_NV]
  connect_bd_net -net DRIVER_DOWN_02_1 [get_bd_ports DRIVER_DOWN_02] [get_bd_pins IGBT_input_selector_1/grid_T6_NV]
  connect_bd_net -net DRIVER_DOWN_04_1 [get_bd_ports DRIVER_DOWN_04] [get_bd_pins IGBT_input_selector_0/grid_T6_NV]
  connect_bd_net -net DRIVER_DOWN_05_1 [get_bd_ports DRIVER_DOWN_05] [get_bd_pins IGBT_input_selector_0/grid_T5_NV]
  connect_bd_net -net DRIVER_DOWN_06_1 [get_bd_ports DRIVER_DOWN_06] [get_bd_pins IGBT_input_selector_0/grid_T4_NV]
  connect_bd_net -net DRIVER_UP_00_1 [get_bd_ports DRIVER_UP_00] [get_bd_pins IGBT_input_selector_1/grid_T1_NV]
  connect_bd_net -net DRIVER_UP_01_1 [get_bd_ports DRIVER_UP_01] [get_bd_pins IGBT_input_selector_1/grid_T2_NV]
  connect_bd_net -net DRIVER_UP_02_1 [get_bd_ports DRIVER_UP_02] [get_bd_pins IGBT_input_selector_1/grid_T3_NV]
  connect_bd_net -net DRIVER_UP_03_1 [get_bd_ports DRIVER_UP_03] [get_bd_pins DCbus_dynamic_0/ena_chop_res]
  connect_bd_net -net DRIVER_UP_04_1 [get_bd_ports DRIVER_UP_04] [get_bd_pins IGBT_input_selector_0/grid_T3_NV]
  connect_bd_net -net DRIVER_UP_05_1 [get_bd_ports DRIVER_UP_05] [get_bd_pins IGBT_input_selector_0/grid_T2_NV]
  connect_bd_net -net DRIVER_UP_06_1 [get_bd_ports DRIVER_UP_06] [get_bd_pins IGBT_input_selector_0/grid_T1_NV]
  connect_bd_net -net De_Multiplexer_8b_0_NOT_data_out_7 [get_bd_pins De_Multiplexer_8b_0/NOT_data_out_7] [get_bd_pins NV_multiplier_0/input_1_2] [get_bd_pins xlconcat_1/In2]
  connect_bd_net -net De_Multiplexer_8b_0_data_out_0 [get_bd_pins De_Multiplexer_8b_0/data_out_0] [get_bd_pins NV_multiplier_0/input_1_3] [get_bd_pins xlconcat_1/In1]
  connect_bd_net -net De_Multiplexer_8b_0_data_out_1 [get_bd_pins De_Multiplexer_8b_0/data_out_2] [get_bd_pins NV_multiplier_0/input_1_4] [get_bd_pins xlconcat_1/In0]
  connect_bd_net -net De_Multiplexer_8b_0_data_out_2 [get_bd_pins De_Multiplexer_8b_0/data_out_1] [get_bd_pins NV_multiplier_0/input_1_1] [get_bd_pins pmsm_0/K2]
  connect_bd_net -net De_Multiplexer_8b_0_data_out_3 [get_bd_pins De_Multiplexer_8b_0/data_out_3] [get_bd_pins NV_multiplier_0/input_1_5]
  connect_bd_net -net De_Multiplexer_8b_0_data_out_4 [get_bd_pins De_Multiplexer_8b_0/data_out_4] [get_bd_pins NV_multiplier_0/input_1_0]
  connect_bd_net -net Digital_Outputs_0_out_01 [get_bd_pins Digital_Outputs_0/out_01] [get_bd_pins xlconcat_2/In0]
  connect_bd_net -net Digital_Outputs_0_out_02 [get_bd_pins Digital_Outputs_0/out_02] [get_bd_pins NV_multiplier_0/input_0_0]
  connect_bd_net -net Digital_Outputs_0_out_03 [get_bd_pins Digital_Outputs_0/out_03] [get_bd_pins xlconcat_2/In2]
  connect_bd_net -net Digital_Outputs_0_out_04 [get_bd_pins Digital_Outputs_0/out_04] [get_bd_pins NV_multiplier_0/input_0_1]
  connect_bd_net -net Digital_Outputs_0_out_05 [get_bd_pins Digital_Outputs_0/out_05] [get_bd_pins xlconcat_2/In4]
  connect_bd_net -net Digital_Outputs_0_out_06 [get_bd_pins Digital_Outputs_0/out_06] [get_bd_pins xlconcat_2/In5]
  connect_bd_net -net Digital_Outputs_0_out_07 [get_bd_pins Digital_Outputs_0/out_07] [get_bd_pins NV_multiplier_0/input_0_2]
  connect_bd_net -net Digital_Outputs_0_out_08 [get_bd_pins Digital_Outputs_0/out_08] [get_bd_pins NV_multiplier_0/input_0_3]
  connect_bd_net -net Digital_Outputs_0_out_11 [get_bd_pins Digital_Outputs_0/out_11] [get_bd_pins NV_multiplier_0/input_0_4]
  connect_bd_net -net Digital_Outputs_0_out_12 [get_bd_pins Digital_Outputs_0/out_12] [get_bd_pins xlconcat_3/In1]
  connect_bd_net -net Digital_Outputs_0_out_13 [get_bd_pins Digital_Outputs_0/out_13] [get_bd_pins xlconcat_3/In2]
  connect_bd_net -net Digital_Outputs_0_out_14 [get_bd_pins Digital_Outputs_0/out_14] [get_bd_pins xlconcat_3/In3]
  connect_bd_net -net Digital_Outputs_0_out_15 [get_bd_pins Digital_Outputs_0/out_15] [get_bd_pins xlconcat_3/In4]
  connect_bd_net -net Digital_Outputs_0_out_16 [get_bd_pins Digital_Outputs_0/out_16] [get_bd_pins xlconcat_3/In5]
  connect_bd_net -net Digital_Outputs_0_out_17 [get_bd_pins Digital_Outputs_0/out_17] [get_bd_pins xlconcat_3/In6]
  connect_bd_net -net Digital_Outputs_0_out_18 [get_bd_pins Digital_Outputs_0/out_18] [get_bd_pins NV_multiplier_0/input_0_5]
  connect_bd_net -net Digital_Outputs_0_out_21 [get_bd_pins Digital_Outputs_0/out_21] [get_bd_pins xlconcat_4/In0]
  connect_bd_net -net Digital_Outputs_0_out_22 [get_bd_pins Digital_Outputs_0/out_22] [get_bd_pins xlconcat_4/In1]
  connect_bd_net -net Digital_Outputs_0_out_23 [get_bd_pins Digital_Outputs_0/out_23] [get_bd_pins xlconcat_4/In2]
  connect_bd_net -net Digital_Outputs_0_out_24 [get_bd_pins Digital_Outputs_0/out_24] [get_bd_pins xlconcat_4/In3]
  connect_bd_net -net Digital_Outputs_0_out_25 [get_bd_pins Digital_Outputs_0/out_25] [get_bd_pins xlconcat_4/In4]
  connect_bd_net -net Digital_Outputs_0_out_26 [get_bd_pins Digital_Outputs_0/out_26] [get_bd_pins xlconcat_4/In5]
  connect_bd_net -net Digital_Outputs_0_out_27 [get_bd_pins Digital_Outputs_0/out_27] [get_bd_pins xlconcat_4/In6]
  connect_bd_net -net Digital_Outputs_0_out_28 [get_bd_pins Digital_Outputs_0/out_28] [get_bd_pins xlconcat_4/In7]
  connect_bd_net -net FSM_0_Start1 [get_bd_pins DCbus_dynamic_0/ap_start] [get_bd_pins gain_offset_truncation_1/ap_start] [get_bd_pins grid_0/ap_start] [get_bd_pins grid_bridge3ph_0/ap_start] [get_bd_pins lcl_filter_0/ap_start] [get_bd_pins start_GRID_0/start_grid_side]
  connect_bd_net -net IGBT_input_selector_0_grid_T1 [get_bd_pins IGBT_input_selector_0/grid_T1] [get_bd_pins grid_bridge3ph_0/T1]
  connect_bd_net -net IGBT_input_selector_0_grid_T2 [get_bd_pins IGBT_input_selector_0/grid_T2] [get_bd_pins grid_bridge3ph_0/T2]
  connect_bd_net -net IGBT_input_selector_0_grid_T3 [get_bd_pins IGBT_input_selector_0/grid_T3] [get_bd_pins grid_bridge3ph_0/T3]
  connect_bd_net -net IGBT_input_selector_0_grid_T4 [get_bd_pins IGBT_input_selector_0/grid_T4] [get_bd_pins grid_bridge3ph_0/T4]
  connect_bd_net -net IGBT_input_selector_0_grid_T5 [get_bd_pins IGBT_input_selector_0/grid_T5] [get_bd_pins grid_bridge3ph_0/T5]
  connect_bd_net -net IGBT_input_selector_0_grid_T6 [get_bd_pins IGBT_input_selector_0/grid_T6] [get_bd_pins grid_bridge3ph_0/T6]
  connect_bd_net -net IGBT_input_selector_1_grid_T1 [get_bd_pins IGBT_input_selector_1/grid_T1] [get_bd_pins bridge3ph_0/T3]
  connect_bd_net -net IGBT_input_selector_1_grid_T2 [get_bd_pins IGBT_input_selector_1/grid_T2] [get_bd_pins bridge3ph_0/T2]
  connect_bd_net -net IGBT_input_selector_1_grid_T3 [get_bd_pins IGBT_input_selector_1/grid_T3] [get_bd_pins bridge3ph_0/T1]
  connect_bd_net -net IGBT_input_selector_1_grid_T4 [get_bd_pins IGBT_input_selector_1/grid_T4] [get_bd_pins bridge3ph_0/T6]
  connect_bd_net -net IGBT_input_selector_1_grid_T5 [get_bd_pins IGBT_input_selector_1/grid_T5] [get_bd_pins bridge3ph_0/T5]
  connect_bd_net -net IGBT_input_selector_1_grid_T6 [get_bd_pins IGBT_input_selector_1/grid_T6] [get_bd_pins bridge3ph_0/T4]
  connect_bd_net -net NOT_8_0_out_8 [get_bd_pins De_Multiplexer_8b_0/data_in] [get_bd_pins NOT_8_0/out_8] [get_bd_pins NV_io_controller_0/Expansor_input_value]
  connect_bd_net -net NV_io_controller_0_potDig_output_value_2 [get_bd_pins AD_5293_v2_0/DATA1] [get_bd_pins NV_io_controller_0/potDig_output_value_1] [get_bd_pins system_ila_0/probe0]
  set_property -dict [ list \
HDL_ATTRIBUTE.DEBUG {true} \
 ] [get_bd_nets NV_io_controller_0_potDig_output_value_2]
  connect_bd_net -net NV_io_controller_0_potDig_output_value_3 [get_bd_pins AD_5293_v2_0/DATA2] [get_bd_pins NV_io_controller_0/potDig_output_value_2] [get_bd_pins system_ila_0/probe1]
  set_property -dict [ list \
HDL_ATTRIBUTE.DEBUG {true} \
 ] [get_bd_nets NV_io_controller_0_potDig_output_value_3]
  connect_bd_net -net NV_io_controller_0_potDig_output_value_4 [get_bd_pins AD_5293_v2_0/DATA3] [get_bd_pins NV_io_controller_0/potDig_output_value_3] [get_bd_pins system_ila_0/probe2]
  set_property -dict [ list \
HDL_ATTRIBUTE.DEBUG {true} \
 ] [get_bd_nets NV_io_controller_0_potDig_output_value_4]
  connect_bd_net -net NV_io_controller_0_potDig_output_value_5 [get_bd_pins AD_5293_v2_0/DATA4] [get_bd_pins NV_io_controller_0/potDig_output_value_4] [get_bd_pins system_ila_0/probe3]
  set_property -dict [ list \
HDL_ATTRIBUTE.DEBUG {true} \
 ] [get_bd_nets NV_io_controller_0_potDig_output_value_5]
  connect_bd_net -net NV_multiplier_0_output_0 [get_bd_pins NV_multiplier_0/output_0] [get_bd_pins xlconcat_2/In1]
  connect_bd_net -net NV_multiplier_0_output_1 [get_bd_pins NV_multiplier_0/output_1] [get_bd_pins xlconcat_2/In3]
  connect_bd_net -net NV_multiplier_0_output_2 [get_bd_pins NV_multiplier_0/output_2] [get_bd_pins xlconcat_2/In6]
  connect_bd_net -net NV_multiplier_0_output_3 [get_bd_pins NV_multiplier_0/output_3] [get_bd_pins xlconcat_2/In7]
  connect_bd_net -net NV_multiplier_0_output_4 [get_bd_pins NV_multiplier_0/output_4] [get_bd_pins xlconcat_3/In0]
  connect_bd_net -net NV_multiplier_0_output_5 [get_bd_pins NV_multiplier_0/output_5] [get_bd_pins xlconcat_3/In7]
  connect_bd_net -net NV_parameter_load_0_DC_bus_fived [get_bd_pins DCbus_dynamic_0/DC_bus_fixed_volt] [get_bd_pins NV_parameter_load_0/DC_bus_fived]
  connect_bd_net -net NV_parameter_load_0_DC_bus_fixed_volt [get_bd_pins DCbus_dynamic_0/V_DC_voltage_in] [get_bd_pins NV_parameter_load_0/DC_bus_fixed_volt]
  connect_bd_net -net NV_parameter_load_0_Lcc_dt [get_bd_pins NV_parameter_load_0/Lcc_dt] [get_bd_pins lcl_filter_0/Lcc_dT]
  connect_bd_net -net NV_parameter_load_0_Pole_Pairs [get_bd_pins NV_parameter_load_0/Pole_Pairs] [get_bd_pins pmsm_0/Pole_pairs_V]
  connect_bd_net -net NV_parameter_load_0_amp_a [get_bd_pins NV_parameter_load_0/amp_a] [get_bd_pins grid_0/ampl_a]
  connect_bd_net -net NV_parameter_load_0_amp_b [get_bd_pins NV_parameter_load_0/amp_b] [get_bd_pins grid_0/ampl_b]
  connect_bd_net -net NV_parameter_load_0_amp_c [get_bd_pins NV_parameter_load_0/amp_c] [get_bd_pins grid_0/ampl_c]
  connect_bd_net -net NV_parameter_load_0_counter_limit [get_bd_pins NV_parameter_load_0/counter_limit] [get_bd_pins grid_0/counter_limit]
  connect_bd_net -net NV_parameter_load_0_dt_C [get_bd_pins NV_parameter_load_0/dt_C] [get_bd_pins lcl_filter_0/dT_C]
  connect_bd_net -net NV_parameter_load_0_dt_L1 [get_bd_pins NV_parameter_load_0/dt_L1] [get_bd_pins lcl_filter_0/dT_L1]
  connect_bd_net -net NV_parameter_load_0_dt_L2 [get_bd_pins NV_parameter_load_0/dt_L2] [get_bd_pins lcl_filter_0/dT_L2]
  connect_bd_net -net NV_parameter_load_0_inv_seq [get_bd_pins NV_parameter_load_0/inv_seq] [get_bd_pins grid_0/inv_seq]
  connect_bd_net -net NV_parameter_load_0_lamda_e [get_bd_pins NV_parameter_load_0/lamda_e] [get_bd_pins pmsm_0/landa_m_V]
  connect_bd_net -net NV_parameter_load_0_mode_igbt_input [get_bd_pins IGBT_input_selector_0/mode] [get_bd_pins NV_parameter_load_0/mode_igbt_input]
  connect_bd_net -net NV_parameter_load_0_mode_igbt_input_PMSM [get_bd_pins IGBT_input_selector_1/mode] [get_bd_pins NV_parameter_load_0/mode_igbt_input_PMSM]
  connect_bd_net -net NV_parameter_load_0_phase_step [get_bd_pins NV_parameter_load_0/phase_step] [get_bd_pins grid_0/phase_step]
  connect_bd_net -net NV_parameter_load_0_phase_step_on [get_bd_pins NV_parameter_load_0/phase_step_on] [get_bd_pins grid_0/phase_step_on]
  connect_bd_net -net NV_parameter_load_0_rC [get_bd_pins NV_parameter_load_0/rC] [get_bd_pins lcl_filter_0/rC]
  connect_bd_net -net NV_parameter_load_0_t_step_C [get_bd_pins DCbus_dynamic_0/t_step_C] [get_bd_pins NV_parameter_load_0/t_step_C]
  connect_bd_net -net Net [get_bd_ports sda_0] [get_bd_pins TCA9538_driver_0/sda]
  connect_bd_net -net Net1 [get_bd_pins AD_5293_v2_0/START] [get_bd_pins start_peripheral_0/Start_pot_dig]
  connect_bd_net -net Net2 [get_bd_ports scl_0] [get_bd_pins TCA9538_driver_0/scl]
  connect_bd_net -net Net3 [get_bd_pins gen_referencias_1/ma] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net Net4 [get_bd_ports sda_1] [get_bd_pins TCA9538_driver_input_0/sda]
  connect_bd_net -net Net5 [get_bd_ports scl_1] [get_bd_pins TCA9538_driver_input_0/scl]
  connect_bd_net -net Net6 [get_bd_pins grid_0/proof_flag_on] [get_bd_pins parameter_load_2_0/ena_chop_res]
  connect_bd_net -net Net7 [get_bd_pins bridge3ph_0/ap_start] [get_bd_pins float_conversor_0/ap_start] [get_bd_pins pmsm_0/ap_start] [get_bd_pins start_PMSM_0/start_pmsm_side] [get_bd_pins truncate_bits_0/start]
  connect_bd_net -net SDATA1_0_1 [get_bd_ports SDATA1_0] [get_bd_pins AD1RefComp_0/SDATA1]
  connect_bd_net -net TCA9538_driver_0_nRST_out [get_bd_ports nRST_out_0] [get_bd_pins TCA9538_driver_0/nRST_out]
  connect_bd_net -net TCA9538_driver_input_0_data_out [get_bd_pins NOT_8_0/in_8] [get_bd_pins TCA9538_driver_input_0/data_out]
  connect_bd_net -net TCA9538_driver_input_0_nRST_out [get_bd_ports nRST_out_1] [get_bd_pins TCA9538_driver_input_0/nRST_out]
  connect_bd_net -net axi_gpio_0_ip2intc_irpt [get_bd_pins axi_gpio_0/ip2intc_irpt] [get_bd_pins processing_system7_0/IRQ_F2P]
  connect_bd_net -net bit_order_adjust_tca9538_1_u10_data_out [get_bd_pins TCA9538_driver_0/data_1_in] [get_bd_pins bit_order_adjust_tca9538_1/u10_data_out]
  connect_bd_net -net bit_order_adjust_tca9538_1_u12_data_out [get_bd_pins TCA9538_driver_0/data_2_in] [get_bd_pins bit_order_adjust_tca9538_1/u12_data_out]
  connect_bd_net -net bit_order_adjust_tca9538_1_u14_data_out [get_bd_pins TCA9538_driver_0/data_3_in] [get_bd_pins bit_order_adjust_tca9538_1/u14_data_out]
  connect_bd_net -net bridge3ph_0_Idc [get_bd_pins DCbus_dynamic_0/I_in] [get_bd_pins bridge3ph_0/Idc]
  connect_bd_net -net bridge3ph_0_Va_V [get_bd_pins bridge3ph_0/Va_V] [get_bd_pins pmsm_0/Vs_a_V]
  connect_bd_net -net bridge3ph_0_Vb_V [get_bd_pins bridge3ph_0/Vb_V] [get_bd_pins pmsm_0/Vs_b_V]
  connect_bd_net -net bridge3ph_0_Vc_V [get_bd_pins bridge3ph_0/Vc_V] [get_bd_pins pmsm_0/Vs_c_V]
  connect_bd_net -net bridge3ph_0_Vn_gnd_V [get_bd_pins bridge3ph_0/Vn_gnd_V] [get_bd_pins pmsm_0/VN_gnd_V]
  connect_bd_net -net data_out_5 [get_bd_pins De_Multiplexer_8b_0/data_out_5]
  connect_bd_net -net data_out_6 [get_bd_pins De_Multiplexer_8b_0/data_out_6]
  connect_bd_net -net float_conversor_0_out_1 [get_bd_pins float_conversor_0/out_1] [get_bd_pins gain_offset_truncation_1/in_I_pmsm_a]
  connect_bd_net -net float_conversor_0_out_2 [get_bd_pins float_conversor_0/out_2] [get_bd_pins gain_offset_truncation_1/in_I_pmsm_b]
  connect_bd_net -net float_conversor_0_out_3 [get_bd_pins float_conversor_0/out_3] [get_bd_pins gain_offset_truncation_1/in_I_pmsm_c]
  connect_bd_net -net float_conversor_0_out_4 [get_bd_pins float_conversor_0/out_4] [get_bd_pins gain_offset_truncation_1/in_V_fem_a]
  connect_bd_net -net float_conversor_0_out_5 [get_bd_pins float_conversor_0/out_5] [get_bd_pins gain_offset_truncation_1/in_V_fem_b]
  connect_bd_net -net float_conversor_0_out_6 [get_bd_pins float_conversor_0/out_6] [get_bd_pins gain_offset_truncation_1/in_V_fem_c]
  connect_bd_net -net gain_offset_truncation_1_out_I_LCL_1_a [get_bd_pins DAC_121s101_0/DATA1] [get_bd_pins gain_offset_truncation_1/out_I_LCL_1_a]
  connect_bd_net -net gain_offset_truncation_1_out_I_LCL_1_b [get_bd_pins DAC_121s101_0/DATA2] [get_bd_pins gain_offset_truncation_1/out_I_LCL_1_b]
  connect_bd_net -net gain_offset_truncation_1_out_I_LCL_1_c [get_bd_pins DAC_121s101_0/DATA3] [get_bd_pins gain_offset_truncation_1/out_I_LCL_1_c]
  connect_bd_net -net gain_offset_truncation_1_out_I_LCL_2_a [get_bd_pins DAC_121s101_0/DATA8] [get_bd_pins gain_offset_truncation_1/out_I_LCL_2_a]
  connect_bd_net -net gain_offset_truncation_1_out_I_LCL_2_b [get_bd_pins DAC_121s101_0/DATA9] [get_bd_pins gain_offset_truncation_1/out_I_LCL_2_b]
  connect_bd_net -net gain_offset_truncation_1_out_I_LCL_2_c [get_bd_pins DAC_121s101_0/DATA10] [get_bd_pins gain_offset_truncation_1/out_I_LCL_2_c]
  connect_bd_net -net gain_offset_truncation_1_out_I_pmsm_a [get_bd_pins DAC_121s101_0/DATA4] [get_bd_pins gain_offset_truncation_1/out_I_pmsm_a]
  connect_bd_net -net gain_offset_truncation_1_out_I_pmsm_b [get_bd_pins DAC_121s101_0/DATA5] [get_bd_pins gain_offset_truncation_1/out_I_pmsm_b]
  connect_bd_net -net gain_offset_truncation_1_out_I_pmsm_c [get_bd_pins DAC_121s101_0/DATA6] [get_bd_pins gain_offset_truncation_1/out_I_pmsm_c]
  connect_bd_net -net gain_offset_truncation_1_out_V_dc_bus [get_bd_pins DAC_121s101_0/DATA7] [get_bd_pins gain_offset_truncation_1/out_V_dc_bus]
  connect_bd_net -net gain_offset_truncation_1_out_V_fem_a [get_bd_pins DAC_121s101_0/DATA14] [get_bd_pins gain_offset_truncation_1/out_V_fem_a]
  connect_bd_net -net gain_offset_truncation_1_out_V_fem_b [get_bd_pins DAC_121s101_0/DATA15] [get_bd_pins gain_offset_truncation_1/out_V_fem_b]
  connect_bd_net -net gain_offset_truncation_1_out_V_fem_c [get_bd_pins DAC_121s101_0/DATA16] [get_bd_pins gain_offset_truncation_1/out_V_fem_c]
  connect_bd_net -net gain_offset_truncation_1_out_V_grid_a [get_bd_pins DAC_121s101_0/DATA11] [get_bd_pins gain_offset_truncation_1/out_V_grid_a]
  connect_bd_net -net gain_offset_truncation_1_out_V_grid_b [get_bd_pins DAC_121s101_0/DATA12] [get_bd_pins gain_offset_truncation_1/out_V_grid_b]
  connect_bd_net -net gain_offset_truncation_1_out_V_grid_c [get_bd_pins DAC_121s101_0/DATA13] [get_bd_pins gain_offset_truncation_1/out_V_grid_c]
  connect_bd_net -net gen_referencias_0_T1 [get_bd_pins IGBT_input_selector_1/grid_T1_test] [get_bd_pins gen_referencias_0/T1]
  connect_bd_net -net gen_referencias_0_T2 [get_bd_pins IGBT_input_selector_1/grid_T2_test] [get_bd_pins gen_referencias_0/T2]
  connect_bd_net -net gen_referencias_0_T3 [get_bd_pins IGBT_input_selector_1/grid_T3_test] [get_bd_pins gen_referencias_0/T3]
  connect_bd_net -net gen_referencias_0_T4 [get_bd_pins IGBT_input_selector_1/grid_T4_test] [get_bd_pins gen_referencias_0/T4]
  connect_bd_net -net gen_referencias_0_T5 [get_bd_pins IGBT_input_selector_1/grid_T5_test] [get_bd_pins gen_referencias_0/T5]
  connect_bd_net -net gen_referencias_0_T6 [get_bd_pins IGBT_input_selector_1/grid_T6_test] [get_bd_pins gen_referencias_0/T6]
  connect_bd_net -net gen_referencias_1_T1 [get_bd_pins IGBT_input_selector_0/grid_T1_test] [get_bd_pins gen_referencias_1/T1]
  connect_bd_net -net gen_referencias_1_T2 [get_bd_pins IGBT_input_selector_0/grid_T2_test] [get_bd_pins gen_referencias_1/T2]
  connect_bd_net -net gen_referencias_1_T3 [get_bd_pins IGBT_input_selector_0/grid_T3_test] [get_bd_pins gen_referencias_1/T3]
  connect_bd_net -net gen_referencias_1_T4 [get_bd_pins IGBT_input_selector_0/grid_T4_test] [get_bd_pins gen_referencias_1/T4]
  connect_bd_net -net gen_referencias_1_T5 [get_bd_pins IGBT_input_selector_0/grid_T5_test] [get_bd_pins gen_referencias_1/T5]
  connect_bd_net -net gen_referencias_1_T6 [get_bd_pins IGBT_input_selector_0/grid_T6_test] [get_bd_pins gen_referencias_1/T6]
  connect_bd_net -net grid_0_Grid_a_r [get_bd_pins grid_0/Grid_a_r] [get_bd_pins lcl_filter_0/V2_a_s]
  connect_bd_net -net grid_0_Grid_b_r [get_bd_pins grid_0/Grid_b_r] [get_bd_pins lcl_filter_0/V2_b_s]
  connect_bd_net -net grid_0_Grid_c_r [get_bd_pins grid_0/Grid_c_r] [get_bd_pins lcl_filter_0/V2_c_s]
  connect_bd_net -net grid_bridge3ph_0_Idc_r [get_bd_pins DCbus_dynamic_0/I_out_s] [get_bd_pins grid_bridge3ph_0/Idc_r]
  connect_bd_net -net grid_bridge3ph_0_V_n_gnd_r [get_bd_pins grid_bridge3ph_0/V_n_gnd_r] [get_bd_pins lcl_filter_0/VN_gnd]
  connect_bd_net -net grid_bridge3ph_0_Va_r [get_bd_pins grid_bridge3ph_0/Va_r] [get_bd_pins lcl_filter_0/V1_a]
  connect_bd_net -net grid_bridge3ph_0_Vb_r [get_bd_pins grid_bridge3ph_0/Vb_r] [get_bd_pins lcl_filter_0/V1_b]
  connect_bd_net -net grid_bridge3ph_0_Vc_r [get_bd_pins grid_bridge3ph_0/Vc_r] [get_bd_pins lcl_filter_0/V1_c]
  connect_bd_net -net lcl_filter_0_IL1_a_r [get_bd_pins gain_offset_truncation_1/in_I_LCL_1_a] [get_bd_pins grid_bridge3ph_0/Ia] [get_bd_pins lcl_filter_0/IL1_a_r]
  connect_bd_net -net lcl_filter_0_IL1_b_r [get_bd_pins gain_offset_truncation_1/in_I_LCL_1_b] [get_bd_pins grid_bridge3ph_0/Ib] [get_bd_pins lcl_filter_0/IL1_b_r]
  connect_bd_net -net lcl_filter_0_IL1_c_r [get_bd_pins gain_offset_truncation_1/in_I_LCL_1_c] [get_bd_pins grid_bridge3ph_0/Ic] [get_bd_pins lcl_filter_0/IL1_c_r]
  connect_bd_net -net lcl_filter_0_IL2_a_r [get_bd_pins gain_offset_truncation_1/in_I_LCL_2_a] [get_bd_pins lcl_filter_0/IL2_a_r]
  connect_bd_net -net lcl_filter_0_IL2_b_r [get_bd_pins gain_offset_truncation_1/in_I_LCL_2_b] [get_bd_pins lcl_filter_0/IL2_b_r]
  connect_bd_net -net lcl_filter_0_IL2_c_r [get_bd_pins gain_offset_truncation_1/in_I_LCL_2_c] [get_bd_pins lcl_filter_0/IL2_c_r]
  connect_bd_net -net lcl_filter_0_V_grid_dac_a [get_bd_pins gain_offset_truncation_1/in_V_grid_a] [get_bd_pins lcl_filter_0/V_grid_dac_a]
  connect_bd_net -net lcl_filter_0_V_grid_dac_b [get_bd_pins gain_offset_truncation_1/in_V_grid_b] [get_bd_pins lcl_filter_0/V_grid_dac_b]
  connect_bd_net -net lcl_filter_0_V_grid_dac_c [get_bd_pins gain_offset_truncation_1/in_V_grid_c] [get_bd_pins lcl_filter_0/V_grid_dac_c]
  connect_bd_net -net lcl_filter_0_Vp_a_r [get_bd_pins gain_offset_truncation_1/in_Vp_a] [get_bd_pins lcl_filter_0/Vp_a_r]
  connect_bd_net -net lcl_filter_0_Vp_b_r [get_bd_pins gain_offset_truncation_1/in_Vp_b] [get_bd_pins lcl_filter_0/Vp_b_r]
  connect_bd_net -net lcl_filter_0_Vp_c_r [get_bd_pins gain_offset_truncation_1/in_Vp_c] [get_bd_pins lcl_filter_0/Vp_c_r]
  connect_bd_net -net parameter_load_2_0_Ld [get_bd_pins parameter_load_2_0/Ld] [get_bd_pins pmsm_0/Ld_V]
  connect_bd_net -net parameter_load_2_0_Lq [get_bd_pins parameter_load_2_0/Lq] [get_bd_pins pmsm_0/Lq_V]
  connect_bd_net -net parameter_load_2_0_Ls [get_bd_pins parameter_load_2_0/Ls] [get_bd_pins pmsm_0/Ls_V]
  connect_bd_net -net parameter_load_2_0_Preload [get_bd_pins lcl_filter_0/Preload] [get_bd_pins parameter_load_2_0/Preload]
  connect_bd_net -net parameter_load_2_0_Wn [get_bd_pins parameter_load_2_0/Wn] [get_bd_pins pmsm_0/Wn_o_V]
  connect_bd_net -net parameter_load_2_0_dT_Ls [get_bd_pins parameter_load_2_0/dT_Ls] [get_bd_pins pmsm_0/dT_Ls_V]
  connect_bd_net -net parameter_load_2_0_download_RC [get_bd_pins DCbus_dynamic_0/download_RC] [get_bd_pins parameter_load_2_0/download_RC]
  connect_bd_net -net parameter_load_2_0_gain_current_grid [get_bd_pins gain_offset_truncation_1/gain_current_grid] [get_bd_pins parameter_load_2_0/gain_current_grid]
  connect_bd_net -net parameter_load_2_0_gain_current_pmsm [get_bd_pins gain_offset_truncation_1/gain_current_pmsm] [get_bd_pins parameter_load_2_0/gain_current_pmsm]
  connect_bd_net -net parameter_load_2_0_gain_dc_bus [get_bd_pins gain_offset_truncation_1/gain_dc_bus] [get_bd_pins parameter_load_2_0/gain_dc_bus]
  connect_bd_net -net parameter_load_2_0_gain_voltage_grid [get_bd_pins gain_offset_truncation_1/gain_voltage_grid] [get_bd_pins parameter_load_2_0/gain_voltage_grid]
  connect_bd_net -net parameter_load_2_0_gain_voltage_pmsm [get_bd_pins gain_offset_truncation_1/gain_voltage_pmsm] [get_bd_pins parameter_load_2_0/gain_voltage_pmsm]
  connect_bd_net -net parameter_load_2_0_inv_R_eq [get_bd_pins DCbus_dynamic_0/inv_R_eq] [get_bd_pins parameter_load_2_0/inv_R_eq]
  connect_bd_net -net parameter_load_2_0_ma [get_bd_pins gen_referencias_0/ma] [get_bd_pins parameter_load_2_0/ma]
  connect_bd_net -net parameter_load_2_0_mode_L_LCL [get_bd_pins gain_offset_truncation_1/mode_L_LCL] [get_bd_pins lcl_filter_0/mode_L_LCL] [get_bd_pins parameter_load_2_0/mode_L_LCL]
  connect_bd_net -net parameter_load_2_0_rL1 [get_bd_pins lcl_filter_0/rL1] [get_bd_pins parameter_load_2_0/rL1]
  connect_bd_net -net parameter_load_2_0_rL2 [get_bd_pins lcl_filter_0/rL2] [get_bd_pins parameter_load_2_0/rL2]
  connect_bd_net -net parameter_load_2_0_sp12 [get_bd_pins parameter_load_2_0/Rs] [get_bd_pins pmsm_0/Rs_V]
  connect_bd_net -net pmsm_0_Fem_a_r_V [get_bd_pins pmsm_0/Fem_a_r_V] [get_bd_pins truncate_bits_0/in_4_AP_21_13]
  connect_bd_net -net pmsm_0_Fem_b_r_V [get_bd_pins pmsm_0/Fem_b_r_V] [get_bd_pins truncate_bits_0/in_5_AP_21_13]
  connect_bd_net -net pmsm_0_Fem_c_r_V [get_bd_pins pmsm_0/Fem_c_r_V] [get_bd_pins truncate_bits_0/in_6_AP_21_13]
  connect_bd_net -net pmsm_0_Is_a_V [get_bd_pins bridge3ph_0/Ia_V] [get_bd_pins pmsm_0/Is_a_V] [get_bd_pins truncate_bits_0/in_1_AP_21_13]
  connect_bd_net -net pmsm_0_Is_b_V [get_bd_pins bridge3ph_0/Ib_V] [get_bd_pins pmsm_0/Is_b_V] [get_bd_pins truncate_bits_0/in_2_AP_21_13]
  connect_bd_net -net pmsm_0_Is_c_V [get_bd_pins bridge3ph_0/Ic_V] [get_bd_pins pmsm_0/Is_c_V] [get_bd_pins truncate_bits_0/in_3_AP_21_13]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins AD_5293_v2_0/clk] [get_bd_pins DCbus_dynamic_0/ap_clk] [get_bd_pins De_Multiplexer_8b_0/CLK] [get_bd_pins Digital_Outputs_0/s00_axi_aclk] [get_bd_pins IGBT_input_selector_0/CLK] [get_bd_pins IGBT_input_selector_1/CLK] [get_bd_pins NOT_8_0/CLK] [get_bd_pins NV_io_controller_0/s00_axi_aclk] [get_bd_pins NV_multiplier_0/clk] [get_bd_pins NV_parameter_load_0/s00_axi_aclk] [get_bd_pins TCA9538_driver_0/CLK] [get_bd_pins TCA9538_driver_input_0/CLK] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins bit_order_adjust_tca9538_1/CLK] [get_bd_pins gain_offset_truncation_1/ap_clk] [get_bd_pins gen_referencias_0/clk] [get_bd_pins gen_referencias_1/clk] [get_bd_pins grid_0/ap_clk] [get_bd_pins grid_bridge3ph_0/ap_clk] [get_bd_pins lcl_filter_0/ap_clk] [get_bd_pins parameter_load_2_0/s00_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins ps7_0_axi_periph/ACLK] [get_bd_pins ps7_0_axi_periph/M00_ACLK] [get_bd_pins ps7_0_axi_periph/M01_ACLK] [get_bd_pins ps7_0_axi_periph/M02_ACLK] [get_bd_pins ps7_0_axi_periph/M03_ACLK] [get_bd_pins ps7_0_axi_periph/M04_ACLK] [get_bd_pins ps7_0_axi_periph/S00_ACLK] [get_bd_pins rst_ps7_0_100M/slowest_sync_clk] [get_bd_pins serial_interrupt_0/CLK] [get_bd_pins start_GRID_0/CLK] [get_bd_pins start_peripheral_0/CLK] [get_bd_pins system_ila_0/clk]
  connect_bd_net -net processing_system7_0_FCLK_CLK2 [get_bd_pins AD1RefComp_0/CLK] [get_bd_pins DAC_121s101_0/clk] [get_bd_pins bridge3ph_0/ap_clk] [get_bd_pins float_conversor_0/ap_clk] [get_bd_pins pmsm_0/ap_clk] [get_bd_pins processing_system7_0/FCLK_CLK1] [get_bd_pins rst_ps7_0_50M/slowest_sync_clk] [get_bd_pins start_PMSM_0/CLK] [get_bd_pins truncate_bits_0/CLK]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_ps7_0_100M/ext_reset_in] [get_bd_pins rst_ps7_0_50M/ext_reset_in]
  connect_bd_net -net rst_ps7_0_100M_interconnect_aresetn [get_bd_pins ps7_0_axi_periph/ARESETN] [get_bd_pins rst_ps7_0_100M/interconnect_aresetn]
  connect_bd_net -net rst_ps7_0_100M_peripheral_aresetn [get_bd_pins AD_5293_v2_0/RST] [get_bd_pins DCbus_dynamic_0/ap_rst_n] [get_bd_pins De_Multiplexer_8b_0/RST] [get_bd_pins Digital_Outputs_0/s00_axi_aresetn] [get_bd_pins IGBT_input_selector_0/RST] [get_bd_pins IGBT_input_selector_1/RST] [get_bd_pins NOT_8_0/RST] [get_bd_pins NV_io_controller_0/s00_axi_aresetn] [get_bd_pins NV_multiplier_0/reset] [get_bd_pins NV_parameter_load_0/s00_axi_aresetn] [get_bd_pins TCA9538_driver_0/RST] [get_bd_pins TCA9538_driver_input_0/RST] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins bit_order_adjust_tca9538_1/RST] [get_bd_pins gain_offset_truncation_1/ap_rst_n] [get_bd_pins gen_referencias_0/reset] [get_bd_pins gen_referencias_1/reset] [get_bd_pins grid_0/ap_rst_n] [get_bd_pins grid_bridge3ph_0/ap_rst_n] [get_bd_pins lcl_filter_0/ap_rst_n] [get_bd_pins parameter_load_2_0/s00_axi_aresetn] [get_bd_pins ps7_0_axi_periph/M00_ARESETN] [get_bd_pins ps7_0_axi_periph/M01_ARESETN] [get_bd_pins ps7_0_axi_periph/M02_ARESETN] [get_bd_pins ps7_0_axi_periph/M03_ARESETN] [get_bd_pins ps7_0_axi_periph/M04_ARESETN] [get_bd_pins ps7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_ps7_0_100M/peripheral_aresetn] [get_bd_pins serial_interrupt_0/RST] [get_bd_pins start_GRID_0/RST] [get_bd_pins start_peripheral_0/RST]
  connect_bd_net -net rst_ps7_0_50M_peripheral_aresetn [get_bd_pins AD1RefComp_0/RST] [get_bd_pins DAC_121s101_0/RST] [get_bd_pins bridge3ph_0/ap_rst_n] [get_bd_pins float_conversor_0/ap_rst_n] [get_bd_pins pmsm_0/ap_rst_n] [get_bd_pins rst_ps7_0_50M/peripheral_aresetn] [get_bd_pins start_PMSM_0/RST] [get_bd_pins truncate_bits_0/RST]
  connect_bd_net -net serial_interrupt_0_Console_1s_interrupt [get_bd_pins axi_gpio_0/gpio_io_i] [get_bd_pins serial_interrupt_0/Console_1s_interrupt]
  connect_bd_net -net start_peripheral_0_Start_ADC [get_bd_pins AD1RefComp_0/START] [get_bd_pins start_peripheral_0/Start_ADC]
  connect_bd_net -net start_peripheral_0_Start_inp_expa [get_bd_pins TCA9538_driver_input_0/start_in] [get_bd_pins start_peripheral_0/Start_inp_expa]
  connect_bd_net -net start_peripheral_0_Start_out_expa [get_bd_pins TCA9538_driver_0/start_in] [get_bd_pins start_peripheral_0/Start_out_expa]
  connect_bd_net -net truncate_bits_0_out_1_AP_21_13 [get_bd_pins float_conversor_0/in_1] [get_bd_pins truncate_bits_0/out_1_AP_21_13]
  connect_bd_net -net truncate_bits_0_out_2_AP_21_13 [get_bd_pins float_conversor_0/in_2] [get_bd_pins truncate_bits_0/out_2_AP_21_13]
  connect_bd_net -net truncate_bits_0_out_3_AP_21_13 [get_bd_pins float_conversor_0/in_3] [get_bd_pins truncate_bits_0/out_3_AP_21_13]
  connect_bd_net -net truncate_bits_0_out_4_AP_21_13 [get_bd_pins float_conversor_0/in_4] [get_bd_pins truncate_bits_0/out_4_AP_21_13]
  connect_bd_net -net truncate_bits_0_out_5_AP_21_13 [get_bd_pins float_conversor_0/in_5] [get_bd_pins truncate_bits_0/out_5_AP_21_13]
  connect_bd_net -net truncate_bits_0_out_6_AP_21_13 [get_bd_pins float_conversor_0/in_6] [get_bd_pins truncate_bits_0/out_6_AP_21_13]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins lcl_filter_0/CB1_K1_K3_V] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconcat_1_dout [get_bd_pins gain_offset_truncation_1/CB1_K1_K3_V] [get_bd_pins xlconcat_0/In0] [get_bd_pins xlconcat_1/dout]
  connect_bd_net -net xlconcat_2_dout [get_bd_pins bit_order_adjust_tca9538_1/u10_data_in] [get_bd_pins xlconcat_2/dout]
  connect_bd_net -net xlconcat_3_dout [get_bd_pins bit_order_adjust_tca9538_1/u12_data_in] [get_bd_pins xlconcat_3/dout]
  connect_bd_net -net xlconcat_4_dout [get_bd_pins bit_order_adjust_tca9538_1/u14_data_in] [get_bd_pins xlconcat_4/dout]
  connect_bd_net -net xlconstant_11_dout [get_bd_pins TCA9538_driver_input_0/address_in] [get_bd_pins xlconstant_11/dout]
  connect_bd_net -net xlconstant_17_dout [get_bd_pins TCA9538_driver_0/address_2_in] [get_bd_pins xlconstant_17/dout]
  connect_bd_net -net xlconstant_19_dout [get_bd_pins xlconcat_0/In1] [get_bd_pins xlconstant_19/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins TCA9538_driver_0/address_1_in] [get_bd_pins xlconstant_1/dout]
  connect_bd_net -net xlconstant_21_dout [get_bd_pins TCA9538_driver_0/address_3_in] [get_bd_pins xlconstant_21/dout]
  connect_bd_net -net xlconstant_22_dout [get_bd_pins DAC_121s101_0/DATA17] [get_bd_pins xlconstant_22/dout]
  connect_bd_net -net xlconstant_4_dout [get_bd_pins pmsm_0/SG1] [get_bd_pins xlconstant_4/dout]
  connect_bd_net -net xlconstant_6_dout [get_bd_pins NV_io_controller_0/sp5] [get_bd_pins NV_io_controller_0/sp6] [get_bd_pins NV_io_controller_0/sp7] [get_bd_pins NV_io_controller_0/sp8] [get_bd_pins xlconstant_6/dout]

  # Create address segments
  create_bd_addr_seg -range 0x00010000 -offset 0x43C30000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs Digital_Outputs_0/S00_AXI/S00_AXI_reg] SEG_Digital_Outputs_0_S00_AXI_reg
  create_bd_addr_seg -range 0x00010000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs NV_io_controller_0/S00_AXI/S00_AXI_reg] SEG_NV_io_controller_0_S00_AXI_reg
  create_bd_addr_seg -range 0x00010000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs NV_parameter_load_0/S00_AXI/S00_AXI_reg] SEG_NV_parameter_load_0_S00_AXI_reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x43C20000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs parameter_load_2_0/S00_AXI/S00_AXI_reg] SEG_parameter_load_2_0_S00_AXI_reg


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
  close_bd_design $design_name 
}
# End of cr_bd_NV_project()
cr_bd_NV_project ""
set_property GENERATE_SYNTH_CHECKPOINT "0" [get_files NV_project.bd ] 

# Create 'synth_1' run (if not found)
if {[string equal [get_runs -quiet synth_1] ""]} {
    create_run -name synth_1 -part xc7z020clg400-1 -flow {Vivado Synthesis 2017} -strategy "Vivado Synthesis Defaults" -report_strategy {No Reports} -constrset constrs_1
} else {
  set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2017" [get_runs synth_1]
}
set obj [get_runs synth_1]
set_property set_report_strategy_name 1 $obj
set_property report_strategy {Vivado Synthesis Default Reports} $obj
set_property set_report_strategy_name 0 $obj
# Create 'synth_1_synth_report_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs synth_1] synth_1_synth_report_utilization_0] "" ] } {
  create_report_config -report_name synth_1_synth_report_utilization_0 -report_type report_utilization:1.0 -steps synth_design -runs synth_1
}
set obj [get_report_configs -of_objects [get_runs synth_1] synth_1_synth_report_utilization_0]
if { $obj != "" } {

}
set obj [get_runs synth_1]
set_property -name "strategy" -value "Vivado Synthesis Defaults" -objects $obj

# set the current synth run
current_run -synthesis [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs -quiet impl_1] ""]} {
    create_run -name impl_1 -part xc7z020clg400-1 -flow {Vivado Implementation 2017} -strategy "Vivado Implementation Defaults" -report_strategy {No Reports} -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2017" [get_runs impl_1]
}
set obj [get_runs impl_1]
set_property set_report_strategy_name 1 $obj
set_property report_strategy {Vivado Implementation Default Reports} $obj
set_property set_report_strategy_name 0 $obj
# Create 'impl_1_init_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_init_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_init_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps init_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_init_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_opt_report_drc_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_drc_0] "" ] } {
  create_report_config -report_name impl_1_opt_report_drc_0 -report_type report_drc:1.0 -steps opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_drc_0]
if { $obj != "" } {

}
# Create 'impl_1_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_power_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_power_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_power_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps power_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_power_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_place_report_io_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_io_0] "" ] } {
  create_report_config -report_name impl_1_place_report_io_0 -report_type report_io:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_io_0]
if { $obj != "" } {

}
# Create 'impl_1_place_report_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_utilization_0] "" ] } {
  create_report_config -report_name impl_1_place_report_utilization_0 -report_type report_utilization:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_utilization_0]
if { $obj != "" } {

}
# Create 'impl_1_place_report_control_sets_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_control_sets_0] "" ] } {
  create_report_config -report_name impl_1_place_report_control_sets_0 -report_type report_control_sets:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_control_sets_0]
if { $obj != "" } {

}
# Create 'impl_1_place_report_incremental_reuse_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_0] "" ] } {
  create_report_config -report_name impl_1_place_report_incremental_reuse_0 -report_type report_incremental_reuse:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_place_report_incremental_reuse_1' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_1] "" ] } {
  create_report_config -report_name impl_1_place_report_incremental_reuse_1 -report_type report_incremental_reuse:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_1]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_place_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_place_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_post_place_power_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_place_power_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_post_place_power_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps post_place_power_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_place_power_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_phys_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_phys_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_phys_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps phys_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_phys_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_route_report_drc_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_drc_0] "" ] } {
  create_report_config -report_name impl_1_route_report_drc_0 -report_type report_drc:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_drc_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_methodology_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_methodology_0] "" ] } {
  create_report_config -report_name impl_1_route_report_methodology_0 -report_type report_methodology:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_methodology_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_power_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_power_0] "" ] } {
  create_report_config -report_name impl_1_route_report_power_0 -report_type report_power:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_power_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_route_status_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_route_status_0] "" ] } {
  create_report_config -report_name impl_1_route_report_route_status_0 -report_type report_route_status:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_route_status_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_route_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_timing_summary_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_incremental_reuse_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_incremental_reuse_0] "" ] } {
  create_report_config -report_name impl_1_route_report_incremental_reuse_0 -report_type report_incremental_reuse:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_incremental_reuse_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_clock_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_clock_utilization_0] "" ] } {
  create_report_config -report_name impl_1_route_report_clock_utilization_0 -report_type report_clock_utilization:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_clock_utilization_0]
if { $obj != "" } {

}
# Create 'impl_1_post_route_phys_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_post_route_phys_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps post_route_phys_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_timing_summary_0]
if { $obj != "" } {

}
set obj [get_runs impl_1]
set_property -name "strategy" -value "Vivado Implementation Defaults" -objects $obj
set_property -name "steps.opt_design.is_enabled" -value "0" -objects $obj
set_property -name "steps.write_bitstream.args.readback_file" -value "0" -objects $obj
set_property -name "steps.write_bitstream.args.verbose" -value "0" -objects $obj

# Create 'impl_2' run (if not found)
if {[string equal [get_runs -quiet impl_2] ""]} {
    create_run -name impl_2 -part xc7z020clg400-1 -flow {Vivado Implementation 2017} -strategy "Vivado Implementation Defaults" -report_strategy {No Reports} -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_2]
  set_property flow "Vivado Implementation 2017" [get_runs impl_2]
}
set obj [get_runs impl_2]
set_property set_report_strategy_name 1 $obj
set_property report_strategy {Vivado Implementation Default Reports} $obj
set_property set_report_strategy_name 0 $obj
# Create 'impl_2_init_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_init_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_2_init_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps init_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_init_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_2_opt_report_drc_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_opt_report_drc_0] "" ] } {
  create_report_config -report_name impl_2_opt_report_drc_0 -report_type report_drc:1.0 -steps opt_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_opt_report_drc_0]
if { $obj != "" } {

}
# Create 'impl_2_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_2_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps opt_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_2_power_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_power_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_2_power_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps power_opt_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_power_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_2_place_report_io_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_place_report_io_0] "" ] } {
  create_report_config -report_name impl_2_place_report_io_0 -report_type report_io:1.0 -steps place_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_place_report_io_0]
if { $obj != "" } {

}
# Create 'impl_2_place_report_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_place_report_utilization_0] "" ] } {
  create_report_config -report_name impl_2_place_report_utilization_0 -report_type report_utilization:1.0 -steps place_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_place_report_utilization_0]
if { $obj != "" } {

}
# Create 'impl_2_place_report_control_sets_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_place_report_control_sets_0] "" ] } {
  create_report_config -report_name impl_2_place_report_control_sets_0 -report_type report_control_sets:1.0 -steps place_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_place_report_control_sets_0]
if { $obj != "" } {

}
# Create 'impl_2_place_report_incremental_reuse_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_place_report_incremental_reuse_0] "" ] } {
  create_report_config -report_name impl_2_place_report_incremental_reuse_0 -report_type report_incremental_reuse:1.0 -steps place_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_place_report_incremental_reuse_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_2_place_report_incremental_reuse_1' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_place_report_incremental_reuse_1] "" ] } {
  create_report_config -report_name impl_2_place_report_incremental_reuse_1 -report_type report_incremental_reuse:1.0 -steps place_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_place_report_incremental_reuse_1]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_2_place_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_place_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_2_place_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps place_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_place_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_2_post_place_power_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_post_place_power_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_2_post_place_power_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps post_place_power_opt_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_post_place_power_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_2_phys_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_phys_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_2_phys_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps phys_opt_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_phys_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_2_route_report_drc_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_route_report_drc_0] "" ] } {
  create_report_config -report_name impl_2_route_report_drc_0 -report_type report_drc:1.0 -steps route_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_route_report_drc_0]
if { $obj != "" } {

}
# Create 'impl_2_route_report_methodology_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_route_report_methodology_0] "" ] } {
  create_report_config -report_name impl_2_route_report_methodology_0 -report_type report_methodology:1.0 -steps route_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_route_report_methodology_0]
if { $obj != "" } {

}
# Create 'impl_2_route_report_power_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_route_report_power_0] "" ] } {
  create_report_config -report_name impl_2_route_report_power_0 -report_type report_power:1.0 -steps route_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_route_report_power_0]
if { $obj != "" } {

}
# Create 'impl_2_route_report_route_status_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_route_report_route_status_0] "" ] } {
  create_report_config -report_name impl_2_route_report_route_status_0 -report_type report_route_status:1.0 -steps route_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_route_report_route_status_0]
if { $obj != "" } {

}
# Create 'impl_2_route_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_route_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_2_route_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps route_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_route_report_timing_summary_0]
if { $obj != "" } {

}
# Create 'impl_2_route_report_incremental_reuse_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_route_report_incremental_reuse_0] "" ] } {
  create_report_config -report_name impl_2_route_report_incremental_reuse_0 -report_type report_incremental_reuse:1.0 -steps route_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_route_report_incremental_reuse_0]
if { $obj != "" } {

}
# Create 'impl_2_route_report_clock_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_route_report_clock_utilization_0] "" ] } {
  create_report_config -report_name impl_2_route_report_clock_utilization_0 -report_type report_clock_utilization:1.0 -steps route_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_route_report_clock_utilization_0]
if { $obj != "" } {

}
# Create 'impl_2_post_route_phys_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_2] impl_2_post_route_phys_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_2_post_route_phys_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps post_route_phys_opt_design -runs impl_2
}
set obj [get_report_configs -of_objects [get_runs impl_2] impl_2_post_route_phys_opt_report_timing_summary_0]
if { $obj != "" } {

}
set obj [get_runs impl_2]
set_property -name "strategy" -value "Vivado Implementation Defaults" -objects $obj
set_property -name "steps.opt_design.is_enabled" -value "0" -objects $obj
set_property -name "steps.write_bitstream.args.readback_file" -value "0" -objects $obj
set_property -name "steps.write_bitstream.args.verbose" -value "0" -objects $obj

# set the current impl run
current_run -implementation [get_runs impl_2]

puts "INFO: Project created:$project_name"


#*****************************************************************************************
# additional commands
#*****************************************************************************************

# openning IP block design, regenerating it and validating it
open_bd_design "[file normalize "$origin_dir/NV_HIL_prj/NV_HIL_prj.srcs/sources_1/bd/NV_project/NV_project.bd"]"
regenerate_bd_layout
validate_bd_design

# launch bitstream generation
update_compile_order -fileset sources_1
save_bd_design
launch_runs impl_2 -to_step write_bitstream -jobs 8

#open implementation (run_2), export bitstream and launch sdk
#open_run impl_2 #if user wants the implemented design to be opened, this line should be uncommented 
file mkdir "[file normalize "$origin_dir/NV_HIL_prj/NV_HIL_prj.sdk"]"
file copy -force "[file normalize "$origin_dir/NV_HIL_prj/NV_HIL_prj.runs/impl_2/NV_project_wrapper.sysdef"]" "[file normalize "$origin_dir/NV_HIL_prj/NV_HIL_prj.sdk/NV_project_wrapper.hdf"]"
launch_sdk -workspace "[file normalize "$origin_dir/NV_HIL_prj/NV_HIL_prj.sdk"]" -hwspec "[file normalize "$origin_dir/NV_HIL_prj/NV_HIL_prj.sdk/NV_project_wrapper.hdf"]"







