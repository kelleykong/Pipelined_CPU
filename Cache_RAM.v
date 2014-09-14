module Cache_RAM(clk, addr, data, we, q);
	input [31:0] addr;
	input [31:0] data;
	input we, clk;
	output [31:0] q;
	
	wire [31: 0]RAM_out;

	RAM DataRAM(.clk(clk), .addr(addr), .data(data), .we(we), .q(RAM_out));
	Cache DataCache(.clk(clk), .addr(addr), .data(data), .we(we), .RAM_out(RAM_out), .q(q));
	
endmodule
