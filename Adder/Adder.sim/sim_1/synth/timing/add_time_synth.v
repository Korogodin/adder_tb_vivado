// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.3 (win64) Build 1368829 Mon Sep 28 20:06:43 MDT 2015
// Date        : Tue Mar 01 13:38:57 2016
// Host        : Vladimir-PC running 64-bit major release  (build 7600)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               D:/FPGAprojects/Adder/Adder.sim/sim_1/synth/timing/add_time_synth.v
// Design      : add
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* NotValidForBitStream *)
module add
   (a,
    b,
    clk,
    sum);
  input [13:0]a;
  input [13:0]b;
  input clk;
  output [13:0]sum;

  wire [13:0]a;
  wire [13:0]a_IBUF;
  wire [13:0]b;
  wire [13:0]b_IBUF;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire \fullsum[11]_i_2_n_0 ;
  wire \fullsum[11]_i_3_n_0 ;
  wire \fullsum[11]_i_4_n_0 ;
  wire \fullsum[11]_i_5_n_0 ;
  wire \fullsum[13]_i_2_n_0 ;
  wire \fullsum[13]_i_3_n_0 ;
  wire \fullsum[3]_i_2_n_0 ;
  wire \fullsum[3]_i_3_n_0 ;
  wire \fullsum[3]_i_4_n_0 ;
  wire \fullsum[3]_i_5_n_0 ;
  wire \fullsum[7]_i_2_n_0 ;
  wire \fullsum[7]_i_3_n_0 ;
  wire \fullsum[7]_i_4_n_0 ;
  wire \fullsum[7]_i_5_n_0 ;
  wire \fullsum_reg[11]_i_1_n_0 ;
  wire \fullsum_reg[11]_i_1_n_1 ;
  wire \fullsum_reg[11]_i_1_n_2 ;
  wire \fullsum_reg[11]_i_1_n_3 ;
  wire \fullsum_reg[13]_i_1_n_3 ;
  wire \fullsum_reg[3]_i_1_n_0 ;
  wire \fullsum_reg[3]_i_1_n_1 ;
  wire \fullsum_reg[3]_i_1_n_2 ;
  wire \fullsum_reg[3]_i_1_n_3 ;
  wire \fullsum_reg[7]_i_1_n_0 ;
  wire \fullsum_reg[7]_i_1_n_1 ;
  wire \fullsum_reg[7]_i_1_n_2 ;
  wire \fullsum_reg[7]_i_1_n_3 ;
  wire [13:0]p_0_in;
  wire [13:0]sum;
  wire [13:0]sum_OBUF;
  wire [3:1]\NLW_fullsum_reg[13]_i_1_CO_UNCONNECTED ;
  wire [3:2]\NLW_fullsum_reg[13]_i_1_O_UNCONNECTED ;

initial begin
 $sdf_annotate("add_time_synth.sdf",,,,"tool_control");
