module MIPSALU32(A, B, shift, ALUop, less, zero, result, overflow);
	input [31:0] A;
	input [31:0] B;
	input [4:0] shift;
	input [3:0] ALUop;
	output reg less;
	output reg zero;
	output reg [31:0] result;
	output reg overflow;
	
	wire [2:0] ALUctr;
	reg [31:0] r;
	reg [31:0] result_f;
	wire [31:0] result_f2;
	reg [31:0] C;
	
	integer i;
	
	MIPSALUctr digit1(ALUop, ALUctr);
	barrel_shift_32(B, shift, ALUop[0], 1, result_f2);
	
	always @(*)
	begin
		for(i = 0; i < 32; i = i + 1)
			r[i] = B[i] ^ ALUop[0];
	
		{C[0],result_f[0]} = A[0] + r[0] + ALUop[0];	
		for(i = 1; i < 32; i = i + 1)
			{C[i],result_f[i]} = A[i] + r[i] + C[i-1];
		overflow = C[31] ^ C[30];
		
		if(result_f == 0)
			zero = 1;
		else 
			zero = 0;
		
		if(ALUop[1] == 1)	
			less = ALUop[0] ^ C[31]; 
		else
			less = result_f[31] ^ overflow;
		
		case (ALUctr)
			0:
			begin
				result = 32;
				for(i = 0; i < 32; i = i + 1)
				begin
					r[31 - i] = A[31 - i] ^ ALUop[0];
					if(r[31 - i] != 0 && result == 32)
					begin
						result = i;
					end
				end
			end
			1:
			for(i = 0; i < 32; i = i + 1)
				result[i] = A[i] ^ B[i];
			2:
			for(i = 0; i < 32; i = i + 1)
				result[i] = A[i] | B[i];
			3:
			for(i = 0; i < 32; i = i + 1)
				result[i] = ~(A[i] | B[i]);
			4:
			result = A;
			5:
			result = less;
			6:
			result = result_f;
			7:
			result = result_f2;
		endcase
	end
	
endmodule


module barrel_shift_32(datain, shift, l_r, extop, dataout);
	input [31:0] datain;
	input [4:0] shift;
	input l_r;
	input extop;
	output [31:0] dataout;

	integer n;
	reg [31:0] d;
	
	always @(*)
	begin
		d = datain;
		if(l_r == 0)    //right shift
		begin
			if(extop == 0)    //logic right shift
			begin
				if(shift[0] == 1)
				begin
					for(n = 0; n < 31; n = n + 1)
						d[n] = d[n + 1];
					d[31] = 0;
				end
				if(shift[1] == 1)
				begin
					for(n = 0; n < 30; n = n + 1)
						d[n] = d[n + 2];
					d[30] = 0;
					d[31] = 0;
				end
				if(shift[2] == 1)
				begin
					for(n = 0; n < 28; n = n + 1)
						d[n] = d[n + 4];
					d[28] = 0;
					d[29] = 0;
					d[30] = 0;
					d[31] = 0;
				end
				if(shift[3] == 1)
				begin
					for(n = 0; n < 31; n = n + 1)
					begin
						if(n + 8 > 31)
							d[n] = 0;
						else
							d[n] = d[n + 8];
					end
				end
				if(shift[4] == 1)
				begin
					for(n = 0; n < 31; n = n + 1)
					begin
						if(n + 16 > 31)
							d[n] = 0;
						else
							d[n] = d[n + 16];
					end
				end				
			end
			else              //arithmetic right shift
			begin
				if(shift[0] == 1)
				begin
					for(n = 0; n < 31; n = n + 1)
						d[n] = d[n + 1];
				end
				if(shift[1] == 1)
				begin
					for(n = 0; n < 30; n = n + 1)
						d[n] = d[n + 2];
					d[30] = d[31];
				end
				if(shift[2] == 1)
				begin
					for(n = 0; n < 28; n = n + 1)
						d[n] = d[n + 4];
					d[28] = d[31];
					d[29] = d[31];
					d[30] = d[31];	
				end
				if(shift[3] == 1)
				begin
					for(n = 0; n < 31; n = n + 1)
					begin
						if(n + 8 > 31)
							d[n] = d[31];
						else
							d[n] = d[n + 8];
					end
				end
				if(shift[4] == 1)
				begin
					for(n = 0; n < 31; n = n + 1)
					begin
						if(n + 16 > 31)
							d[n] = d[31];
						else
							d[n] = d[n + 16];
					end
				end								
			end		
		end
		else
		begin
			if(shift[0] == 1)
			begin
				for(n = 31; n > 0; n = n - 1)
					d[n] = d[n-1];
				d[0] = 0;
			end
			if(shift[1] == 1)
			begin
				for(n = 31; n > 1; n = n - 1)
					d[n] = d[n-2];
				d[1] = 0;
				d[0] = 0;
			end
			if(shift[2] == 1)
			begin
				for(n = 31; n > 3; n = n - 1)
					d[n] = d[n-4];
				d[3] = 0;
				d[2] = 0;
				d[1] = 0;
				d[0] = 0;
			end
			if(shift[3] == 1)
			begin
				for(n = 31; n >= 0; n = n - 1)
				begin
					if(n - 8 < 0)
						d[n] = 0;
					else 
						d[n] = d[n - 8];
				end
			end
			if(shift[4] == 1)
			begin
				for(n = 31; n >= 0; n = n - 1)
				begin
					if(n - 16 < 0)
						d[n] = 0;
					else 
						d[n] = d[n - 16];
				end
			end					
		end
	end
	
	assign dataout = d;
	
endmodule

module MIPSALUctr(ALUop, ALUctr);
	input [3:0] ALUop;
	output [2:0] ALUctr;
	
	assign ALUctr[2] = ~ALUop[3] & ~ALUop[1] | ~ALUop[3] & ALUop[2] & ALUop[0] | ALUop[3] & ~ALUop[2] & ALUop[1];
	assign ALUctr[1] = ~ALUop[3] & ~ALUop[2] & ~ALUop[1] | ~ALUop[3] & ALUop[2] & ALUop[1] & ~ALUop[0] | ~ALUop[2] & ~ALUop[1] & ~ALUop[0] | ALUop[3] & ~ALUop[2] & ALUop[1];
	assign ALUctr[0] = ALUop[3] & ~ALUop[2] | ~ALUop[3] & ALUop[2] & ALUop[0];
	
endmodule
	
