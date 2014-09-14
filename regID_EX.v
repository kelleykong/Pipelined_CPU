module regID_EX
(
	input clk,
	input clr,
	input [31:0]newPC,
	input [31:0]busA,
	input [31:0]busB,
	input [31:0]Inst,
	input ExtOp,
	input ALUSrc,
	input [3:0]ALUop,
	input RegDst,
	input MemWr,
	input RegWr,
	input RegWr_4,RegWr_3,RegWr_2,RegWr_1,//the 4 controller of the REGISTER
	input MemtoReg,
	input Branch,
	input Jump,
	input l_r,//the sign of the right or left shift
	input lorr,
	input [4:0]shift,
	input OVSel,
	output reg[31:0]newPC_f,
	output reg[31:0]busA_f,
	output reg[31:0]busB_f,
	output reg[31:0]Inst_f,
	output reg ExtOp_f,
	output reg ALUSrc_f,
	output reg [3:0]ALUop_f,
	output reg RegDst_f,
	output reg MemWr_f,
	output reg RegWr_f,
	output reg RegWr_4f,RegWr_3f,RegWr_2f,RegWr_1f,//the 4 controller of the REGISTER
	output reg MemtoReg_f,
	output reg Branch_f,
	output reg Jump_f,
	output reg l_rf,//the sign of the right or left shift
	output reg lorr_f,
	output reg [4:0]shift_f,
	output reg OVSel_f
);
always@(posedge clk)
begin
	busA_f = busA;
	busB_f = busB;
	Inst_f = Inst;
	newPC_f = newPC;
	ExtOp_f = ExtOp;
	ALUSrc_f = ALUSrc;
	ALUop_f = ALUop;
	RegDst_f = RegDst;
	MemWr_f = MemWr;
	RegWr_f = RegWr;
	RegWr_4f = RegWr_4;
	RegWr_3f = RegWr_3;
	RegWr_2f = RegWr_2;
	RegWr_1f = RegWr_1;
	MemtoReg_f = MemtoReg;
	Branch_f = Branch;
	Jump_f = Jump;
	l_rf = l_r;
	lorr_f = lorr;
	shift_f = shift;
	OVSel_f = OVSel;
	if(clr == 1)
	begin
		busA_f = 0;
		busB_f = 0;
		Inst_f = 0;
		newPC_f = 0;
		ExtOp_f = 0;
		ALUSrc_f = 0;
		ALUop_f = 0;
		RegDst_f = 0;
		MemWr_f = 0;
		RegWr_f = 0;
		RegWr_4f = 0;
		RegWr_3f = 0;
		RegWr_2f = 0;
		RegWr_1f = 0;
		MemtoReg_f = 0;
		Branch_f = 0;
		Jump_f = 0;
		l_rf = 0;
		lorr_f = 0;
		shift_f = 0;
		OVSel_f = 0;
	end
end

endmodule
