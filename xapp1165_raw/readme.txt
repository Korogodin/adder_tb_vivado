*************************************************************************
   ____  ____ 
  /   /\/   / 
 /___/  \  /   
 \   \   \/    © Copyright 2013 Xilinx, Inc. All rights reserved.
  \   \        This file contains confidential and proprietary 
  /   /        information of Xilinx, Inc. and is protected under U.S. 
 /___/   /\    and international copyright and other intellectual 
 \   \  /  \   property laws. 
  \___\/\___\ 
 
*************************************************************************

Vendor: Xilinx 
Current readme.txt Version: 1.0
Date Last Modified:  05AUG2013
Date Created: 05AUG2013

Associated Filename: xapp1165.zip
Associated Document: XAPP1165, Using Vivado Design Suite with Version Control Systems

Supported Device(s): Kintex-7 FPGAs
   
*************************************************************************

Disclaimer: 

      This disclaimer is not a license and does not grant any rights to 
      the materials distributed herewith. Except as otherwise provided in 
      a valid license issued to you by Xilinx, and to the maximum extent 
      permitted by applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE 
      "AS IS" AND WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL 
      WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, 
      INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, 
      NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and 
      (2) Xilinx shall not be liable (whether in contract or tort, 
      including negligence, or under any other theory of liability) for 
      any loss or damage of any kind or nature related to, arising under 
      or in connection with these materials, including for any direct, or 
      any indirect, special, incidental, or consequential loss or damage 
      (including loss of data, profits, goodwill, or any type of loss or 
      damage suffered as a result of any action brought by a third party) 
      even if such damage or loss was reasonably foreseeable or Xilinx 
      had been advised of the possibility of the same.

Critical Applications:

      Xilinx products are not designed or intended to be fail-safe, or 
      for use in any application requiring fail-safe performance, such as 
      life-support or safety devices or systems, Class III medical 
      devices, nuclear facilities, applications related to the deployment 
      of airbags, or any other applications that could lead to death, 
      personal injury, or severe property or environmental damage 
      (individually and collectively, "Critical Applications"). Customer 
      assumes the sole risk and liability of any use of Xilinx products 
      in Critical Applications, subject only to applicable laws and 
      regulations governing limitations on product liability.

THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS 
FILE AT ALL TIMES.

*************************************************************************

This readme file contains these sections:

1. REVISION HISTORY
2. OVERVIEW
3. SOFTWARE TOOLS AND SYSTEM REQUIREMENTS
4. DESIGN FILE HIERARCHY
5. INSTALLATION AND OPERATING INSTRUCTIONS
6. OTHER INFORMATION (OPTIONAL)
7. SUPPORT


1. REVISION HISTORY 

            Readme  
Date        Version      Revision Description
=========================================================================
05AUG2013   1.0          Initial Xilinx release.
=========================================================================



2. OVERVIEW

This readme describes how to use the files that come with XAPP1165

This is a reference design that follows Xilinx revision control recommendations
for IP management, design implementation in Non-Project and Project Flow.

vcs_ip_location subdirectory includes all IPs used in the example designs and
a Tcl script for scanning all IP files and creating a batch file to check them
into a Git repository

vcs_non_project subdirectory incldues the example design in Non-Project flow
and a Tcl script to implement the design as well as creating a batch file to
check in all design sources and scripts into a Git repository.

vcs_project subdirectory incldues the example design in Project flow
and Tcl scripts to recreate the project and create a batch file to
check in all design sources and scripts into a Git repository.

3. SOFTWARE TOOLS AND SYSTEM REQUIREMENTS

* Xilinx Vivado 2013.2 or higher

4. DESIGN FILE HIERARCHY

