module ALU_Ctrl( funct_i, ALUOp_i, ALU_operation_o, FURslt_o);

//I/O ports 
input      [4-1:0] funct_i;
input      [2-1:0] ALUOp_i;

output     [4-1:0] ALU_operation_o;  
output     [2-1:0] FURslt_o;

//Internal Signals
wire		[4-1:0] ALU_operation_o;
wire		[2-1:0] FURslt_o;	

//Main function
assign ALU_operation_o = (ALUOp_i == 2'b00 || (ALUOp_i == 2'b10 && funct_i[2:0] == 3'b000)) ? 4'b0010 :
        (ALUOp_i == 2'b01 || (ALUOp_i == 2'b10 && funct_i[2:0] == 3'b001)) ? 4'b0110 :
        (ALUOp_i == 2'b10 && funct_i[2:0] == 3'b010) ? 4'b0000 :
        (ALUOp_i == 2'b10 && funct_i[2:0] == 3'b011) ? 4'b0001 :
        (ALUOp_i == 2'b10 && funct_i[2:0] == 3'b100) ? 4'b1100 : 
        (ALUOp_i == 2'b10 && funct_i[2:0] == 3'b101) ? 4'b0111 :
        (ALUOp_i == 2'b10 && funct_i[2:0] == 3'b110) ? 4'b1001 : 4'b1000; // four 32-to-1 MUXs
assign FURslt_o = (ALUOp_i == 2'b11) ? 2'b10 : // two 16-to-1 MUXs
        (ALUOp_i == 2'b10 && funct_i[2:1] == 2'b11) ? 2'b01 : 2'b00;
endmodule
