module RAM(clk, addr, data, we, q);
	input [31:0] addr;
	input [31:0] data;
	input we, clk;
	output [31:0] q;

	reg [7:0] ram[2**8-1:0];

	integer i;
	
	initial
	begin
		for (i = 136; i< 256; i = i +1)
			ram[i] = 0;
		{ram[3], ram[2], ram[1], ram[0]}     = 32'b00100000000000010000000000000011; //addi R1 = 3
		{ram[7], ram[6], ram[5], ram[4]}     = 32'b00100000000000100000000000000101; //addi R2 = 5
		{ram[11], ram[10], ram[9], ram[8]}   = 32'b00100000000000110000000000000111; //addi R3 = 7
		{ram[15], ram[14], ram[13], ram[12]} = 32'b00100000000011000000000000000010; //addi R12 = 2
		{ram[19], ram[18], ram[17], ram[16]} = 32'b00100000000011011111111111111111; //addiu R13 = 32'hFFFFFFFF
		{ram[23], ram[22], ram[21], ram[20]} = 32'b00000000000011010010000001000011; // sra R4 = R13 >> 1 ,R4 = 32'h7FFFFFFF
		{ram[27], ram[26], ram[25], ram[24]} = 32'b00100000000011100000000000011011;//addi R14 =27
		{ram[31], ram[30], ram[29], ram[28]} = 32'b00100000000011110000000000011000;//addi R15 =24
		{ram[35], ram[34], ram[33], ram[32]} = 32'b00000001110011010011100000000100;//sllv R7 = R13 << (R14), R7 =32'hF8000000
		{ram[39], ram[38], ram[37], ram[36]} = 32'b00000001111000010100000000000100;//sllv R8 = R1 << (R15), R8 = 32'h03000000 
		{ram[43], ram[42], ram[41], ram[40]} = 32'b00000000001001000010100000100001;//addu R5 = R1 + R4
		{ram[47], ram[46], ram[45], ram[44]} = 32'b00000000000001010010100000100001;//addu R5 = R5 + R0
		{ram[51], ram[50], ram[49], ram[48]} = 32'b00000000001001000011000000100000;//add  R6 = R1 + R4
		{ram[55], ram[54], ram[53], ram[52]} = 32'b00000000000001100011000000100001;//addu R6 = R6 + R0
		{ram[59], ram[58], ram[57], ram[56]} = 32'b00100000001001010000000000000100;//addi   R5 = R1 + imm
		{ram[63], ram[62], ram[61], ram[60]} = 32'b00100100001001010000000000001000;//addiu  R5 = R1 + imm
		{ram[67], ram[66], ram[65], ram[64]} = 32'b00000000000001110010100000100010;//sub  R5 = R0 - R7
		{ram[71], ram[70], ram[69], ram[68]} = 32'b00000000010000010010100000100011;//subu R5 = R2 - R1
		{ram[75], ram[74], ram[73], ram[72]} = 32'b01110000111000000100100000100001;//clo  R9 = R7...
		{ram[79], ram[78], ram[77], ram[76]} = 32'b01110001000000000101000000100000;//clz  R10= R8...
		{ram[83], ram[82], ram[81], ram[80]} = 32'b00000000100001110110000000101010;//slt  R12= R4..R7
		{ram[87], ram[86], ram[85], ram[84]} = 32'b00000000100001110110000000101011;//sltu R12= R4..R7
		{ram[91], ram[90], ram[89], ram[88]} = 32'b00101000001011001111111111111100;//slti   R12= R1..imm
		{ram[95], ram[94], ram[93], ram[92]} = 32'b00101100001011001111111111111100;//sltiu  R12= R1..imm
		{ram[99], ram[98], ram[97], ram[96]} = 32'b00000000100010000101100000100111;//nor  R11= R8..R4
		{ram[103], ram[102], ram[101], ram[100]} = 32'b00111000100011001111111111111100;//xori   R12= R8..imm
		{ram[107], ram[106], ram[105], ram[104]} = 32'b00000000011001000010100000000100; //sllv R5 = R4 << (R3) 
		{ram[111], ram[110], ram[109], ram[108]} = 32'b00000000000001110010110100000011; //sra  R5 = R7 >> 20
		//{ram[75], ram[74], ram[73], ram[72]} = 32'b00001000000000000000000000000000; //j
		/*{ram[75], ram[74], ram[73], ram[72]} = 32'b10101100000001010000000000000000; //sw M(0) = R5
		{ram[79], ram[78], ram[77], ram[76]} = 32'b00000000000001010010100000100001; //addu R5 = R5 + R0
		{ram[83], ram[82], ram[81], ram[80]} = 32'b00001000000000000000000000000000; //j */
		
		{ram[115], ram[114], ram[113], ram[112]} = 32'b10001100000001010000000000000100;//lw R5 = M(4) 
		{ram[119], ram[118], ram[117], ram[116]} = 32'b10101100000001100000000001011000;//sw M(88) = R6
		{ram[123], ram[122], ram[121], ram[120]} = 32'b10001000000010100000000000100010;// lwl R10 = M(34)..
		{ram[127], ram[126], ram[125], ram[124]} = 32'b10011000000010100000000000001001;// lwr R10 = M(9)..
	
		{ram[131], ram[130], ram[129], ram[128]} = 32'b00011001101000001111111111111110;//blez
		{ram[135], ram[134], ram[133], ram[132]} = 32'b00000000000000000000000000000000;//j


	
	end

	always @ (posedge clk)
	begin
		if(we == 1)
		begin
			ram[addr+3] <= data[31:24];
			ram[addr+2] <= data[23:16];
			ram[addr+1] <= data[15:8];
			ram[addr] <= data[7:0];
		end				
	end	
	assign q = {ram[addr+3], ram[addr+2], ram[addr+1], ram[addr]};
endmodule

