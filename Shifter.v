module Shifter( result, leftRight, sftSrc );

//I/O ports 
output	[16-1:0] result;

input			leftRight;
input	[16-1:0] sftSrc ;

//Internal Signals
wire	[16-1:0] result;
  
//Main function
assign result[0] = (leftRight==0) ? sftSrc[1] : 0;
assign result[1] = (leftRight==0) ? sftSrc[2] : sftSrc[0];
assign result[2] = (leftRight==0) ? sftSrc[3] : sftSrc[1];
assign result[3] = (leftRight==0) ? sftSrc[4] : sftSrc[2];
assign result[4] = (leftRight==0) ? sftSrc[5] : sftSrc[3];
assign result[5] = (leftRight==0) ? sftSrc[6] : sftSrc[4];
assign result[6] = (leftRight==0) ? sftSrc[7] : sftSrc[5];
assign result[7] = (leftRight==0) ? sftSrc[8] : sftSrc[6];
assign result[8] = (leftRight==0) ? sftSrc[9] : sftSrc[7];
assign result[9] = (leftRight==0) ? sftSrc[10] : sftSrc[8];
assign result[10] = (leftRight==0) ? sftSrc[11] : sftSrc[9];
assign result[11] = (leftRight==0) ? sftSrc[12] : sftSrc[10];
assign result[12] = (leftRight==0) ? sftSrc[13] : sftSrc[11];
assign result[13] = (leftRight==0) ? sftSrc[14] : sftSrc[12];
assign result[14] = (leftRight==0) ? sftSrc[15] : sftSrc[13];
assign result[15] = (leftRight==0) ? 0 : sftSrc[14];

endmodule