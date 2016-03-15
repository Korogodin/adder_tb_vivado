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

module add_tb();
    parameter dim = 14;
    `define NULL 0    
    
    reg [dim-1:0] A, B;
    wire [dim-1:0] SUM;
    reg clk = 0;
    
    add adder(.a(A), .b(B), .clk(clk), .sum(SUM));
    
//    initial begin
//        A <= $signed(10);
//        B <= $signed(-11);
//    end
    
    always #5 clk <= ~clk;
    
    // Input data
    integer data_file;
    initial begin 
        data_file = $fopen("In.txt", "r");
        if (data_file == `NULL) begin
            $display("data_file handle was NULL");
            $finish;
        end
    end
    
    integer scan_file;
    integer a, b;
    always @(posedge clk) begin
        scan_file = $fscanf(data_file, "%d %d", a, b);
        if (!$feof(data_file)) begin
            A <= a;
            B <= b;
        end
    end
    
    // Output results 
    integer Res_file;   // file handler
    initial begin 
        Res_file = $fopen("Res.txt", "w");
    end
    
    integer j = 0;
    always @(posedge clk) begin
        for (j=0; j<1; j=j+1)
            $fwrite(Res_file, "%d %d %d", $signed(A), $signed(B), $signed(SUM));
        $fwrite(Res_file, "\n");
        $fflush(Res_file);
    end
  
endmodule
