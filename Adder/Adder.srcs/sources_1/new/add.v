`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.03.2016 13:00:47
// Design Name: 
// Module Name: add
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module add(
    a,
    b,
    clk,
    sum
    );

    parameter dim = 14; // comment
    
    input [dim-1:0] a;
    input [dim-1:0] b;
    input clk;
    output [dim-1:0] sum;

    reg [dim-1+1:0] fullsum;
    
    always @(posedge clk) begin
        fullsum <= $signed(a)*$signed(a) + $signed(b);
    end
    
    assign sum = fullsum[dim-1:0];
     
    
endmodule
