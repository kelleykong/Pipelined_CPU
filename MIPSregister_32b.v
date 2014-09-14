module MIPSregister_32b(sadd1, sadd2, dadd, data, wen, wen_4, wen_3, wen_2, wen_1, clk, sdata1, sdata2);
	input [4:0] sadd1;
	input [4:0] sadd2;
	input [4:0] dadd;
	input [31:0] data;
	input wen;
	input wen_4;
	input wen_3;
	input wen_2;
	input wen_1;
	input clk;
	output [31:0] sdata1;
	output [31:0] sdata2;
	
	reg [31:0] mem[31:0];
	
	always @(posedge clk)
	begin
		if(wen == 1 && dadd != 0)
		begin
			if(wen_4 == 1)
				mem[dadd][31:24] <= data[31:24];
			if(wen_3 == 1)
				mem[dadd][23:16] <= data[23:16];
			if(wen_2 == 1)
				mem[dadd][15:8] <= data[15:8];
			if(wen_1 == 1)
				mem[dadd][7:0] <= data[7:0];
		end
	end	
	assign sdata1 = mem[sadd1];
	assign sdata2 = mem[sadd2];		
endmodule	

module Reg(clk, signal, data, q);
	input clk, signal;
	input [31:0] data;
	output reg [31:0] q;
	
	always@(posedge clk)
	begin
		if(signal == 1)
			q <= data;
		else
			q <= q;
	end
	
endmodule
