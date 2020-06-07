// n-bit RCA using 1 bit full adders
module rca_Nbit (a,b,cin,s,cout);

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
wire [N:0] c;

assign c[0] = cin; 
genvar i;

generate for (i=0;i<N;i=i+1) begin:rca_loop

full_addr FA (.a(a[i]),.b(b[i]),.cin(c[i]),.s(s[i]),.cout(c[i+1]));

end
endgenerate

assign cout = c[N];

endmodule
