module Shifter_Barrel( result, leftRight, shamt, sftSrc );
    
  output wire[15:0] result;

  input wire leftRight;
  input wire[3:0] shamt;
  input wire[15:0] sftSrc;

  wire[15:0] L32, R32, L10, R10;

  // 4-to-1 MUX (left) shamt 2^3 and 2^2
  assign L32[0] = (shamt[3:2]==2'b00) ? sftSrc[0] : 0;
  assign L32[1] = (shamt[3:2]==2'b00) ? sftSrc[1] : 0;
  assign L32[2] = (shamt[3:2]==2'b00) ? sftSrc[2] : 0;
  assign L32[3] = (shamt[3:2]==2'b00) ? sftSrc[3] : 0;
  assign L32[4] = (shamt[3:2]==2'b00) ? sftSrc[4] :
          (shamt[3:2]==2'b01) ? sftSrc[0] : 0;
  assign L32[5] = (shamt[3:2]==2'b00) ? sftSrc[5] :
          (shamt[3:2]==2'b01) ? sftSrc[1] : 0;
  assign L32[6] = (shamt[3:2]==2'b00) ? sftSrc[6] :
          (shamt[3:2]==2'b01) ? sftSrc[2] : 0;
  assign L32[7] = (shamt[3:2]==2'b00) ? sftSrc[7] :
          (shamt[3:2]==2'b01) ? sftSrc[3] : 0;
  assign L32[8] = (shamt[3:2]==2'b00) ? sftSrc[8] :
          (shamt[3:2]==2'b01) ? sftSrc[4] :
          (shamt[3:2]==2'b10) ? sftSrc[0] : 0;
  assign L32[9] = (shamt[3:2]==2'b00) ? sftSrc[9] :
          (shamt[3:2]==2'b01) ? sftSrc[5] :
          (shamt[3:2]==2'b10) ? sftSrc[1] : 0;
  assign L32[10] = (shamt[3:2]==2'b00) ? sftSrc[10] :
          (shamt[3:2]==2'b01) ? sftSrc[6] :
          (shamt[3:2]==2'b10) ? sftSrc[2] : 0;
  assign L32[11] = (shamt[3:2]==2'b00) ? sftSrc[11] :
          (shamt[3:2]==2'b01) ? sftSrc[7] :
          (shamt[3:2]==2'b10) ? sftSrc[3] : 0;
  assign L32[12] = (shamt[3:2]==2'b00) ? sftSrc[12] :
          (shamt[3:2]==2'b01) ? sftSrc[8] :
          (shamt[3:2]==2'b10) ? sftSrc[4] : sftSrc[0];
  assign L32[13] = (shamt[3:2]==2'b00) ? sftSrc[13] :
          (shamt[3:2]==2'b01) ? sftSrc[9] :
          (shamt[3:2]==2'b10) ? sftSrc[5] : sftSrc[1];
  assign L32[14] = (shamt[3:2]==2'b00) ? sftSrc[14] :
          (shamt[3:2]==2'b01) ? sftSrc[10] :
          (shamt[3:2]==2'b10) ? sftSrc[6] : sftSrc[2];
  assign L32[15] = (shamt[3:2]==2'b00) ? sftSrc[15] :
          (shamt[3:2]==2'b01) ? sftSrc[11] :
          (shamt[3:2]==2'b10) ? sftSrc[7] : sftSrc[3];
  // 4-to-1 MUX shamt 2^1 and 2^0 (left)
  assign L10[0] = (shamt[1:0]==2'b00) ? L32[0] : 0;
  assign L10[1] = (shamt[1:0]==2'b00) ? L32[1] :
          (shamt[1:0]==2'b01) ? L32[0] : 0;
  assign L10[2] = (shamt[1:0]==2'b00) ? L32[2] :
          (shamt[1:0]==2'b01) ? L32[1] :
          (shamt[1:0]==2'b10) ? L32[0] : 0;
  assign L10[3] = (shamt[1:0]==2'b00) ? L32[3] :
          (shamt[1:0]==2'b01) ? L32[2] :
          (shamt[1:0]==2'b10) ? L32[1] : L32[0];
  assign L10[4] = (shamt[1:0]==2'b00) ? L32[4] :
          (shamt[1:0]==2'b01) ? L32[3] :
          (shamt[1:0]==2'b10) ? L32[2] : L32[1];
  assign L10[5] = (shamt[1:0]==2'b00) ? L32[5] :
          (shamt[1:0]==2'b01) ? L32[4] :
          (shamt[1:0]==2'b10) ? L32[3] : L32[2];
  assign L10[6] = (shamt[1:0]==2'b00) ? L32[6] :
          (shamt[1:0]==2'b01) ? L32[5] :
          (shamt[1:0]==2'b10) ? L32[4] : L32[3];
  assign L10[7] = (shamt[1:0]==2'b00) ? L32[7] :
          (shamt[1:0]==2'b01) ? L32[6] :
          (shamt[1:0]==2'b10) ? L32[5] : L32[4];
  assign L10[8] = (shamt[1:0]==2'b00) ? L32[8] :
          (shamt[1:0]==2'b01) ? L32[7] :
          (shamt[1:0]==2'b10) ? L32[6] : L32[5];
  assign L10[9] = (shamt[1:0]==2'b00) ? L32[9] :
          (shamt[1:0]==2'b01) ? L32[8] :
          (shamt[1:0]==2'b10) ? L32[7] : L32[6];
  assign L10[10] = (shamt[1:0]==2'b00) ? L32[10] :
          (shamt[1:0]==2'b01) ? L32[9] :
          (shamt[1:0]==2'b10) ? L32[8] : L32[7];
  assign L10[11] = (shamt[1:0]==2'b00) ? L32[11] :
          (shamt[1:0]==2'b01) ? L32[10] :
          (shamt[1:0]==2'b10) ? L32[9] : L32[8];
  assign L10[12] = (shamt[1:0]==2'b00) ? L32[12] :
          (shamt[1:0]==2'b01) ? L32[11] :
          (shamt[1:0]==2'b10) ? L32[10] : L32[9];
  assign L10[13] = (shamt[1:0]==2'b00) ? L32[13] :
          (shamt[1:0]==2'b01) ? L32[12] :
          (shamt[1:0]==2'b10) ? L32[11] : L32[10];
  assign L10[14] = (shamt[1:0]==2'b00) ? L32[14] :
          (shamt[1:0]==2'b01) ? L32[13] :
          (shamt[1:0]==2'b10) ? L32[12] : L32[11];
  assign L10[15] = (shamt[1:0]==2'b00) ? L32[15] :
          (shamt[1:0]==2'b01) ? L32[14] :
          (shamt[1:0]==2'b10) ? L32[13] : L32[12];

  // 4-to-1 MUX (right) shamt 2^3 and 2^2
  assign R32[15] = (shamt[3:2]==2'b00) ? sftSrc[15] : 0;
  assign R32[14] = (shamt[3:2]==2'b00) ? sftSrc[14] : 0;
  assign R32[13] = (shamt[3:2]==2'b00) ? sftSrc[13] : 0;
  assign R32[12] = (shamt[3:2]==2'b00) ? sftSrc[12] : 0;
  assign R32[11] = (shamt[3:2]==2'b00) ? sftSrc[11] :
          (shamt[3:2]==2'b01) ? sftSrc[15] : 0;
  assign R32[10] = (shamt[3:2]==2'b00) ? sftSrc[10] :
          (shamt[3:2]==2'b01) ? sftSrc[14] : 0;
  assign R32[9] = (shamt[3:2]==2'b00) ? sftSrc[9] :
          (shamt[3:2]==2'b01) ? sftSrc[13] : 0;
  assign R32[8] = (shamt[3:2]==2'b00) ? sftSrc[8] :
          (shamt[3:2]==2'b01) ? sftSrc[12] : 0;
  assign R32[7] = (shamt[3:2]==2'b00) ? sftSrc[7] :
          (shamt[3:2]==2'b01) ? sftSrc[11] :
          (shamt[3:2]==2'b10) ? sftSrc[15] : 0;
  assign R32[6] = (shamt[3:2]==2'b00) ? sftSrc[6] :
          (shamt[3:2]==2'b01) ? sftSrc[10] :
          (shamt[3:2]==2'b10) ? sftSrc[14] : 0;
  assign R32[5] = (shamt[3:2]==2'b00) ? sftSrc[5] :
          (shamt[3:2]==2'b01) ? sftSrc[9] :
          (shamt[3:2]==2'b10) ? sftSrc[13] : 0;
  assign R32[4] = (shamt[3:2]==2'b00) ? sftSrc[4] :
          (shamt[3:2]==2'b01) ? sftSrc[8] :
          (shamt[3:2]==2'b10) ? sftSrc[12] : 0;
  assign R32[3] = (shamt[3:2]==2'b00) ? sftSrc[3] :
          (shamt[3:2]==2'b01) ? sftSrc[7] :
          (shamt[3:2]==2'b10) ? sftSrc[11] : sftSrc[15];
  assign R32[2] = (shamt[3:2]==2'b00) ? sftSrc[2] :
          (shamt[3:2]==2'b01) ? sftSrc[6] :
          (shamt[3:2]==2'b10) ? sftSrc[10] : sftSrc[14];
  assign R32[1] = (shamt[3:2]==2'b00) ? sftSrc[1] :
          (shamt[3:2]==2'b01) ? sftSrc[5] :
          (shamt[3:2]==2'b10) ? sftSrc[9] : sftSrc[13];
  assign R32[0] = (shamt[3:2]==2'b00) ? sftSrc[0] :
          (shamt[3:2]==2'b01) ? sftSrc[4] :
          (shamt[3:2]==2'b10) ? sftSrc[8] : sftSrc[12];
  // 4-to-1 MUX shamt 2^1 and 2^0
  assign R10[15] = (shamt[1:0]==2'b00) ? R32[15] : 0;
  assign R10[14] = (shamt[1:0]==2'b00) ? R32[14] :
          (shamt[1:0]==2'b01) ? R32[15] : 0;
  assign R10[13] = (shamt[1:0]==2'b00) ? R32[13] :
          (shamt[1:0]==2'b01) ? R32[14] :
          (shamt[1:0]==2'b10) ? R32[15] : 0;
  assign R10[12] = (shamt[1:0]==2'b00) ? R32[12] :
          (shamt[1:0]==2'b01) ? R32[13] :
          (shamt[1:0]==2'b10) ? R32[14] : R32[15];
  assign R10[11] = (shamt[1:0]==2'b00) ? R32[11] :
          (shamt[1:0]==2'b01) ? R32[12] :
          (shamt[1:0]==2'b10) ? R32[13] : R32[14];
  assign R10[10] = (shamt[1:0]==2'b00) ? R32[10] :
          (shamt[1:0]==2'b01) ? R32[11] :
          (shamt[1:0]==2'b10) ? R32[12] : R32[13];
  assign R10[9] = (shamt[1:0]==2'b00) ? R32[9] :
          (shamt[1:0]==2'b01) ? R32[10] :
          (shamt[1:0]==2'b10) ? R32[11] : R32[12];
  assign R10[8] = (shamt[1:0]==2'b00) ? R32[8] :
          (shamt[1:0]==2'b01) ? R32[9] :
          (shamt[1:0]==2'b10) ? R32[10] : R32[11];
  assign R10[7] = (shamt[1:0]==2'b00) ? R32[7] :
          (shamt[1:0]==2'b01) ? R32[8] :
          (shamt[1:0]==2'b10) ? R32[9] : R32[10];
  assign R10[6] = (shamt[1:0]==2'b00) ? R32[6] :
          (shamt[1:0]==2'b01) ? R32[7] :
          (shamt[1:0]==2'b10) ? R32[8] : R32[9];
  assign R10[5] = (shamt[1:0]==2'b00) ? R32[5] :
          (shamt[1:0]==2'b01) ? R32[6] :
          (shamt[1:0]==2'b10) ? R32[7] : R32[8];
  assign R10[4] = (shamt[1:0]==2'b00) ? R32[4] :
          (shamt[1:0]==2'b01) ? R32[5] :
          (shamt[1:0]==2'b10) ? R32[6] : R32[7];
  assign R10[3] = (shamt[1:0]==2'b00) ? R32[3] :
          (shamt[1:0]==2'b01) ? R32[4] :
          (shamt[1:0]==2'b10) ? R32[5] : R32[6];
  assign R10[2] = (shamt[1:0]==2'b00) ? R32[2] :
          (shamt[1:0]==2'b01) ? R32[3] :
          (shamt[1:0]==2'b10) ? R32[4] : R32[5];
  assign R10[1] = (shamt[1:0]==2'b00) ? R32[1] :
          (shamt[1:0]==2'b01) ? R32[2] :
          (shamt[1:0]==2'b10) ? R32[3] : R32[4];
  assign R10[0] = (shamt[1:0]==2'b00) ? R32[0] :
          (shamt[1:0]==2'b01) ? R32[1] :
          (shamt[1:0]==2'b10) ? R32[2] : R32[3];

  // 2-to-1 MUX
  assign result = (leftRight==0) ? R10 : L10;
endmodule