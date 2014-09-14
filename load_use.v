module load_use
(
	input ID_EXMemRead,
	input [4:0]ID_EXRt,
	input [4:0]IF_IDRs,
	input [4:0]IF_IDRt,
	output reg ID_EXzero,
	output reg IF_IDhold,
	output reg sel
);

reg C;
always @(*)
begin
	C = ID_EXMemRead && (( ID_EXRt == IF_IDRs) || (ID_EXRt == IF_IDRt));
	if( C == 1 )
	begin
		ID_EXzero = 1;
		IF_IDhold = 1;
		sel = 1;
	end
	else 
	begin
		ID_EXzero = 0;
		IF_IDhold = 0;
		sel = 0;
	end
end
endmodule
