module Adder(A, B, F);
	input [31:0] A;
	input [31:0] B;
	output [31:0] F;
	
	assign F = A + B;
	
endmodule
