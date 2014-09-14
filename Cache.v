module Cache(clk, addr, data, we, RAM_out, q);
	input [31:0] addr;
	input [31:0] data;
	input we, clk;
	input [31: 0]RAM_out;
	output [31:0] q;
	
	reg [7:0] cache_ram[2**5 - 1: 0]; //4B * 8 Blocks
	reg [29: 0] block[2**3 - 1: 0];//block addr
	reg [4: 0]cache_addr;
	
	initial
	begin
		integer i;
		for (i = 0; i < 2**3 - 1; i = i + 1)
			block[i] <= 32'hffffffff;
	end
	
	always @ (posedge clk)
	begin
		cache_addr <= addr[4: 0];
		if (addr[31: 2] == block[cache_addr[4: 2]]) //in cache!
		begin
			if (we) //Cache always do the writings
			begin
				cache_ram[cache_addr] <= data[7: 0];
				cache_ram[cache_addr + 1] <= data[15: 8];
				cache_ram[cache_addr + 2] <= data[23: 16];
				cache_ram[cache_addr + 3] <= data[31: 24];
			end
		end
		else
		begin
			block[cache_addr[4: 2]] <= addr[31: 2];
			cache_ram[cache_addr] <= RAM_out[7: 0];
			cache_ram[cache_addr + 1] <= RAM_out[15: 8];
			cache_ram[cache_addr + 2] <= RAM_out[23: 16];
			cache_ram[cache_addr + 3] <= RAM_out[31: 24];
		end
	end
	
	assign q = {cache_ram[cache_addr + 3], cache_ram[cache_addr + 2], cache_ram[cache_addr + 1], cache_ram[cache_addr]};
	
endmodule
