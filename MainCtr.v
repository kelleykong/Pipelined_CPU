module MainCtr(Inst, ExtOp, ALUSrc, RegDst, MemWr, RegWr, RegWr_4, RegWr_3, RegWr_2, RegWr_1, MemtoReg, Branch, Jump, l_r, lorr, ALUop, shift, OVSel);
	input [31:0] Inst;
	output reg ExtOp, ALUSrc, RegDst, MemWr, RegWr, RegWr_4, RegWr_3, RegWr_2, RegWr_1, MemtoReg, Branch, Jump, l_r, lorr, OVSel;
	output reg [3:0] ALUop;
	output reg [4:0] shift;
	
	always @(*)
	begin					
		case (Inst[31:26])
			6'b000000:
			begin		
				ExtOp = 0;
				ALUSrc = 0;
				RegDst = 1;
				MemWr = 0;
				RegWr = 1;
				RegWr_4 = 1;
				RegWr_3 = 1;
				RegWr_2 = 1;
				RegWr_1 = 1;	
				MemtoReg = 1;
				Branch = 0;
				Jump = 0;	
				lorr = 0;
				shift = 0;		
				case (Inst[5:0])
					6'b100000://add
					begin
						OVSel = 1;
						l_r = 0;
						ALUop = 0;
					end
					6'b100001://addu
					begin
						OVSel = 0;
						l_r = 0;
						ALUop = 0;
					end
					6'b100010://sub
					begin
						OVSel = 1;
						l_r = 0;
						ALUop = 1;
					end
					6'b100011://subu
					begin
						OVSel = 0;
						l_r = 0;
						ALUop = 1;
					end
					6'b100111://nor
					begin
						OVSel = 0;
						l_r = 0;
						ALUop = 8;
					end
					6'b101010://slt
					begin
						OVSel = 0;
						l_r = 0;
						ALUop = 4'b0101;
					end
					6'b101011://sltu
					begin
						OVSel = 0;
						l_r = 0;
						ALUop = 4'b0111;
					end
					6'b000100://sllv
					begin
						OVSel = 0;
						l_r = 1;
						ALUop = 4'b1011;
					end
					6'b000011://sra
					begin
						OVSel = 0;
						l_r = 0;
						ALUop = 4'b1010;
					end
				endcase
			end
			6'b011100:
			begin
				ExtOp = 0;
				ALUSrc = 0;
				RegDst = 1;
				MemWr = 0;
				RegWr = 1;
				RegWr_4 = 1;
				RegWr_3 = 1;
				RegWr_2 = 1;
				RegWr_1 = 1;	
				MemtoReg = 1;
				Branch = 0;
				Jump = 0;	
				lorr = 0;
				shift = 0;	
				case (Inst[5:0])
					6'b100001://clo
					begin
						OVSel = 0;
						l_r = 0;
						ALUop = 3;
					end
					6'b100000://clz
					begin
						OVSel = 0;
						l_r = 0;
						ALUop = 2;
					end
				endcase
			end
			6'b001000://addi
			begin
				ExtOp = 1;
				ALUSrc = 1;
				RegDst = 0;
				MemWr = 0;
				RegWr = 1;
				RegWr_4 = 1;
				RegWr_3 = 1;
				RegWr_2 = 1;
				RegWr_1 = 1;
				MemtoReg = 1;
				Branch = 0;
				Jump = 0;
				l_r = 0;
				lorr = 0;
				OVSel = 1;
				ALUop = 0;
				shift = 0;
			end
			6'b001001://addiu
			begin
				ExtOp = 1;
				ALUSrc = 1;
				RegDst = 0;
				MemWr = 0;
				RegWr = 1;
				RegWr_4 = 1;
				RegWr_3 = 1;
				RegWr_2 = 1;
				RegWr_1 = 1;
				MemtoReg = 1;
				Branch = 0;
				Jump = 0;
				l_r = 0;
				lorr = 0;
				OVSel = 0;
				ALUop = 0;
				shift = 0;
			end	
			6'b001110://xori
			begin
				ExtOp = 0;
				ALUSrc = 1;
				RegDst = 0;
				MemWr = 0;
				RegWr = 1;
				RegWr_4 = 1;
				RegWr_3 = 1;
				RegWr_2 = 1;
				RegWr_1 = 1;
				MemtoReg = 1;
				Branch = 0;
				Jump = 0;
				l_r = 0;
				lorr = 0;
				OVSel = 0;
				ALUop = 4'b1001;
				shift = 0;
			end	
			6'b001010://slti
			begin
				ExtOp = 1;
				ALUSrc = 1;
				RegDst = 0;
				MemWr = 0;
				RegWr = 1;
				RegWr_4 = 1;
				RegWr_3 = 1;
				RegWr_2 = 1;
				RegWr_1 = 1;
				MemtoReg = 1;
				Branch = 0;
				Jump = 0;
				l_r = 0;
				lorr = 0;
				OVSel = 0;
				ALUop = 4'b0101;
				shift = 0;
			end	
			6'b001011://sltiu
			begin
				ExtOp = 1;
				ALUSrc = 1;
				RegDst = 0;
				MemWr = 0;
				RegWr = 1;
				RegWr_4 = 1;
				RegWr_3 = 1;
				RegWr_2 = 1;
				RegWr_1 = 1;
				MemtoReg = 1;
				Branch = 0;
				Jump = 0;
				l_r = 0;
				lorr = 0;
				OVSel = 0;
				ALUop = 4'b0111;
				shift = 0;
			end	
			6'b100010://lwl
			begin
				ExtOp = 0;
				ALUSrc = 1;
				RegDst = 0;
				MemWr = 0;
				RegWr = 1;
				MemtoReg = 0;
				Branch = 0;
				Jump = 0;
				l_r = 0;
				lorr = 1;
				OVSel = 0;
				ALUop = 4'b0100;
				case (Inst[15:0])
					0:
					begin
						RegWr_1 = 0;
						RegWr_2 = 0;
						RegWr_3 = 0;
						RegWr_4 = 1;
						shift = 5'b11000;
					end
					1:
					begin
						RegWr_1 = 0;
						RegWr_2 = 0;
						RegWr_3 = 1;
						RegWr_4 = 1;
						shift = 5'b10000;
					end
					2:
					begin
						RegWr_1 = 0;
						RegWr_2 = 1;
						RegWr_3 = 1;
						RegWr_4 = 1;
						shift = 5'b01000;
					end
					3:
					begin
						RegWr_1 = 1;
						RegWr_2 = 1;
						RegWr_3 = 1;
						RegWr_4 = 1;
						shift = 5'b00000;
					end	
				endcase
			end
			6'b100110://lwr
			begin
				ExtOp = 0;
				ALUSrc = 1;
				RegDst = 0;
				MemWr = 0;
				RegWr = 1;
				MemtoReg = 0;
				Branch = 0;
				Jump = 0;
				l_r = 0;
				lorr = 0;
				OVSel = 0;
				ALUop = 4'b0100;
				case (Inst[15:0])
					0:
					begin
						RegWr_1 = 1;
						RegWr_2 = 1;
						RegWr_3 = 1;
						RegWr_4 = 1;
						shift = 5'b00000;
					end
					1:
					begin
						RegWr_1 = 1;
						RegWr_2 = 1;
						RegWr_3 = 1;
						RegWr_4 = 0;
						shift = 5'b01000;
					end
					2:
					begin
						RegWr_1 = 1;
						RegWr_2 = 1;
						RegWr_3 = 0;
						RegWr_4 = 0;
						shift = 5'b10000;
					end
					3:
					begin
						RegWr_1 = 1;
						RegWr_2 = 0;
						RegWr_3 = 0;
						RegWr_4 = 0;
						shift = 5'b11000;
					end	
				endcase
			end
			6'b100011://lw
			begin
				ExtOp = 1;
				ALUSrc = 1;
				RegDst = 0;
				MemWr = 0;
				RegWr = 1;
				RegWr_4 = 1;
				RegWr_3 = 1;
				RegWr_2 = 1;
				RegWr_1 = 1;
				MemtoReg = 0;
				Branch = 0;
				Jump = 0;
				l_r = 0;
				lorr = 0;
				OVSel = 0;
				ALUop = 4'b0000;
				shift = 0;	
			end
			6'b101011://sw
			begin
				ExtOp = 1;
				ALUSrc = 1;
				RegDst = 0;
				MemWr = 1;
				RegWr = 0;
				RegWr_4 = 1;
				RegWr_3 = 1;
				RegWr_2 = 1;
				RegWr_1 = 1;
				MemtoReg = 1;
				Branch = 0;
				Jump = 0;
				l_r = 0;
				lorr = 0;
				OVSel = 0;
				ALUop = 4'b0000;
				shift = 0;	
			end	
			6'b000110://blez
			begin
				ExtOp = 1;
				ALUSrc = 0;
				RegDst = 0;
				MemWr = 0;
				RegWr = 0;
				RegWr_4 = 1;
				RegWr_3 = 1;
				RegWr_2 = 1;
				RegWr_1 = 1;
				MemtoReg = 1;
				Branch = 1;
				Jump = 0;
				l_r = 0;
				lorr = 0;
				OVSel = 0;
				ALUop = 4'b0001;
				shift = 0;	
			end	
			6'b000010:
			begin
				ExtOp = 1;
				ALUSrc = 1;
				RegDst = 0;
				MemWr = 0;
				RegWr = 0;
				RegWr_4 = 1;
				RegWr_3 = 1;
				RegWr_2 = 1;
				RegWr_1 = 1;
				MemtoReg = 1;
				Branch = 0;
				Jump = 1;
				l_r = 0;
				lorr = 0;
				OVSel = 0;
				ALUop = 4'b0000;
				shift = 0;	
			end			
		endcase
		if(Inst == 0)
		begin
			ExtOp = 0;
			ALUSrc = 0;
			RegDst = 0;
			MemWr = 0;
			RegWr = 0;
			RegWr_4 = 0;
			RegWr_3 = 0;
			RegWr_2 = 0;
			RegWr_1 = 0;	
			MemtoReg = 0;
			Branch = 0;
			Jump = 0;	
			lorr = 0;
			shift = 0;	
			OVSel = 0;
			l_r = 0;
			ALUop = 0;	
		end	
	end
	
