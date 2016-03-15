# Bank  34 VCCO - VCC1V5_FPGA - IO_25_VRP_34 active high reset
set_property IOSTANDARD LVCMOS15 [get_ports sys_rst_i]
set_property PACKAGE_PIN AB7 [get_ports sys_rst_i]
# Bank  33 VCCO - VCC1V5_FPGA - IO_L12P_T1_MRCC_33
set_property IOSTANDARD LVDS [get_ports sys_clk_p_i]
set_property PACKAGE_PIN AD12 [get_ports sys_clk_p_i]
# Bank  33 VCCO - VCC1V5_FPGA - IO_L12N_T1_MRCC_33
set_property IOSTANDARD LVDS [get_ports sys_clk_n_i]
set_property PACKAGE_PIN AD11 [get_ports sys_clk_n_i]


#active high LED
# Bank  33 VCCO - VCC1V5_FPGA - IO_L2N_T0_33
set_property IOSTANDARD LVCMOS15 [get_ports {leds_o[0]}]
set_property PACKAGE_PIN AB8 [get_ports {leds_o[0]}]
# Bank  33 VCCO - VCC1V5_FPGA - IO_L2P_T0_33
set_property IOSTANDARD LVCMOS15 [get_ports {leds_o[1]}]
set_property PACKAGE_PIN AA8 [get_ports {leds_o[1]}]
# Bank  33 VCCO - VCC1V5_FPGA - IO_L3N_T0_DQS_33
set_property IOSTANDARD LVCMOS15 [get_ports {leds_o[2]}]
set_property PACKAGE_PIN AC9 [get_ports {leds_o[2]}]
# Bank  33 VCCO - VCC1V5_FPGA - IO_L3P_T0_DQS_33
set_property IOSTANDARD LVCMOS15 [get_ports {leds_o[3]}]
set_property PACKAGE_PIN AB9 [get_ports {leds_o[3]}]
# Bank  13 VCCO - VADJ_FPGA - IO_25_13
set_property IOSTANDARD LVCMOS25 [get_ports {leds_o[4]}]
set_property PACKAGE_PIN AE26 [get_ports {leds_o[4]}]
# Bank  17 VCCO - VADJ_FPGA - IO_0_17
# Bank  17 VCCO - VADJ_FPGA - IO_0_17
set_property IOSTANDARD LVCMOS25 [get_ports {leds_o[5]}]
set_property PACKAGE_PIN G19 [get_ports {leds_o[5]}]
# Bank  17 VCCO - VADJ_FPGA - IO_25_17
set_property IOSTANDARD LVCMOS25 [get_ports {leds_o[6]}]
set_property PACKAGE_PIN E18 [get_ports {leds_o[6]}]
# Bank  18 VCCO - VADJ_FPGA - IO_25_18
set_property IOSTANDARD LVCMOS25 [get_ports {leds_o[7]}]
set_property PACKAGE_PIN F16 [get_ports {leds_o[7]}]