end
  IBUF \a_IBUF[0]_inst 
       (.I(a[0]),
        .O(a_IBUF[0]));
  IBUF \a_IBUF[10]_inst 
       (.I(a[10]),
        .O(a_IBUF[10]));
  IBUF \a_IBUF[11]_inst 
       (.I(a[11]),
        .O(a_IBUF[11]));
  IBUF \a_IBUF[12]_inst 
       (.I(a[12]),
        .O(a_IBUF[12]));
  IBUF \a_IBUF[13]_inst 
       (.I(a[13]),
        .O(a_IBUF[13]));
  IBUF \a_IBUF[1]_inst 
       (.I(a[1]),
        .O(a_IBUF[1]));
  IBUF \a_IBUF[2]_inst 
       (.I(a[2]),
        .O(a_IBUF[2]));
  IBUF \a_IBUF[3]_inst 
       (.I(a[3]),
        .O(a_IBUF[3]));
  IBUF \a_IBUF[4]_inst 
       (.I(a[4]),
        .O(a_IBUF[4]));
  IBUF \a_IBUF[5]_inst 
       (.I(a[5]),
        .O(a_IBUF[5]));
  IBUF \a_IBUF[6]_inst 
       (.I(a[6]),
        .O(a_IBUF[6]));
  IBUF \a_IBUF[7]_inst 
       (.I(a[7]),
        .O(a_IBUF[7]));
  IBUF \a_IBUF[8]_inst 
       (.I(a[8]),
        .O(a_IBUF[8]));
  IBUF \a_IBUF[9]_inst 
       (.I(a[9]),
        .O(a_IBUF[9]));
  IBUF \b_IBUF[0]_inst 
       (.I(b[0]),
        .O(b_IBUF[0]));
  IBUF \b_IBUF[10]_inst 
       (.I(b[10]),
        .O(b_IBUF[10]));
  IBUF \b_IBUF[11]_inst 
       (.I(b[11]),
        .O(b_IBUF[11]));
  IBUF \b_IBUF[12]_inst 
       (.I(b[12]),
        .O(b_IBUF[12]));
  IBUF \b_IBUF[13]_inst 
       (.I(b[13]),
        .O(b_IBUF[13]));
  IBUF \b_IBUF[1]_inst 
       (.I(b[1]),
        .O(b_IBUF[1]));
  IBUF \b_IBUF[2]_inst 
       (.I(b[2]),
        .O(b_IBUF[2]));
  IBUF \b_IBUF[3]_inst 
       (.I(b[3]),
        .O(b_IBUF[3]));
  IBUF \b_IBUF[4]_inst 
       (.I(b[4]),
        .O(b_IBUF[4]));
  IBUF \b_IBUF[5]_inst 
       (.I(b[5]),
        .O(b_IBUF[5]));
  IBUF \b_IBUF[6]_inst 
       (.I(b[6]),
        .O(b_IBUF[6]));
  IBUF \b_IBUF[7]_inst 
       (.I(b[7]),
        .O(b_IBUF[7]));
  IBUF \b_IBUF[8]_inst 
       (.I(b[8]),
        .O(b_IBUF[8]));
  IBUF \b_IBUF[9]_inst 
       (.I(b[9]),
        .O(b_IBUF[9]));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  LUT2 #(
    .INIT(4'h6)) 
    \fullsum[11]_i_2 
       (.I0(a_IBUF[11]),
        .I1(b_IBUF[11]),
        .O(\fullsum[11]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \fullsum[11]_i_3 
       (.I0(a_IBUF[10]),
        .I1(b_IBUF[10]),
        .O(\fullsum[11]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \fullsum[11]_i_4 
       (.I0(a_IBUF[9]),
        .I1(b_IBUF[9]),
        .O(\fullsum[11]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \fullsum[11]_i_5 
       (.I0(a_IBUF[8]),
        .I1(b_IBUF[8]),
        .O(\fullsum[11]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \fullsum[13]_i_2 
       (.I0(a_IBUF[13]),
        .I1(b_IBUF[13]),
        .O(\fullsum[13]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \fullsum[13]_i_3 
       (.I0(a_IBUF[12]),
        .I1(b_IBUF[12]),
        .O(\fullsum[13]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \fullsum[3]_i_2 
       (.I0(a_IBUF[3]),
        .I1(b_IBUF[3]),
        .O(\fullsum[3]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \fullsum[3]_i_3 
       (.I0(a_IBUF[2]),
        .I1(b_IBUF[2]),
        .O(\fullsum[3]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \fullsum[3]_i_4 
       (.I0(a_IBUF[1]),
        .I1(b_IBUF[1]),
        .O(\fullsum[3]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \fullsum[3]_i_5 
       (.I0(a_IBUF[0]),
        .I1(b_IBUF[0]),
        .O(\fullsum[3]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \fullsum[7]_i_2 
       (.I0(a_IBUF[7]),
        .I1(b_IBUF[7]),
        .O(\fullsum[7]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \fullsum[7]_i_3 
       (.I0(a_IBUF[6]),
        .I1(b_IBUF[6]),
        .O(\fullsum[7]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \fullsum[7]_i_4 
       (.I0(a_IBUF[5]),
        .I1(b_IBUF[5]),
        .O(\fullsum[7]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \fullsum[7]_i_5 
       (.I0(a_IBUF[4]),
        .I1(b_IBUF[4]),
        .O(\fullsum[7]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \fullsum_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[0]),
        .Q(sum_OBUF[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fullsum_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[10]),
        .Q(sum_OBUF[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fullsum_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[11]),
        .Q(sum_OBUF[11]),
        .R(1'b0));
  CARRY4 \fullsum_reg[11]_i_1 
       (.CI(\fullsum_reg[7]_i_1_n_0 ),
        .CO({\fullsum_reg[11]_i_1_n_0 ,\fullsum_reg[11]_i_1_n_1 ,\fullsum_reg[11]_i_1_n_2 ,\fullsum_reg[11]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(a_IBUF[11:8]),
        .O(p_0_in[11:8]),
        .S({\fullsum[11]_i_2_n_0 ,\fullsum[11]_i_3_n_0 ,\fullsum[11]_i_4_n_0 ,\fullsum[11]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \fullsum_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[12]),
        .Q(sum_OBUF[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fullsum_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[13]),
        .Q(sum_OBUF[13]),
        .R(1'b0));
  CARRY4 \fullsum_reg[13]_i_1 
       (.CI(\fullsum_reg[11]_i_1_n_0 ),
        .CO({\NLW_fullsum_reg[13]_i_1_CO_UNCONNECTED [3:1],\fullsum_reg[13]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,a_IBUF[12]}),
        .O({\NLW_fullsum_reg[13]_i_1_O_UNCONNECTED [3:2],p_0_in[13:12]}),
        .S({1'b0,1'b0,\fullsum[13]_i_2_n_0 ,\fullsum[13]_i_3_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \fullsum_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[1]),
        .Q(sum_OBUF[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fullsum_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[2]),
        .Q(sum_OBUF[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fullsum_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[3]),
        .Q(sum_OBUF[3]),
        .R(1'b0));
  CARRY4 \fullsum_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\fullsum_reg[3]_i_1_n_0 ,\fullsum_reg[3]_i_1_n_1 ,\fullsum_reg[3]_i_1_n_2 ,\fullsum_reg[3]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(a_IBUF[3:0]),
        .O(p_0_in[3:0]),
        .S({\fullsum[3]_i_2_n_0 ,\fullsum[3]_i_3_n_0 ,\fullsum[3]_i_4_n_0 ,\fullsum[3]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \fullsum_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[4]),
        .Q(sum_OBUF[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fullsum_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[5]),
        .Q(sum_OBUF[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fullsum_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[6]),
        .Q(sum_OBUF[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fullsum_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[7]),
        .Q(sum_OBUF[7]),
        .R(1'b0));
  CARRY4 \fullsum_reg[7]_i_1 
       (.CI(\fullsum_reg[3]_i_1_n_0 ),
        .CO({\fullsum_reg[7]_i_1_n_0 ,\fullsum_reg[7]_i_1_n_1 ,\fullsum_reg[7]_i_1_n_2 ,\fullsum_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(a_IBUF[7:4]),
        .O(p_0_in[7:4]),
        .S({\fullsum[7]_i_2_n_0 ,\fullsum[7]_i_3_n_0 ,\fullsum[7]_i_4_n_0 ,\fullsum[7]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \fullsum_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[8]),
        .Q(sum_OBUF[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fullsum_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[9]),
        .Q(sum_OBUF[9]),
        .R(1'b0));
  OBUF \sum_OBUF[0]_inst 
       (.I(sum_OBUF[0]),
        .O(sum[0]));
  OBUF \sum_OBUF[10]_inst 
       (.I(sum_OBUF[10]),
        .O(sum[10]));
  OBUF \sum_OBUF[11]_inst 
       (.I(sum_OBUF[11]),
        .O(sum[11]));
  OBUF \sum_OBUF[12]_inst 
       (.I(sum_OBUF[12]),
        .O(sum[12]));
  OBUF \sum_OBUF[13]_inst 
       (.I(sum_OBUF[13]),
        .O(sum[13]));
  OBUF \sum_OBUF[1]_inst 
       (.I(sum_OBUF[1]),
        .O(sum[1]));
  OBUF \sum_OBUF[2]_inst 
       (.I(sum_OBUF[2]),
        .O(sum[2]));
  OBUF \sum_OBUF[3]_inst 
       (.I(sum_OBUF[3]),
        .O(sum[3]));
  OBUF \sum_OBUF[4]_inst 
       (.I(sum_OBUF[4]),
        .O(sum[4]));
  OBUF \sum_OBUF[5]_inst 
       (.I(sum_OBUF[5]),
        .O(sum[5]));
  OBUF \sum_OBUF[6]_inst 
       (.I(sum_OBUF[6]),
        .O(sum[6]));
  OBUF \sum_OBUF[7]_inst 
       (.I(sum_OBUF[7]),
        .O(sum[7]));
  OBUF \sum_OBUF[8]_inst 
       (.I(sum_OBUF[8]),
        .O(sum[8]));
  OBUF \sum_OBUF[9]_inst 
       (.I(sum_OBUF[9]),
        .O(sum[9]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
