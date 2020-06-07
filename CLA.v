//
module cla_Nbit(a,b,cin,s,cout);

//Parameter Declaration
parameter N = 32;

//Input Port
input [N-1:0] a;
input [N-1:0] b;
input cin;

//Output Port
output [N-1:0] s;
output cout;
//Internals
wire [N:0] c;//carry signals
wire [N:0] p;//propogate signals
wire [N:0] g;//generate signals

assign c[0] = cin;
genvar i;

generate for (i=0;i<N;i=i+1) begin:fa_loop

full_addr FA (.a(a[i]),.b(b[i]),.cin(c[i]),.s(s[i]),.cout());

end
endgenerate

genvar j;

generate for (j=0;j<N;j=j+1) begin:gen_pro_car_loop
	assign g[j] = a[j] & b[j];					//Generate G0=a0 xor b0
	assign p[j] = a[j] ^ b[j];					//Propagate P0=a0.b0
	assign c[j+1] = g[j] | (p[j] & c[j]);	//Carry C1 = G0+ P0.C0
end	
endgenerate

assign cout = c[N];

endmodule

