#*******************************************************************************
#
#  File name : 
# 
#  Description : This is an example script to generate a batch file to add all IP
#                files in a managed IP location to a git repository.
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
#    In the managed IP location, run the command below to generate git_batch.bat
#    vivado -notrace -mode batch -source git_manage_ip.tcl

#get_ip_files is based on the get_ip_files.tcl attached to AR56634
#http://www.xilinx.com/support/answers/56634.html
package require cmdline
proc get_ip_files { args } {
    set options {
        {all       "Return all files for ipname"}
    }
    set usage ": get_ip_files \[options] ipname1 ipname2\nGet the files associated with a named IP, optionally filtering the list.\noptions:"
    array set params [::cmdline::getoptions args $options $usage]
    set ipNames {}
    #foreach arg $args {
    #  lappend ipNames $arg
    #}

    regsub "{" $args "" args
    regsub "}" $args "" args
    set ipNames [split $args]
    #puts [llength $ipNames]

    if { [llength $args] == 0 } {
        puts [::cmdline::usage $options $usage]
        return -code error "Please provide the IP for which you want to generate Tcl commands"
    }

    set found_files [ list ]

    foreach ipName $ipNames {
        set ip [get_ips $ipName]
        if { $ip == "" } {
            puts "ERROR: could not find IP that matches \"$ipName\""
            continue
        }

        # xci file
        set xci [ get_property ip_file $ip ]
        lappend found_files  $xci
        # propery based files
        foreach prop [ list_property $ip ] {
            set value [ get_property $prop $ip ]
            if { [ string match -nocase "*.coe" $value ] ||
                 [ string match -nocase "*.prj" $value ] ||
                 [ string match -nocase "*.mif" $value ] } {
                # if relative, normalize to the IP directory
                if { [ file pathtype $value ] eq "relative" } {
                    set value [ file normalize [file join [get_property ip_dir $ip] $value ] ]
                }
                lappend found_files $value
                puts "value $value"
            }
        }

        # set oocip [ get_filesets -quiet [get_property name $ip] ]
        foreach fs [ get_filesets ] {
            if { [ llength [ get_files -quiet -of_objects $fs $xci ] ] > 0 } {
                set oocip $fs
                break
            }
        }

        if { $oocip ne "" } {
            set target $oocip
        } else {
            set target [ get_files $xci ]
        }
        puts "target $target"

        # get ALL generated files
        if { $params(all) } {
            lappend found_files  "[ file rootname $xci ].xml"
            #foreach f [ get_files -all -filter NAME!~$xci -of_objects $target ] {
            #    lappend found_files [ get_property name $f ]
            #}
        }

        #if { $params(all) } {
        #  set dcp [ file rootname $xci ].dcp
        #  set stub [ file rootname $xci ]_stub.v
        #  if { [file exists $dcp ] } { lappend found_files $dcp }
        #  if { [file exists $stub ] } { lappend found_files $stub }
        #}

    }
    
    return $found_files
}

set RepoRoot [pwd]
#remove Windows drive letters if any
regsub {[a-zA-Z]:} $RepoRoot "" RepoRoot
#regsub "C:" $RepoRoot "" RepoRoot

puts $RepoRoot
set listIPDirs [glob -type d *]
set listIPXcis [list]
set listIPNames [list]
foreach ip_dir $listIPDirs {
    set ip_xci "$ip_dir/$ip_dir.xci"
    if {[file exists $ip_xci]} {
        puts "INFO: Found IP $ip_xci"
        lappend listIPXcis $ip_xci
        lappend listIPNames $ip_dir
    }
}

foreach ip_xci $listIPXcis {
    #read in IP in non-project flow
    read_ip $ip_xci
}

set OUT_FILE [open git_batch.bat "w+"]	
foreach ip_name $listIPNames {
    puts $ip_name
    set ip [get_ips $ip_name]
    set xci [get_property ip_file $ip ]
    reset_target all [get_files $xci]
    set listIPFiles [get_ip_files -all $ip_name]
    puts $listIPFiles
    foreach fn $listIPFiles {
        regsub {[a-zA-Z]:} $fn "" fn
        regsub $RepoRoot $fn "." fn_rel
        puts $OUT_FILE "git add $fn_rel"
    }
}

#commit files and push them to the shared repository
puts $OUT_FILE "git commit -m \"initial check\""
puts $OUT_FILE "git push"
close $OUT_FILE


