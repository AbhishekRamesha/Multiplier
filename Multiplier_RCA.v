//Top Level Module: SHIFT and ADD Multiplier using RCA

module mult_rca (clk,reset,start,multiplier,multiplicand,product,valid);

parameter N=32;

//Input Port
input clk;
input reset;
input start;
input [N-1:0] multiplier;
input [N-1:0] multiplicand;

//Output Port
output reg[2*N-1:0] product;
output valid;

//Internals
reg [N-1:0] Multiplier;
reg [2*N-1:0] Multiplicand;
wire [2*N-1:0] Product;
wire shift_l,shift_r,load,write;

//Register for Multiplier
always@(posedge clk)
begin
	if(reset)
		Multiplier <= 'b0;
	else if(load)
		Multiplier <= multiplier;	// load with the input value of multiplier
	else if(shift_r)
		Multiplier <= {1'b0,Multiplier[N-1:1]};	// shift right operation
end

//Register for Multiplicand
always@(posedge clk)
begin
	if(reset)
		Multiplicand <= 'b0;
	else if(load)
		Multiplicand <= {{N{1'b0}},multiplicand};	// load with the input value of multiplier and extend it to 64 bits
	else if(shift_l)
		Multiplicand <= {Multiplicand[2*N-2:0],1'b0};	// shift left operation
end
	
//Instantiating the control unit
control_unit CU 
(
	.clk(clk),
	.reset(reset),
	.start(start),
	.M0(Multiplier[0]),
	.load(load),
	.shift_r(shift_r),
	.shift_l(shift_l),
	.write(write),
	.valid(valid)
);

//Instantiating RCA
rca_Nbit #(2*N) RCA (.a(Multiplicand),.b(product),.cin(1'b0),.s(Product));	

//Register for Product
always@(posedge clk)
begin
	if(reset)
		product <= 'b0;
	else if(write)
		product <= Product;
end

endmodule

