module regMEM_WR
(
	input clk,
	input overflow,
	input [31:0]Dout,
	input [31:0]result,
	input [4:0]Rw,
	input RegWr,
	input RegWr_4,RegWr_3,RegWr_2,RegWr_1,
	input MemtoReg,
	input OvSel,
	output reg overflow_f,
	output reg [31:0]Dout_f,
	output reg [31:0]result_f,
	output reg [4:0]Rw_f,
	output reg RegWr_f,
	output reg RegWr_4f,RegWr_3f,RegWr_2f,RegWr_1f,
	output reg MemtoReg_f,
	output reg OvSel_f
);

always@(posedge clk)
begin
	overflow_f = overflow;
	Dout_f = Dout;
	result_f = result;
	Rw_f = Rw;
	RegWr_f = RegWr;
	MemtoReg_f = MemtoReg;
	OvSel_f = OvSel;
	RegWr_4f = RegWr_4;
	RegWr_3f = RegWr_3;
	RegWr_2f = RegWr_2;
	RegWr_1f = RegWr_1;
end

endmodule
