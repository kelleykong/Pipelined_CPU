module Extender(imm, ExtOp, busB1);
	input [15:0] imm;
	input ExtOp;
	output reg [31:0] busB1;

	integer i;
	
	always @(*)
	begin
	busB1[15:0] = imm;		
	if(ExtOp == 1)
		for(i = 16; i < 32; i = i + 1)
			busB1[i] = imm[15];
	else
		for(i = 16; i < 32; i = i + 1)
			busB1[i] = 0;
	end
	
endmodule