vcs_ip_location
|  vcs_ip_location subdirectory includes all IPs used in the example designs and
|  a Tcl script for scanning all IP files and creating a batch file to check them
|  into a Git repository
|
|-- git_manage_ip.tcl
|   script for scanning all IP files and creating a batch file to check them
|   into a Git repository
|-- coeffs
| `-- fir_p2_1db_s3_50db.coe
|-- dds_compiler_0
| |-- dds_compiler_0.vho
| |-- dds_compiler_0.xci
| `-- dds_compiler_0.xml
|-- fir_compiler_0
| |-- fir_compiler_0.vho
| |-- fir_compiler_0.xci
| `-- fir_compiler_0.xml
|-- ila_0
| |-- ila_0.xci
| `-- ila_0.xml
|-- vio_i256_o256
| |-- vio_i256_o256.xci
| `-- vio_i256_o256.xml
|-- xfft_0
|-- xfft_0.vho
|-- xfft_0.xci
`-- xfft_0.xml

vcs_non_project
|  vcs_non_project subdirectory incldues the example design in Non-Project flow
|  and a Tcl script to implement the design as well as creating a batch file to
|  check in all design sources and scripts into a Git repository.
|
|-- script
|    |-- file_list.txt
|    `-- vivado_non_project.tcl
|-- sim
|    `-- spectrum_top_tb.v
`-- src
    |-- constrs
    | |-- spectrum_top_physical.xdc
    | `-- spectrum_top_timing.xdc
    |-- verilog
    | |-- cplx_mult.v
    | `-- spectrum_top.v
    `-- vhdl
    `-- heartbeat_gen.vhd

vcs_project
|  vcs_project subdirectory incldues the example design in Project flow
|  and Tcl scripts to recreate the project and create a batch file to
|  check in all design sources and scripts into a Git repository.
|
|-- debug
|   `-- hw_ila_data_1.wcfg
|-- script
|   |-- file_list.txt
|   |-- git_project.tcl
|   `-- spectrum_vv_prj_flow.tcl
|-- sim
|   |-- spectrum_top_tb.v
|   `-- spectrum_top_tb.wcfg
|-- script
|   `-- spectrum_top_tb.wcfg
`-- src
    |-- constrs
    | |-- spectrum_top_physical.xdc
    | `-- spectrum_top_timing.xdc
    |-- verilog
    | `-- cplx_mult.v
    | `-- spectrum_top.v
    `-- vhdl
    `-- heartbeat_gen.vhd

5. INSTALLATION AND OPERATING INSTRUCTIONS 

1) Install the Xilinx Vivado 2013.2 or later tools.

vcs_ip_location
---------------
1) Open Vivado command prompt
2) Go to vcs_ip_location directory and run the command below to generate the
   batch git_batch.bat

   vivado -notrace -mode batch -source git_manage_ip.tcl

3) Open a git bash window and go to vcs_ip_location directory
4) Run git_batch.bat to check in all IP files

vcs_non_project
-----------------
1) Open Vivado command prompt
2) Go to vcs_no_project directory and create a directory "run"
3) Go to "run" directory and run the command below to implement the design

   vivado -mode batch -source ../script/vivado_non_project.tcl -notrace -tclargs -cmd run -ifn ../script/file_list.txt -top spectrum_top -part xc7k325tffg900-2

4) Go to "script" directory and run the command below to generate the batch 
   file git_batch.bat to check in all design files

   vivado -mode batch -source ../script/vivado_non_project.tcl -notrace -tclargs -cmd vcs -ifn file_list.txt -top spectrum_top -part xc7k325tffg900-2 -out git_batch.bat

5) Open a git bash window and go to vcs_non_project/script directory
4) Run git_batch.bat to check in all design files

vcs_project
-----------------
1) Open Vivado command prompt
2) Go to vcs_project directory
3) Run the command below to create the Vivado project for the design

   vivado -source script/spectrum_vv_prj_flow.tcl -notrace

4) Go to "script" directory and run the command below to generate the batch 
   file git_batch.bat to check in all design files

   vivado -mode batch -source git_project.tcl -notrace -tclargs -cmd vcs -ifn file_list.txt -out git_batch.bat

5) Open a git bash window and go to vcs_non_project/script directory
4) Run git_batch.bat to check in all design files


6. OTHER INFORMATION (OPTIONAL) 
1) Warnings
   None

2) Design Notes
   None

3) Fixes
   None

4) Known Issues
   None


7. SUPPORT

For technical support for this reference design, go to www.xilinx.com/support.  
