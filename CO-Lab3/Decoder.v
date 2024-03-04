module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o, Branch_o, BranchType_o, MemToReg_o, MemRead_o, MemWrite_o, Jump_o );
     
//I/O ports
input	[3-1:0] instr_op_i;

output			RegWrite_o;
output	[2-1:0] ALUOp_o;
output			ALUSrc_o;
output	        RegDst_o;
output			Branch_o;
output			BranchType_o;
output			MemToReg_o;
output			MemRead_o;
output			MemWrite_o; 
output			Jump_o;

//Internal Signals
wire			RegWrite_o;
wire	[2-1:0] ALUOp_o;
wire			ALUSrc_o;
wire	        RegDst_o;
wire			Branch_o;
wire			BranchType_o;
wire			MemToReg_o;
wire			MemRead_o;
wire			MemWrite_o; 
wire			Jump_o;

//Main function
assign RegWrite_o = (instr_op_i[2] == 1'b1) ? 0 : 1;  // one 2-to-1 MUX
assign ALUOp_o = (instr_op_i == 3'b000) ? 2'b10 :  // two 8-to-1 MUXs
        (instr_op_i == 3'b001 || instr_op_i == 3'b011 || instr_op_i == 3'b100) ? 2'b00 :
        (instr_op_i == 3'b010) ? 2'b11 : 2'b01;
assign ALUSrc_o = (instr_op_i == 3'b000 || instr_op_i == 3'b101 || instr_op_i == 3'b110)
        ? 0 : 1;  // one 8-to-1 MUX
assign RegDst_o = (instr_op_i[1:0] == 2'b00) ? 1 : 0;  // one 4-to-1 MUX
assign Branch_o = (instr_op_i == 3'b101 || instr_op_i == 3'b110) ? 1 : 0;  // one 8-to-1 MUX
assign BranchType_o = instr_op_i[1];
assign MemToReg_o = (instr_op_i[1:0] == 2'b11) ? 1 : 0; // one 4-to-1 MUX
assign MemRead_o = (instr_op_i == 3'b011) ? 1 : 0; // one 8-to-1 MUX
assign MemWrite_o = (instr_op_i == 3'b100) ? 1 : 0; // one 8-to-1 MUX
assign Jump_o = (instr_op_i == 3'b111) ? 1 : 0; // one 8-to-1 MUX
endmodule