endmodule

module MUX2_32b(a, b, signal, f);
	input [31:0] a;
	input [31:0] b;
	input signal;
	output reg [31:0] f;
	
	always @(*)
	begin
		if(signal == 1)
			f = a;
		else
			f = b;
	end
	
endmodule

module MUX2_5b(a, b, signal, f);
	input [4:0] a;
	input [4:0] b;
	input signal;
	output reg [4:0] f;
	
	always @(*)
	begin
		if(signal == 1)
			f = a;
		else
			f = b;
	end
	
endmodule

module MUX2_1b(a, b, signal, f);
	input a;
	input b;
	input signal;
	output reg f;
	
	always @(*)
	begin
		if(signal == 1)
			f = a;
		else
			f = b;
	end
	
endmodule

module MUX3_32b(a, b, c, signal, f);
	input [31:0] a, b, c;
	input [1:0] signal;
	output reg [31:0] f;
	
	always @(*)
	begin
		case (signal)
			0: f = a;
			1: f = b;
			2: f = c;
		endcase
	end
endmodule

module MUX4_32b(a, b, c, d, signal, f);
	input [31:0] a, b, c, d;
	input [1:0] signal;
	output reg [31:0] f;
	
	always @(*)
	begin
		case (signal)
			0: f = a;
			1: f = b;
			2: f = c;
			3: f = d;
		endcase
	end
