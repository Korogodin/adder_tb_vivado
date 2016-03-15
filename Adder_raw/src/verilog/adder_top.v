
`timescale 1ns / 1ns
`default_nettype none
    
module adder_top
#(
    parameter C_SIM        = 0
)
(
    a,
    b,
    c,
    d,
    
    s,
    
    clk
);

    parameter dim = 14;
    input wire signed [dim-1:0] a;
    input wire signed [dim-1:0] b;
    input wire signed [dim-1:0] c;
    input wire signed [dim-1:0] d;
      
    output wire signed [dim-1:0] s;
    
    input wire clk;
            
    reg signed [dim-1:0] sout;
    wire signed [dim-1:0] s0, s1;
    
    assign s = sout;

    add
	#(
	//      .CLK_CNT_MAX (32'h10000000)
	) add0
	(
	.a(a),
	.b(b),
	.clk(clk),
	.sum(s0)
	);


    add
	#(
	//      .CLK_CNT_MAX (32'h10000000)
	) add1
	(
	    .a(c),
	    .b(d),
	    .clk(clk),
	    .sum(s1)
	);
	
    always @(posedge clk) begin
	   sout <= s0 + s1;
    end


endmodule 


`default_nettype wire