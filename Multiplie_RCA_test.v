`timescale 1ns/1ps
module mult_rca_tb();

parameter N=32;

//reg Port
reg clk;
reg reset;
reg start;
reg [N-1:0] multiplier;
reg [N-1:0] multiplicand;

//Output Port
wire [2*N-1:0] product;
wire valid;

mult_rca uut 
(
	.clk(clk),
	.reset(reset),
	.start(start),
	.multiplier(multiplier),
	.multiplicand(multiplicand),
	.product(product),
	.valid(valid)
);

always#10 clk = ~ clk;

initial begin
		clk= 0;
		reset=0;
		multiplier =0;
		multiplicand=0;
		start=0;
		#40 reset= 1;
		#100 reset =0;
		#40 start = 1;multiplier = 1256;multiplicand = 256;
		#40 start = 0;multiplier = 0;multiplicand = 0;	

end

endmodule
