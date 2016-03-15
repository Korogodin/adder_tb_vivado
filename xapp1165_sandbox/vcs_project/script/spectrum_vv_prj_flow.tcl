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
create_project -force spectrum_vv ./spectrum_vv

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [get_projects spectrum_vv]
set_property "board" "xilinx.com:kintex7:kc705:1.0" $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Add files to 'sources_1' fileset
set obj [get_filesets sources_1]
set files [list \
 "../vcs_ip_location/coeffs/fir_p2_1db_s3_50db.coe"\
 "../vcs_ip_location/dds_compiler_0/dds_compiler_0.xci"\
 "../vcs_ip_location/fir_compiler_0/fir_compiler_0.xci"\
 "../vcs_ip_location/ila_0/ila_0.xci"\
 "../vcs_ip_location/vio_i256_o256/vio_i256_o256.xci"\
 "../vcs_ip_location/xfft_0/xfft_0.xci"\
 "./src/verilog/cplx_mult.v"\
 "./src/verilog/spectrum_top.v"\
 "./src/vhdl/heartbeat_gen.vhd"\
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for local files
set file "vhdl/heartbeat_gen.vhd"
set file_obj [get_files "*$file" -of_objects sources_1]
set_property "file_type" "VHDL" $file_obj


# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property "top" "spectrum_top" $obj

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Add files to 'constrs_1' fileset
set obj [get_filesets constrs_1]
set files [list \
 "./src/constrs/spectrum_top_physical.xdc"\
 "./src/constrs/spectrum_top_timing.xdc"\
]
add_files -norecurse -fileset $obj $files

# Set 'constrs_1' fileset file properties for remote files
# None

# Set 'constrs_1' fileset file properties for local files
set file "constrs/spectrum_top_physical.xdc"
set file_obj [get_files "*$file" -of_objects constrs_1]
set_property "file_type" "XDC" $file_obj

set file "constrs/spectrum_top_timing.xdc"
set file_obj [get_files "*$file" -of_objects constrs_1]
set_property "file_type" "XDC" $file_obj


# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]
set_property "target_constrs_file" "./src/constrs/spectrum_top_physical.xdc" $obj

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets sim_1] ""]} {
  create_fileset -simset sim_1
}

# Add files to 'sim_1' fileset
set obj [get_filesets sim_1]
set files [list \
 "./sim/spectrum_top_tb.v"\
 "./sim/spectrum_top_tb_behav.wcfg"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_1' fileset file properties for remote files

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property "top" "spectrum_top_tb" $obj
set_property "xsim.view" "./sim/spectrum_top_tb_behav.wcfg" $obj

# Create 'synth_1' run (if not found)
if {[string equal [get_runs synth_1] ""]} {
  create_run -name synth_1 -part xc7k325tffg900-2 -flow {Vivado Synthesis 2012} -strategy "Vivado Synthesis Defaults" -constrset constrs_1
}
set obj [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs impl_1] ""]} {
  create_run -name impl_1 -part xc7k325tffg900-2 -flow {Vivado Implementation 2012} -strategy "Vivado Implementation Defaults" -constrset constrs_1 -parent_run synth_1
}
set obj [get_runs impl_1]


puts "INFO: Project created:spectrum_vv"
