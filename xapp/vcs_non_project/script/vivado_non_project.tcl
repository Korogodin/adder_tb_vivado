#*******************************************************************************
#
#  File name : 
# 
#  Description : This is an example script for using Vivado in batch flow. It can
#                also generate a batch file to create an initial repository using
#                git.
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
#  Copyright © 2012 Xilinx, Inc.
#  All rights reserved 
# 
#*****************************************************************************

#Usage:
#    Example Command lines:
#    Implement the design in non-project flow
#    vivado -mode batch -source ../script/vivado_non_project.tcl -notrace -tclargs -cmd run -ifn ../script/file_list.txt -top spectrum_top -part xc7k325tffg900-2
#
#    Generate a batch file to check files into a Git repository
#    vivado -mode batch -source ../script/vivado_non_project.tcl -notrace -tclargs -cmd vcs -ifn file_list.txt -top spectrum_top -part xc7k325tffg900-2 -out git_batch.bat
#End of Usage

set VivadoNonProjectVersion 0.1
set VivadoNonProjectDebugLevel 100

################################################################################
# 
################################################################################
proc DebugMsg {msg {verbosity 0}} {
    global VivadoNonProjectDebugLevel

    if {$VivadoNonProjectDebugLevel >= $verbosity} {
	puts $msg
    }
}

################################################################################
# 
################################################################################
proc PrintMsg {msg {msg_type 0}} {
    if {$msg_type == 0} {
	puts "INFO: $msg"
    } elseif {$msg_type == 1} {
	puts "WARNING: $msg"
    } elseif {$msg_type == 2} {
	puts "ERROR: $msg"
    }
}

set CmdOpt "run"
set IfnOpt ""
set TopOpt ""
set PartOpt ""
set OutOpt ""

set cmd_opt_idx [lsearch $argv "-cmd"]
if {$cmd_opt_idx != -1} {
    set CmdOpt [lindex $argv [expr {$cmd_opt_idx+1}]]
}

set ifn_opt_idx [lsearch $argv "-ifn"]
if {$ifn_opt_idx != -1} {
    set IfnOpt [lindex $argv [expr {$ifn_opt_idx+1}]]
}

set top_opt_idx [lsearch $argv "-top"]
if {$top_opt_idx != -1} {
    set TopOpt [lindex $argv [expr {$top_opt_idx+1}]]
}

set part_opt_idx [lsearch $argv "-part"]
if {$part_opt_idx != -1} {
    set PartOpt [lindex $argv [expr {$part_opt_idx+1}]]
}

if {$CmdOpt == "vcs"} {
    #check output file option if cmd is vcs
    set out_opt_idx [lsearch $argv "-out"]
    if {$out_opt_idx != -1} {
        set OutOpt [lindex $argv [expr {$out_opt_idx+1}]]
    }

    if {$OutOpt == ""} {
        PrintMsg "Output file name is required when cmd is vcs." 2
        return 1
    }
}

################################################################################
################################################################################
DebugMsg "    IfnOpt=$IfnOpt TopOpt=$TopOpt PartOpt=$PartOpt" 20

if {$IfnOpt == ""} {
    PrintMsg "Input file must be specified" 2
    return 1
}

if {$TopOpt == ""} {
    PrintMsg "Top module must be specified" 2
    return 1
}

if {$PartOpt == ""} {
    PrintMsg "Device part number must be specified" 2
    return 1
}

if {![file exists $IfnOpt]} {
    PrintMsg "Input file list $IfnOpt does not exist." 2
    return 1    
}

set FHIFN [open $IfnOpt r]
set inFileError 0
set listSysVFiles [list]
set listVerilogFiles [list]
set listVhdlFiles [list]
set listIpFiles [list]
set listDspFiles [list]
set listConstrFiles [list]
set listMiscFiles [list]

