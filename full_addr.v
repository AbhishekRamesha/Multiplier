//This is the component level description of Full Adder
// using Half adder and or gate.

module full_addr (a,b,cin,s,cout);

//Input Port
input a;
input b;
input cin;

//Output Port
output s;
output cout;

//Internals
wire s0,c0,c1;
//Instantiations

half_addr HA0 (.a(a),.b(b),.s(s0),.cout(c0));

half_addr HA1 (.a(s0),.b(cin),.s(s),.cout(c1));

or or1(cout,c0,c1);//Verilog Primitive: or gate

endmodule
