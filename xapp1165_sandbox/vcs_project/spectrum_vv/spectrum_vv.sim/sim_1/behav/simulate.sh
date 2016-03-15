#!/bin/bash -f
xv_path="/opt/Xilinx/Vivado/2015.3"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim spectrum_top_behav -key {Behavioral:sim_1:Functional:spectrum_top} -tclbatch spectrum_top.tcl -log simulate.log