while {[gets $FHIFN cur_line] >= 0} {
    # removing leading and trailing white spaces
    set cur_line [string trim $cur_line]
    if {$cur_line == ""} {
        #skip empty line
        continue
    }

    set first_char [string range $cur_line 0 0]

    # "#" is comment
    if {$first_char == "#"} {
        # do nothing
        continue
    }

    set tmp_list [split $cur_line " "]
    set src_fn [lindex $tmp_list 0]
    set src_type [lindex $tmp_list 1]

    if {![file exists $src_fn]} {
        PrintMsg "Source $src_fn does not exist." 2
        set inFileError 1
        continue
    }

    set src_type [string tolower $src_type]
    if {$src_type == ""} {
        #no source type specified. use file extension instead
        set f_ext [file extension $src_fn]
        if {$f_ext == ".v"} {
            set src_type "verilog"
        } elseif {$f_ext == ".vhd"} {
            set src_type "vhdl"
        } elseif {$f_ext == ".sv"} {
            set src_type "systemverilog"
        } elseif {$f_ext == ".xci"} {
            set src_type "ip"
        } elseif {$f_ext == ".xdc"} {
            set src_type "constraint"
        } elseif {$f_ext == ".mdl" || $f_ext == ".slx"} {
            set src_type "dsp"
        } elseif {$f_ext == ".tcl"} {
            set src_type "script"
        } else {
            PrintMsg "Unsupported file extension $f_ext for $src_fn" 1
            set src_type "misc"
        }
    }

    if {$src_type == "verilog"} {
        lappend listVerilogFiles $src_fn
    } elseif {$src_type == "vhdl"} {
        lappend listVhdlFiles $src_fn
    } elseif {$src_type == "systemverilog"} {
        lappend listSysVFiles $src_fn
    } elseif {$src_type == "ip"} {
        lappend listIpFiles $src_fn
    } elseif {$src_type == "constraint"} {
        lappend listConstrFiles $src_fn
    } elseif {$src_type == "dsp"} {
        lappend listDspFiles $src_fn
    } elseif {$src_type == "script"} {
        lappend listScrFiles $src_fn
    } else {
        PrintMsg "Unsupported source type $src_type. $src_fn will be version controlled." 1
        lappend listMiscFiles $src_fn
    }
}
close $FHIFN

if {$CmdOpt == "run"} {
    if {[llength $listVerilogFiles]} {
        read_verilog $listVerilogFiles
    }
    
    if {[llength $listSysVFiles]} {
        read_verilog -sv $listSysVFiles
    }
    
    if {[llength $listVhdlFiles]} {
        read_vhdl $listVhdlFiles
    }
    
    foreach f_xdc $listConstrFiles {
        read_xdc $f_xdc
    }
    
    foreach f_ip $listIpFiles {
        add_files $f_ip
    
    }
    
    foreach f_dsp $listDspFiles {
        add_files $f_dsp
        generate_target all [get_files $f_dsp]
    }
    
    #synthesize design
    synth_design -top $TopOpt -part $PartOpt
    write_checkpoint -force $TopOpt\_syn.dcp

    #write out debug probe file
    write_debug_probes -force $TopOpt\.ltx

    #run implementation
    opt_design
    place_design
    route_design
    write_checkpoint -force $TopOpt\_routed.dcp

    #report timing and write out bitstream
    report_timing_summary -file $TopOpt\_route_timing.rpt
    write_bitstream -force $TopOpt\.bit
}

if {$CmdOpt == "vcs"} {

    PrintMsg "Generating batch file for checking design files into repository"
    set OUT_FILE [open $OutOpt "w+"]	

    foreach fn $listVerilogFiles {
        puts $OUT_FILE "git add $fn"
    }
    
    foreach fn $listSysVFiles {
        puts $OUT_FILE "git add $fn"
    }
    
    foreach fn $listVhdlFiles {
        puts $OUT_FILE "git add $fn"
    }
    
    foreach fn $listConstrFiles {
        puts $OUT_FILE "git add $fn"
    }
    
    foreach fn $listIpFiles {
        #puts $OUT_FILE "git add $fn"
        puts $OUT_FILE "echo IP $fn is recommended to version controlled in managed IP location."
    }
    
    foreach fn $listDspFiles {
        puts $OUT_FILE "git add $fn"
    }

    foreach fn $listScrFiles {
        puts $OUT_FILE "git add $fn"
    }

    foreach fn $listMiscFiles {
        puts $OUT_FILE "git add $fn"
    }

    #commit files and push them to the shared repository
    puts $OUT_FILE "git commit -m \"initial check\""
    puts $OUT_FILE "git push"
    
    close $OUT_FILE

    PrintMsg "Batch file $OutOpt generated"
}
