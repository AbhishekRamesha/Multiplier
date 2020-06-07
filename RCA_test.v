`timescale 1ns/1ps
module rca_tb();

parameter N = 32;
reg [N-1:0]a;
reg [N-1:0]b;
reg cin;

wire [N-1:0]s;
wire cout;

//Unit Under Test
rca_Nbit #(N) uut (.a(a),.b(b),.cin(cin),.s(s),.cout(cout));

initial begin
		a=0;b=0;cin=0;
#10	a=16;b=0;cin=0;	
#10	a=0;b=16;cin=0;

#10	a=16;b=0;cin=1;	
#10	a=0;b=16;cin=1;

#10	a=16;b=15;cin=0;	
#10	a=36;b=63;cin=1;

#10	a=16;b=16;cin=0;	
#10	a=256;b=256;cin=0;

#10	a=255;b=15;cin=0;	
#10	a=31;b=65536;cin=0;

#10	a=131072;b=131072;cin=0;	
#10	a=4;b=4;cin=0;

#10 $stop;
end
endmodule
