module ALU( aluSrc1, aluSrc2, ALU_operation_i, result, zero, overflow );

//I/O ports 
input	[15:0]  aluSrc1;
input	[15:0]  aluSrc2;
input	[4-1:0] ALU_operation_i;

output	[15:0]  result;
output		    zero;
output		    overflow;

//Internal Signals
wire		    zero;
wire            overflow;
wire    [16-1:0]result;

//Main function
wire invertA = ALU_operation_i[3];
wire invertB = ALU_operation_i[2];

// set on less than (using subtraction to achieve)
wire Set;
assign Set = (aluSrc1[15]^aluSrc2[15]==1) ? aluSrc1[15] : (aluSrc1[15]^(~aluSrc2[15])^carry[14]);
// when (N-P) or (P-N), Set=sign bit of first source. Otherwise, Set=sign bit of subtraction result
// using MUX to implement

wire chkzero; // for checking if the answer is zero, if chkzero==0 in the end, the result is all zero

wire[15:0] carry;

// ripple carry ALU
// carry in for first bit equals to invertB
ALU_1bit  B0(result[0], carry[0], aluSrc1[0], aluSrc2[0], invertA, invertB, ALU_operation_i[1:0], invertB, Set);
ALU_1bit  B1(result[1], carry[1], aluSrc1[1], aluSrc2[1], invertA, invertB, ALU_operation_i[1:0], carry[0], 1'b0);
ALU_1bit  B2(result[2], carry[2], aluSrc1[2], aluSrc2[2], invertA, invertB, ALU_operation_i[1:0], carry[1], 1'b0);
ALU_1bit  B3(result[3], carry[3], aluSrc1[3], aluSrc2[3], invertA, invertB, ALU_operation_i[1:0], carry[2], 1'b0);
ALU_1bit  B4(result[4], carry[4], aluSrc1[4], aluSrc2[4], invertA, invertB, ALU_operation_i[1:0], carry[3], 1'b0);
ALU_1bit  B5(result[5], carry[5], aluSrc1[5], aluSrc2[5], invertA, invertB, ALU_operation_i[1:0], carry[4], 1'b0);
ALU_1bit  B6(result[6], carry[6], aluSrc1[6], aluSrc2[6], invertA, invertB, ALU_operation_i[1:0], carry[5], 1'b0);
ALU_1bit  B7(result[7], carry[7], aluSrc1[7], aluSrc2[7], invertA, invertB, ALU_operation_i[1:0], carry[6], 1'b0);
ALU_1bit  B8(result[8], carry[8], aluSrc1[8], aluSrc2[8], invertA, invertB, ALU_operation_i[1:0], carry[7], 1'b0);
ALU_1bit  B9(result[9], carry[9], aluSrc1[9], aluSrc2[9], invertA, invertB, ALU_operation_i[1:0], carry[8], 1'b0);
ALU_1bit  B10(result[10], carry[10], aluSrc1[10], aluSrc2[10], invertA, invertB, ALU_operation_i[1:0], carry[9], 1'b0);
ALU_1bit  B11(result[11], carry[11], aluSrc1[11], aluSrc2[11], invertA, invertB, ALU_operation_i[1:0], carry[10], 1'b0);
ALU_1bit  B12(result[12], carry[12], aluSrc1[12], aluSrc2[12], invertA, invertB, ALU_operation_i[1:0], carry[11], 1'b0);
ALU_1bit  B13(result[13], carry[13], aluSrc1[13], aluSrc2[13], invertA, invertB, ALU_operation_i[1:0], carry[12], 1'b0);
ALU_1bit  B14(result[14], carry[14], aluSrc1[14], aluSrc2[14], invertA, invertB, ALU_operation_i[1:0], carry[13], 1'b0);
ALU_1bit  B15(result[15], carry[15], aluSrc1[15], aluSrc2[15], invertA, invertB, ALU_operation_i[1:0], carry[14], 1'b0);

// chkzero OR all bits of result
or (chkzero, result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]);
not (zero, chkzero);

xor (overflow, carry[15], carry[14]);// get overflow

endmodule
