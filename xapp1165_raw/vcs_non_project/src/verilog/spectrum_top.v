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

dds_compiler_0 dds_sine0 (
  .aclk               (clk200), // input aclk
  .m_axis_data_tvalid (dds_data_tvalid), // output m_axis_data_tvalid
  .m_axis_data_tdata  (dds_data_tdata) // output [15 : 0] m_axis_data_tdata
);

fir_compiler_0 fir0 (
  .aclk               (clk200          ),    // input aclk
  .s_axis_data_tvalid (dds_data_tvalid ),    // input s_axis_data_tvalid
  .s_axis_data_tready ( ),                   // output s_axis_data_tready
  .s_axis_data_tdata  (dds_data_tdata  ),    // input [15 : 0] s_axis_data_tdata
  .m_axis_data_tvalid (fir_m_axis_data_tvalid),    // output m_axis_data_tvalid
  .m_axis_data_tdata  (fir_m_axis_data_tdata )     // output [15 : 0] m_axis_data_tdata
);

assign fft_s_axis_data_tdata = {16'h0000, fir_m_axis_data_tdata};
assign fft_s_axis_data_tlast = 1'b0;

xfft_0 fft0 (
  .aclk                 (clk200), // input aclk
  .s_axis_config_tdata  (8'h00),  // input [7 : 0] s_axis_config_tdata
  .s_axis_config_tvalid (1'b0 ),  // input s_axis_config_tvalid
  .s_axis_config_tready (     ),  // output s_axis_config_tready
                   
  .s_axis_data_tdata    (fft_s_axis_data_tdata   ),  // input [31 : 0] s_axis_data_tdata
  .s_axis_data_tvalid   (fir_m_axis_data_tvalid  ),  // input s_axis_data_tvalid
  .s_axis_data_tready   (fft_s_axis_data_tready  ),  // output s_axis_data_tready
  .s_axis_data_tlast    (fft_s_axis_data_tlast   ),  // input s_axis_data_tlast         
                   
  .m_axis_data_tdata    (fft_m_axis_data_tdata   ),  // output [63 : 0] m_axis_data_tdata
  .m_axis_data_tuser    (fft_m_axis_data_tuser   ),  // output [15 : 0] m_axis_data_tuser
  .m_axis_data_tvalid   (fft_m_axis_data_tvalid  ),  // output m_axis_data_tvalid
  .m_axis_data_tlast    (fft_m_axis_data_tlast   ),  // output m_axis_data_tlast          
                   
  .event_frame_started        (), // output event_frame_started
  .event_tlast_unexpected     (), // output event_tlast_unexpected
  .event_tlast_missing        (), // output event_tlast_missing
  .event_data_in_channel_halt () // output event_data_in_channel_halt
);

assign fft_xk_re = fft_m_axis_data_tdata[26 -:16];
assign fft_xk_im = fft_m_axis_data_tdata[58 -:16];

//calculate magnitude
cplx_mult 
#(
    .C_DATA_WIDTH (16),
    .C_CONJ       (1'b1)
)
cm_fft_mag_sq  
(
    .rst_i (sys_rst),
    .clk_i (clk200),

    .a_i_i (fft_xk_re),
    .a_q_i (fft_xk_im),

    .b_i_i (fft_xk_re),
    .b_q_i (fft_xk_im),

    .p_i_o (fft_xk_mag_sq),
    .p_q_o ( )  // always 0
);


//----------------------------------------------------------------
// debug
//----------------------------------------------------------------
generate
    if (C_SIM == 1) begin
        assign probe_out0[1:0] = 2'b00;  //
        assign probe_out0[2] = 1'b0;  //
        assign probe_out0[3] = 1'b0;  // 
        assign probe_out0[4] = 1'b0;  //
        assign probe_out0[5] = 1'b0;  // 
        assign probe_out0[6] = 1'b0;  // 
        assign probe_out0[7] = 1'b0;  // 
        assign probe_out0[8] = 1'b0;
        assign probe_out0[9] = 1'b0;  // 
        
    end
    else begin
        ila_0 ila0 (
            .CLK    (clk200),                 // input CLK
            .PROBE0 (dds_data_tvalid),        // input [0 : 0] PROBE0
            .PROBE1 (dds_data_tdata),         // input [15 : 0] PROBE1
            .PROBE2 (fir_m_axis_data_tvalid), // input [0 : 0] PROBE2
            .PROBE3 (fir_m_axis_data_tdata),  // input [15 : 0] PROBE3
            .PROBE4 (fft_s_axis_data_tready), // input [0 : 0] PROBE4
            .PROBE5 (fft_s_axis_data_tlast),  // input [0 : 0] PROBE5
            .PROBE6 (fft_xk_re),              // input [15 : 0] PROBE6
            .PROBE7 (fft_xk_im),              // input [15 : 0] PROBE7
            .PROBE8 (fft_xk_mag_sq)           // input [32 : 0] PROBE8
        );
        
        vio_i256_o256 vio0 (
          .CLK          (clk200      ),
          .PROBE_IN0    (probe_in0   ),
          .PROBE_OUT0   (probe_out0   )
        );
        assign probe_in0[32:0] = fft_xk_mag_sq;
        assign probe_in0[255:33] = 'h0;

    end
endgenerate

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