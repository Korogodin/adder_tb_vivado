git add ../src/verilog/cplx_mult.v
git add ../src/verilog/spectrum_top.v
git add ../sim/spectrum_top_tb.v
git add ../src/vhdl/heartbeat_gen.vhd
git add ../src/constrs/spectrum_top_timing.xdc
git add ../src/constrs/spectrum_top_physical.xdc
echo IP ../../vcs_ip_location/dds_compiler_0/dds_compiler_0.xci is recommended to version controlled in managed IP location.
echo IP ../../vcs_ip_location/fir_compiler_0/fir_compiler_0.xci is recommended to version controlled in managed IP location.
echo IP ../../vcs_ip_location/xfft_0/xfft_0.xci is recommended to version controlled in managed IP location.
echo IP ../../vcs_ip_location/vio_i256_o256/vio_i256_o256.xci is recommended to version controlled in managed IP location.
echo IP ../../vcs_ip_location/ila_0/ila_0.xci is recommended to version controlled in managed IP location.
git add ../script/vivado_non_project.tcl
git add ../debug/hw_ila_data_1.wcfg
git add ../script/file_list.txt
git commit -m "initial check"
git push
