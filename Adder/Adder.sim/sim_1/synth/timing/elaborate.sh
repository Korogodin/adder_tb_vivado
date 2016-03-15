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
ExecStep $xv_path/bin/xelab -wto 709719058413425ba081fea3ea4216a8 -m64 --debug typical --relax --mt 8 --maxdelay -L xil_defaultlib -L simprims_ver -L secureip --snapshot adder_testbench_time_synth -transport_int_delays -pulse_r 0 -pulse_int_r 0 xil_defaultlib.adder_testbench xil_defaultlib.glbl -log elaborate.log
