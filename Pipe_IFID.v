module Pipe_IFID (clk_i, rst_n, DHZ_i, CHZ_i, Instruction_i, PCadder1_sum_i, Instruction_o, PCadder1_sum_o);

// Input and Output
input clk_i;
input rst_n;
input DHZ_i;
input CHZ_i;
input [16-1:0] Instruction_i;// send instruction
input [16-1:0] PCadder1_sum_i;// send PC+2 to this module

output wire [16-1:0] Instruction_o;
output wire [16-1:0] PCadder1_sum_o;

// register to record the values
reg [16-1:0] Instr_reg;
reg [16-1:0] PCaddTwo_reg;

// read data in reg
assign Instruction_o = Instr_reg;
assign PCadder1_sum_o = PCaddTwo_reg;

// main function
always @(negedge rst_n or posedge clk_i) begin
    if(rst_n == 0)begin
        Instr_reg <= 0;
        PCaddTwo_reg <= 0;
    end
    else if(CHZ_i == 1) begin
        Instr_reg <= 16'b1100_0000_0000_0000;// bne r0,r0,0; r0 always equal to r0, so this can represent nop.
    end
    else if(DHZ_i == 0) begin
        Instr_reg <= Instruction_i;
        PCaddTwo_reg <= PCadder1_sum_i;
    end
end

//Initialize to 0
initial begin
    Instr_reg = 0;
    PCaddTwo_reg = 0;
end
    
endmodule