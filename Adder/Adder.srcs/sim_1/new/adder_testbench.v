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
    
//       `include "params_FullFilter.inc"
       
//       reg clk = 1'b0;
//       reg Rst = 1'b1;
//       reg isRun = 1'b0;
    
       
//       initial begin
//          clk = 1'b0;
//          Rst = 1'b1;
//          #20 Rst = 1'b0;
//          #10 isRun = 1'b1;
//       end
    
//       always #5 clk=!clk;
    
//       // Счётчик тактов
//       reg [16:0] cnt=0;
//       always @(posedge clk) begin
//          cnt <= cnt+1;
//       end
    
//       // Чтение входных данных из файла
//    `define NULL 0    
    
//       integer data_file;   // file handler
//       integer scan_file;   // file handler   
//       integer adc;
//       reg signed [NR1*NA-1:0] adc_in;
       
//       initial begin 
//          data_file = $fopen("E:/Questa/data2.txt", "r");
//          if (data_file == `NULL) begin
//         $display("data_file handle was NULL");
//         $finish;
//          end
//       end
    
//       generate 
//          genvar adc_ch;
//          for (adc_ch=0; adc_ch<NA; adc_ch=adc_ch+1) begin
//         always @(posedge clk or negedge Rst) begin
//            if (Rst == 1'b1)
//               adc_in[ adc_ch*NR1 +: NR1 ] <= 0;
//            else begin
//               scan_file = $fscanf(data_file, "%d", adc);
//               if (!$feof(data_file))
//             adc_in[ adc_ch*NR1 +: NR1 ] <= adc[NR1-1:0];
//            end
//         end
//          end     
//       endgenerate
    
    
//       // Линия задержки
//       wire [NR1*NA*NT-1:0] in;  // Процесс с выхода линии задержки
    
//       DelayLine DL
//         (
//          .clk(clk),
//          .Rst(Rst),
//          .in(adc_in),
//          .out(in)
//          );
       
//       // Накопление данных
//       wire [NR3_2*NR-1:0] R;
//       wire            isDone;
    
//       FullMatrix FM
//         (
//          .clk(clk),
//          .Rst(Rst),
//          .in(in),
//          .R(R),
//          .Nstat(13'd1),
//          .start(isRun),
//          .done(isDone)
//          );
    
       
       // Запись результата накопления в файл
//       integer R_file;   // file handler
////       integer RR_file;   // file handler   
       
//       initial begin 
//          R_file = $fopen("R.txt", "w");
//       end
    
//       integer i = 0;
   
//       initial begin
//          @(posedge isDone);
          
//          for (i=0; i<NR; i=i+1)
//           $fwrite(R_file, "%d\n", $signed(R[ i*NR3_2 +: NR3_2 ]));
//       end


endmodule
