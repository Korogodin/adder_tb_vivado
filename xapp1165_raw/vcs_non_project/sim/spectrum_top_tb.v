`timescale 1 ns / 100 ps

module spectrum_top_tb;

reg clk200, reset;

             
initial begin
    clk200 = 0;
    reset = 1;
    #50 reset = 0;
    
end

always #2.500 clk200 = ~clk200;

spectrum_top 
#(
    .C_SIM         (1)
) uut
(
    .sys_rst_i   (reset),
    .sys_clk_p_i (clk200),
    .sys_clk_n_i (~clk200),

    .leds_o      ( )
 );

endmodule