endmodule

module trans(d_Mem, d_Wr, rs, rt, RegWr_Mem, RegWr_Wr, ALUSrc, ALUSrcA, ALUSrcB);
	input [4:0] d_Mem, d_Wr, rs, rt;
	input RegWr_Mem, RegWr_Wr, ALUSrc;
	output reg [1:0] ALUSrcA, ALUSrcB;
	
	always @(*)
	begin
		if(RegWr_Mem == 1 && d_Mem == rs)
			ALUSrcA = 1;
		else if(RegWr_Wr == 1 && d_Wr == rs)
			ALUSrcA = 2;
		else
			ALUSrcA = 0;
		if(ALUSrc == 1)
			ALUSrcB = 3;		
		else if(RegWr_Mem == 1 && d_Mem == rt)
			ALUSrcB = 1;
		else if(RegWr_Wr == 1 && d_Wr == rt)
			ALUSrcB = 2;
		else
			ALUSrcB = 0;
	end
endmodule

module jumpctr(Jump, IF_ID_CLR, ID_EX_CLR);
	input Jump;
	output reg IF_ID_CLR, ID_EX_CLR;
	
	always @(*)
	begin
		if(Jump == 1)
		begin
			IF_ID_CLR = 1;
			ID_EX_CLR = 1;
		end
		else
		begin
			IF_ID_CLR = 0;
			ID_EX_CLR = 0;
		end
	end
endmodule

module blezctr(Branch, IF_ID_CLR, ID_EX_CLR, EX_MEM_CLR);
	input Branch;
	output reg IF_ID_CLR, ID_EX_CLR, EX_MEM_CLR;
	
	always @(*)
	begin
		if(Branch == 1)
		begin
			IF_ID_CLR = 1;
			ID_EX_CLR = 1;
			EX_MEM_CLR = 1;
		end
		else
		begin
			IF_ID_CLR = 0;
			ID_EX_CLR = 0;
			EX_MEM_CLR = 0;
		end
	end
endmodule
		