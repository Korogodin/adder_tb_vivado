`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.03.2016 13:54:11
// Design Name: 
// Module Name: adder_testbench
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

module adder_testbench();
    parameter dim = 14;
    
    reg [dim-1:0] A, B;
    wire [dim-1:0] SUM;
    reg clk = 0;
    
    add adder(.a(A), .b(B), .clk(clk), .sum(SUM));
    
    initial begin
        A <= $signed(10);
        B <= $signed(-11);
    end
    
    always #5 clk <= ~clk;
    

endmodule
