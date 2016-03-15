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
ExecStep $xv_path/bin/xsim adder_testbench_func_synth -key {Post-Synthesis:sim_1:Functional:adder_testbench} -tclbatch adder_testbench.tcl -log simulate.log
