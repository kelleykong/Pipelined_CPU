module regEX_MEM
(	
	input clk,
	input clr,
	input [31:0]newPC,
	input overflow,
	input [31:0]result,
	input less,                                                                                                                 	
	input zero,
	input [31:0]busB,
	input [4:0]Rw,
	input MemWr,
	input RegWr,
	input RegWr_4,
	input RegWr_3,
	input RegWr_2,
	input RegWr_1,
	input MemtoReg,
	input Branch,
	input lorr,
	input [4:0]shift,
	input OvSel,                                                                                                                
	output reg[31:0]newPC_f,
	output reg overflow_f,
	output reg [31:0]result_f,
	output reg less_f,
	output reg zero_f,
	output reg [31:0]busB_f,
	output reg [4:0]Rw_f,
	output reg MemWr_f,
	output reg RegWr_f,
	output reg RegWr_4f,
	output reg RegWr_3f,
	output reg RegWr_2f,
	output reg RegWr_1f,
	output reg MemtoReg_f,
	output reg Branch_f,
	output reg lorr_f,
	output reg [4:0]shift_f,
	output reg OvSel_f
);

always@(posedge clk)
begin
	overflow_f = overflow;
	newPC_f = newPC;
	result_f = result;
	less_f = less;
	zero_f = zero;
	Rw_f = Rw;
	MemWr_f = MemWr;
	RegWr_f = RegWr;
	RegWr_4f = RegWr_4;
	RegWr_3f = RegWr_3;
	RegWr_2f = RegWr_2;
	RegWr_1f = RegWr_1;
	busB_f = busB;
	MemtoReg_f = MemtoReg;
	Branch_f = Branch;
	lorr_f = lorr;
	shift_f = shift;
	OvSel_f = OvSel;
	if(clr == 1)
	begin
		overflow_f = overflow;
		newPC_f = newPC;
		result_f = result;
		less_f = less;
		zero_f = zero;
		Rw_f = Rw;
		MemWr_f = MemWr;
		RegWr_f = RegWr;
		RegWr_4f = RegWr_4;
		RegWr_3f = RegWr_3;
		RegWr_2f = RegWr_2;
		RegWr_1f = RegWr_1;
		busB_f = busB;
		MemtoReg_f = MemtoReg;
		Branch_f = Branch;
		lorr_f = lorr;
		shift_f = shift;
		OvSel_f = OvSel;
	end
end

endmodule
