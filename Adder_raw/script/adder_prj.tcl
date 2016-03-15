#*******************************************************************************
#
#  File name : 
# 
#  Description : This is an example script adapted from the project creation script
#                exported from Vivado write_project_tcl command. It recreates a 
#                a Vivado project, adds all sources and constraint files, sets up 
#                tool options, and creates synthesis implementation runs in Vivado
#                project flow. 
#
#  History :
#
#  Author(s) : Jim Wu
#
#  Disclaimer: LIMITED WARRANTY AND DISCLAMER. These designs are 
#              provided to you "as is". Xilinx and its licensors make and you 
#              receive no warranties or conditions, express, implied, 
#              statutory or otherwise, and Xilinx specifically disclaims any 
#              implied warranties of merchantability, non-infringement, or 
#              fitness for a particular purpose. Xilinx does not warrant that 
#              the functions contained in these designs will meet your 
#              requirements, or that the operation of these designs will be 
#              uninterrupted or error free, or that defects in the Designs 
#              will be corrected. Furthermore, Xilinx does not warrant or 
#              make any representations regarding use or the results of the 
#              use of the designs in terms of correctness, accuracy, 
#              reliability, or otherwise. 
#
#              LIMITATION OF LIABILITY. In no event will Xilinx or its 
#              licensors be liable for any loss of data, lost profits, cost 
#              or procurement of substitute goods or services, or for any 
#              special, incidental, consequential, or indirect damages 
#              arising from the use or operation of the designs or 
#              accompanying documentation, however caused and on any theory 
#              of liability. This limitation will apply even if Xilinx 
#              has been advised of the possibility of such damage. This 
#              limitation shall apply not-withstanding the failure of the 
#              essential purpose of any limited remedies herein. 
#
#  Copyright © 2013 Xilinx, Inc.
#  All rights reserved 
# 
#*****************************************************************************
#Usage:
#    Run the command below from root of design working directory
#
#    vivado -source script/spectrum_vv_prj_flow.tcl -notrace
#
#End of Usage

# Create project
create_project -force adder ./adder

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [get_projects adder]
set_property "board_part" "xilinx.com:zc702:part0:1.2" $obj
set_property "default_lib" "xil_defaultlib" $obj
set_property "sim.ip.auto_export_scripts" "1" $obj
set_property "simulator_language" "Mixed" $obj


# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 "./src/verilog/adder_top.v"\
 "./src/verilog/add.v"\
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for local files
# set file "vhdl/heartbeat_gen.vhd"
# set file_obj [get_files "*$file" -of_objects sources_1]
# set_property "file_type" "VHDL" $file_obj


# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property "top" "adder_top" $obj

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Add files to 'constrs_1' fileset
set obj [get_filesets constrs_1]
set files [list \
 "./src/constrs/adder_top_physical.xdc"\
 "./src/constrs/adder_top_timing.xdc"\
]
add_files -norecurse -fileset $obj $files

# Set 'constrs_1' fileset file properties for remote files
# None

# Set 'constrs_1' fileset file properties for local files
set file "constrs/adder_top_physical.xdc"
set file_obj [get_files "*$file" -of_objects constrs_1]
set_property "file_type" "XDC" $file_obj

set file "constrs/adder_top_timing.xdc"
set file_obj [get_files "*$file" -of_objects constrs_1]
set_property "file_type" "XDC" $file_obj


# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]
set_property "target_constrs_file" "./src/constrs/adder_top_physical.xdc" $obj

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Add files to 'sim_1' fileset
set obj [get_filesets sim_1]
set files [list \
 "./sim/add/add_tb.v"\
 "./sim/add/add_tb_behav.wcfg"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_1' fileset file properties for remote files
#set file ".sim/add/add_tb.v"
#set file [file normalize $file]
#set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
#set_property "used_in" "simulation" $file_obj
#set_property "used_in_implementation" "0" $file_obj
#set_property "used_in_synthesis" "0" $file_obj


# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property "top" "add_tb" $obj
# set_property "xsim.view" "./sim/add/add_tb_behav.wcfg" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj

# Create 'synth_1' run (if not found)
if {[string equal [get_runs -quiet synth_1] ""]} {
  create_run -name synth_1 -part xc7z020clg484-1 -flow {Vivado Synthesis 2015} -strategy "Vivado Synthesis Defaults" -constrset constrs_1
} else {
  set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2015" [get_runs synth_1]
}
set obj [get_runs synth_1]
set_property "needs_refresh" "1" $obj

# set the current synth run
current_run -synthesis [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs -quiet impl_1] ""]} {
  create_run -name impl_1 -part xc7z020clg484-1 -flow {Vivado Implementation 2015} -strategy "Vivado Implementation Defaults" -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2015" [get_runs impl_1]
}
set obj [get_runs impl_1]
set_property "steps.write_bitstream.args.readback_file" "0" $obj
set_property "steps.write_bitstream.args.verbose" "0" $obj

# set the current impl run
current_run -implementation [get_runs impl_1]

puts "INFO: Project created:adder"

