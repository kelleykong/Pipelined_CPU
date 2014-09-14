module regIF_ID
(
	input clk,
	input clr,
	input [31:0]Inst,
	input [31:0]newPC,
	output reg[31:0]Inst_f,
	output reg[31:0]newPC_f
);

always@(posedge clk)
begin
	Inst_f = Inst;
	newPC_f = newPC; 
	if(clr == 1)
	begin
		Inst_f = 0;
		newPC_f = 0;
	end
end

endmodule
