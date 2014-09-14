module MIPS(clk, PCCin, PCCout, Inst, Inst_ID, Dw, Da, Db, Inst_Ex, result, busA0, busA, busB, busB11, Rw_Wr, Branch_f, Jump_Ex, Branch_Mem);
	input clk;

	output wire [31:0]PCCin;
	output wire [31:0]PCCout;
	Reg PC(clk, 1, PCCin, PCCout);
	
	output wire [31:0] Inst;
	RAM IM(clk, PCCout, 0, 0, Inst);
	
	wire [31:0] PC_IF;
	Adder Adder1(4, PCCout, PC_IF);
	
	wire [31:0] JumpPC_f, PC_Ex;
	wire [31:0] Inst_Ex;
	output wire Jump_Ex;
	MUX2_32b JumpMUX({PC_Ex[31:28], Inst_Ex[25:0], 2'b00}, PC_IF, Jump_Ex, JumpPC_f);
	
	wire [31:0] BranchPC_f;
	output wire Branch_f;
	MUX2_32b BranchMUX(BranchPC_f, JumpPC_f, Branch_f, PCCin);	
	
	output wire [31:0] Inst_ID;
	wire [31:0] PC_ID;
	wire IF_ID_CLR_f, IF_ID_CLR_J, IF_ID_CLR_B;
	or(IF_ID_CLR_f, IF_ID_CLR_J, IF_ID_CLR_B);
	regIF_ID(clk, IF_ID_CLR_f, Inst, PC_IF, Inst_ID, PC_ID);
	
	output wire [4:0] Rw_Wr;
	output wire [31:0] Dw, Da, Db;
	wire RegWr_f, RegWr_4Wr, RegWr_3Wr, RegWr_2Wr, RegWr_1Wr;
	MIPSregister_32b Reg(Inst_ID[25:21], Inst_ID[20:16], Rw_Wr, Dw, RegWr_f, RegWr_4Wr, RegWr_3Wr, RegWr_2Wr, RegWr_1Wr, clk, Da, Db);
	
	wire ALUSrc;
	wire RegWr,  RegWr_4, RegWr_3, RegWr_2, RegWr_1;
	wire ExtOp, RegDst, MemWr, MemtoReg, Branch, Jump, l_r, lorr, OVSel;
	wire [3:0] ALUop;
	wire [4:0] shift;
	MainCtr(Inst_ID, ExtOp, ALUSrc, RegDst, MemWr, RegWr, RegWr_4, RegWr_3, RegWr_2, RegWr_1, MemtoReg, Branch, Jump, l_r, lorr, ALUop, shift, OVSel);
	
	wire ALUSrc_Ex, RegWr_Ex, RegWr_4Ex, RegWr_3Ex, RegWr_2Ex, RegWr_1Ex;
	wire ExtOp_Ex, RegDst_Ex, MemWr_Ex, MemtoReg_Ex, Branch_Ex, l_r_Ex, lorr_Ex, OVSel_Ex, ID_EX_CLR_f, ID_EX_CLR_J, ID_EX_CLR_B;
	output wire [31:0] busA0, Inst_Ex;
	wire [31:0] busB0;
	wire [3:0] ALUop_Ex;
	wire [4:0] shift_Ex;
	or(ID_EX_CLR_f, ID_EX_CLR_J, ID_EX_CLR_B);
	regID_EX(clk, ID_EX_CLR_f, PC_ID, Da, Db, Inst_ID, ExtOp, ALUSrc, ALUop, RegDst, MemWr, RegWr, RegWr_4,RegWr_3,RegWr_2,RegWr_1, MemtoReg, Branch, Jump, l_r, lorr, shift, OVSel, PC_Ex, busA0, busB0, Inst_Ex, ExtOp_Ex, ALUSrc_Ex, ALUop_Ex, RegDst_Ex, MemWr_Ex, RegWr_Ex, RegWr_4Ex, RegWr_3Ex, RegWr_2Ex, RegWr_1Ex, MemtoReg_Ex, Branch_Ex, Jump_Ex, l_r_Ex, lorr_Ex, shift_Ex, OVSel_Ex);

	output wire [31:0] busB11;
	Extender(Inst_Ex[15:0], ExtOp_Ex, busB11);
	
	wire [3:0] Rw_Mem;
	wire [1:0] ALUSrcA, ALUSrcB;
	wire RegWr_Mem, RegWr_Wr;
	trans(Rw_Mem, Rw_Wr, Inst_Ex[25:21], Inst_Ex[20:16], RegWr_Mem, RegWr_Wr, ALUSrc_Ex, ALUSrcA, ALUSrcB);
	
	output wire [31:0] busA;
	wire [31:0] result_Mem;
	MUX3_32b busAMUX(busA0, result_Mem, Dw, ALUSrcA, busA);
	
	output wire [31:0] busB;
	MUX4_32b busBMUX(busB0, result_Mem, Dw, busB11, ALUSrcB, busB);
	
	wire [4:0] ALUshift;
	MUX2_5b ALUshiftMUX(busA[4:0], Inst_Ex[10:6], l_r_Ex, ALUshift);
	
	wire Less, Zero, Overflow;
	output wire [31:0] result;
	MIPSALU32(busA, busB, ALUshift, ALUop_Ex, Less, Zero, result, Overflow);
	
	wire [31:0] BranchPC;
	Adder Adder2({busB11[29:0], 2'b00}, PC_Ex, BranchPC);
	
	wire [5:0] Rw_Ex;
	MUX2_5b RwMUX(Inst_Ex[15:11], Inst_Ex[20:16], RegDst_Ex, Rw_Ex);	

	jumpctr(Jump_Ex, IF_ID_CLR_J, ID_EX_CLR_J);
	
	wire [31:0] busB_Mem;
	wire [4:0] shift_Mem;
	wire RegWr_4Mem, RegWr_3Mem, RegWr_2Mem, RegWr_1Mem, EX_MEM_CLR;
	wire Overflow_Mem, Less_Mem, Zero_Mem, MemWr_Mem, MemtoReg_Mem, lorr_Mem, OVSel_Mem;
	output wire Branch_Mem;
	regEX_MEM(clk, EX_MEM_CLR, BranchPC, Overflow, result, Less, Zero, busB0, Rw_Ex, MemWr_Ex, RegWr_Ex, RegWr_4Ex, RegWr_3Ex, RegWr_2Ex, RegWr_1Ex, MemtoReg_Ex, Branch_Ex,lorr_Ex, shift_Ex, OVSel_Ex, BranchPC_f, Overflow_Mem, result_Mem, Less_Mem, Zero_Mem, busB_Mem, Rw_Mem, MemWr_Mem, RegWr_Mem, RegWr_4Mem, RegWr_3Mem, RegWr_2Mem, RegWr_1Mem, MemtoReg_Mem, Branch_Mem, lorr_Mem, shift_Mem,OVSel_Mem);
	
	wire [31:0] Dout;
	Cache_RAM DM(clk, result_Mem, busB_Mem, MemWr_Mem, Dout);
	
	wire [31:0] Dout_f;
	barrel_shift_32(Dout, shift_Mem, lorr_Mem, 0, Dout_f);
	
	wire l_z;
	or(l_z, Less_Mem, Zero_Mem);
	and(Branch_f, Branch_Mem, l_z);
	
	blezctr(Branch_f, IF_ID_CLR_B, ID_EX_CLR_B, EX_MEM_CLR);
	wire Overflow_Wr, MemtoReg_Wr, OVSel_Wr;
	wire [31:0] Dout_Wr, result_Wr;
	regMEM_WR(clk, Overflow_Mem, Dout_f, result_Mem, Rw_Mem, RegWr_Mem, RegWr_4Mem, RegWr_3Mem, RegWr_2Mem, RegWr_1Mem, MemtoReg_Mem, OVSel_Mem, Overflow_Wr, Dout_Wr, result_Wr, Rw_Wr, RegWr_Wr, RegWr_4Wr, RegWr_3Wr, RegWr_2Wr, RegWr_1Wr, MemtoReg_Wr, OVSel_Wr);

	wire Overflow_n, OV;
	not(Overflow_n, Overflow_Wr);
	MUX2_1b OFMUX(Overflow_n, 1, OVSel_Wr, OV);
	and(RegWr_f, OV, RegWr_Wr);
	MUX2_32b DwMUX(result_Wr, Dout_Wr, MemtoReg_Wr, Dw);
endmodule
