//*******************************************************************************
//
//  File name : 
// 
//  Description :
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
//  Copyright © 2011 Xilinx, Inc.
//  All rights reserved 
// 
//*****************************************************************************

`timescale 1ns / 1ns
`default_nettype none
    
module cplx_mult
#(
    parameter C_DATA_WIDTH = 16,
    parameter C_CONJ       = 1'b0
) 
(
    input wire rst_i,
    input wire clk_i,

    input wire signed [C_DATA_WIDTH-1:0] a_i_i,
    input wire signed [C_DATA_WIDTH-1:0] a_q_i,

    input wire signed [C_DATA_WIDTH-1:0] b_i_i,
    input wire signed [C_DATA_WIDTH-1:0] b_q_i,

    output reg signed [2*C_DATA_WIDTH:0] p_i_o,
    output reg signed [2*C_DATA_WIDTH:0] p_q_o
);

//------------------------------------------------------------------------
// complex mult (behavioral for now)
// a*conj(b)
always @(posedge clk_i) begin
    if (C_CONJ) begin
        p_i_o <= (a_i_i*b_i_i) + (a_q_i*b_q_i);
        p_q_o <= (a_q_i*b_i_i) - (a_i_i*b_q_i);
    end
    else begin
        p_i_o <= (a_i_i*b_i_i) - (a_q_i*b_q_i);
        p_q_o <= (a_q_i*b_i_i) + (a_i_i*b_q_i);        
    end
end

endmodule // cplx_mult

`default_nettype wire


                       