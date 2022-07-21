module ALU_adv( result, zero, overflow, aluSrc1, aluSrc2, invertA, invertB, operation );
  
  output wire[15:0] result;
  output wire zero;
  output wire overflow;

  input wire[15:0] aluSrc1;
  input wire[15:0] aluSrc2;
  input wire invertA;
  input wire invertB;
  input wire[1:0] operation;
  
  // set on less than (using subtraction to achieve)
  wire Set;
  // Set = sign_bit(result[15]) (may cause error when overflow)
  assign Set = (aluSrc1[15]^aluSrc2[15]==1) ? aluSrc1[15] : result[15];
  // when (N-P) or (P-N), Set=sign bit of first source. Otherwise, Set=sign bit of subtraction result
  // using MUX to implement

  wire chkzero; // for checking if the answer is zero, if chkzero==0 in the end, the result is all zero

  wire[16:0] carry;

  // ripple carry ALU
  // carry in for first bit equals to invertB
  ALU_1bit  B0(result[0], carry[1], aluSrc1[0], aluSrc2[0], invertA, invertB, operation, invertB, Set);
  ALU_1bit  B1(result[1], carry[2], aluSrc1[1], aluSrc2[1], invertA, invertB, operation, carry[1], 1'b0);
  ALU_1bit  B2(result[2], carry[3], aluSrc1[2], aluSrc2[2], invertA, invertB, operation, carry[2], 1'b0);
  ALU_1bit  B3(result[3], carry[4], aluSrc1[3], aluSrc2[3], invertA, invertB, operation, carry[3], 1'b0);
  ALU_1bit  B4(result[4], carry[5], aluSrc1[4], aluSrc2[4], invertA, invertB, operation, carry[4], 1'b0);
  ALU_1bit  B5(result[5], carry[6], aluSrc1[5], aluSrc2[5], invertA, invertB, operation, carry[5], 1'b0);
  ALU_1bit  B6(result[6], carry[7], aluSrc1[6], aluSrc2[6], invertA, invertB, operation, carry[6], 1'b0);
  ALU_1bit  B7(result[7], carry[8], aluSrc1[7], aluSrc2[7], invertA, invertB, operation, carry[7], 1'b0);
  ALU_1bit  B8(result[8], carry[9], aluSrc1[8], aluSrc2[8], invertA, invertB, operation, carry[8], 1'b0);
  ALU_1bit  B9(result[9], carry[10], aluSrc1[9], aluSrc2[9], invertA, invertB, operation, carry[9], 1'b0);
  ALU_1bit  B10(result[10], carry[11], aluSrc1[10], aluSrc2[10], invertA, invertB, operation, carry[10], 1'b0);
  ALU_1bit  B11(result[11], carry[12], aluSrc1[11], aluSrc2[11], invertA, invertB, operation, carry[11], 1'b0);
  ALU_1bit  B12(result[12], carry[13], aluSrc1[12], aluSrc2[12], invertA, invertB, operation, carry[12], 1'b0);
  ALU_1bit  B13(result[13], carry[14], aluSrc1[13], aluSrc2[13], invertA, invertB, operation, carry[13], 1'b0);
  ALU_1bit  B14(result[14], carry[15], aluSrc1[14], aluSrc2[14], invertA, invertB, operation, carry[14], 1'b0);
  ALU_1bit  B15(result[15], carry[16], aluSrc1[15], aluSrc2[15], invertA, invertB, operation, carry[15], 1'b0);
  // Throw out ALU_1bit_MSB because it will let Set "always" equal to sign bit.

  // chkzero OR all bits of result
  or (chkzero, result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]);
  not (zero, chkzero);

  xor (overflow, carry[16], carry[15]);// get overflow
endmodule