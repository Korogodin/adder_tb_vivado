//*******************************************************************************
//
//  File name : 
// 
//  Description : Example design for source version control application note
//
//  History :
//
//  Author(s) : 
//
//  Disclaimer: LIMITED WARRANTY AND DISCLAMER. These designs are 
//              provided to you "as is". Xilinx and its licensors make and you 
//              receive no warranties or conditions, express, implied, 
//              statutory or otherwise, and Xilinx specifically disclaims any 
//              implied warranties of merchantability, non-infringement, or 
//              fitness for a particular purpose. Xilinx does not warrant that 
//              the functions contained in these designs will meet your 
//              requirements, or that the operation of these designs will be 
//              uninterrupted or error free, or that defects in the Designs 
//              will be corrected. Furthermore, Xilinx does not warrant or 
//              make any representations regarding use or the results of the 
//              use of the designs in terms of correctness, accuracy, 
//              reliability, or otherwise. 
//
//              LIMITATION OF LIABILITY. In no event will Xilinx or its 
//              licensors be liable for any loss of data, lost profits, cost 
//              or procurement of substitute goods or services, or for any 
//              special, incidental, consequential, or indirect damages 
//              arising from the use or operation of the designs or 
//              accompanying documentation, however caused and on any theory 
//              of liability. This limitation will apply even if Xilinx 
//              has been advised of the possibility of such damage. This 
//              limitation shall apply not-withstanding the failure of the 
//              essential purpose of any limited remedies herein. 
//
//  Copyright ? 2013 Xilinx, Inc.
//  All rights reserved 
// 
//*****************************************************************************

`timescale 1ns / 1ns
`default_nettype none
    
module spectrum_top
#(
    parameter C_SIM        = 0
)
(
    input wire sys_rst_i,
    input wire sys_clk_p_i,
    input wire sys_clk_n_i,
    
    output wire [7:0] leds_o
);

wire sys_clk, clk200;
wire sys_rst;

(* mark_debug = "TRUE" *) wire               dds_data_tvalid;
(* mark_debug = "TRUE" *) wire signed [15:0] dds_data_tdata;
(* mark_debug = "TRUE" *) wire signed        fir_m_axis_data_tvalid;
(* mark_debug = "TRUE" *) wire signed [15:0] fir_m_axis_data_tdata;

                          wire [31:0] fft_s_axis_data_tdata ;
(* mark_debug = "TRUE" *) wire        fft_s_axis_data_tready;
(* mark_debug = "TRUE" *) wire        fft_s_axis_data_tlast ;    

wire [63 : 0] fft_m_axis_data_tdata ; 
wire [15 : 0] fft_m_axis_data_tuser ; 
wire          fft_m_axis_data_tvalid; 
wire          fft_m_axis_data_tlast ; 

(* mark_debug = "TRUE" *) wire [15:0] fft_xk_re, fft_xk_im;


(* mark_debug = "TRUE" *) wire signed [32:0] fft_xk_mag_sq;
            
/////////////////////////////////////////////////////////////////
// debug signals
/////////////////////////////////////////////////////////////////
wire [255:0] probe_in0, probe_out0;
(* mark_debug = "TRUE" *) wire         hb_clk200;
wire         sync_rst_vio, sync_rst_rst;


IBUFDS ibuf_sysclk
(
    .I  (sys_clk_p_i),
    .IB (sys_clk_n_i),
    .O  (sys_clk)
);

BUFG bufg_clk200 (.I (sys_clk), .O (clk200));

assign sys_rst = sys_rst_i;

heartbeat_gen  
  #(
      .CLK_CNT_MAX (32'h10000000)
  ) hb_gen_clk200
  (
      .reset_i     (sys_rst),
      .clk_i       (clk200),
      .heartbeat_o (hb_clk200)
  );
  
assign leds_o[0] = 1'b0;
assign leds_o[1] = hb_clk200;
assign leds_o[2] = 1'b0;
assign leds_o[3] = 1'b0;
assign leds_o[4] = 1'b0;
assign leds_o[7:5] = 3'b0;

endmodule 


`default_nettype wire