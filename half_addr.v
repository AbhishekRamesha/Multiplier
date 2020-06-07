// This is a gate implementation of Half adder.
module half_addr (a,b,s,cout);

//Input Port
input a;
input b;

//Output Port
output s;
output cout;

// sum = a xor b;
//carry = a and b;

assign s = a ^ b;

assign cout = a & b;

endmodule
