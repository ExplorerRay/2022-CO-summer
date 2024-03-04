module Pipe_IDEX (clk_i, rst_n, DHZ_i, CHZ_i, WB_IDEX_i, MEM_IDEX_i, EX_IDEX_i, part_jump_addr_i, PCadder1_sum_i, RSdata_i, RTdata_i, SignExtend_i, ZeroFilled_i, WB_IDEX_o, MEM_IDEX_o, EX_IDEX_o, part_jump_addr_o, PCadder1_sum_o, RSdata_o, RTdata_o, SignExtend_o, ZeroFilled_o);

// Input and Output
input clk_i;
input rst_n;
input DHZ_i;
input CHZ_i;
input [2-1:0] WB_IDEX_i; // left bit(MemtoReg), right bit(regWrite)
input [2-1:0] MEM_IDEX_i; // left bit(memWrite), right bit(memRead)
input [7-1:0] EX_IDEX_i; // [6](ALUsrc), [5:4](ALUop), [3](regDst), [2](jump), [1](branchType), [0](branch)
input [13-1:0] part_jump_addr_i; // instruction[12:0]
input [16-1:0] PCadder1_sum_i;// send PC+2 to this module
input [16-1:0] RSdata_i;
input [16-1:0] RTdata_i;
input [16-1:0] SignExtend_i;
input [16-1:0] ZeroFilled_i;
//input [4-1:0] func_i; // instruction[3:0]
//input [3-1:0] RSaddr_i; // instruction[12:10]
//input [3-1:0] RTaddr_i; // instruction[9:7]
//input [3-1:0] RDaddr_i; // instruction[6:4] for R-format

output wire [2-1:0] WB_IDEX_o; // left bit(MemtoReg), right bit(regWrite)
output wire [2-1:0] MEM_IDEX_o; // left bit(memWrite), right bit(memRead)
output wire [7-1:0] EX_IDEX_o;
output wire [13-1:0] part_jump_addr_o; // instruction[12:0]
output wire [16-1:0] PCadder1_sum_o;
output wire [16-1:0] RSdata_o;
output wire [16-1:0] RTdata_o;
output wire [16-1:0] SignExtend_o;
output wire [16-1:0] ZeroFilled_o;
//output wire [4-1:0] func_o; // instruction[3:0]
//output wire [3-1:0] RSaddr_o; // instruction[12:10]
//output wire [3-1:0] RTaddr_o; // instruction[9:7]
//output wire [3-1:0] RDaddr_o; // instruction[6:4]

// register to record the values
reg [2-1:0] WB_IDEX_reg;
reg [2-1:0] MEM_IDEX_reg;
reg [7-1:0] EX_IDEX_reg;
reg [13-1:0] part_jump_addr_reg; // can be used for func rs,rt,rd addr
reg [16-1:0] PCaddTwo_reg;
reg [16-1:0] RSdata_reg;
reg [16-1:0] RTdata_reg;
reg [16-1:0] SignExtend_reg;
reg [16-1:0] ZeroFilled_reg;

// read data in reg
assign WB_IDEX_o = WB_IDEX_reg;
assign MEM_IDEX_o = MEM_IDEX_reg;
assign EX_IDEX_o = EX_IDEX_reg;
assign part_jump_addr_o = part_jump_addr_reg;
assign PCadder1_sum_o = PCaddTwo_reg;
assign RSdata_o = RSdata_reg;
assign RTdata_o = RTdata_reg;
assign SignExtend_o = SignExtend_reg;
assign ZeroFilled_o = ZeroFilled_reg;

// main function
always @(negedge rst_n or posedge clk_i) begin
    if(rst_n == 0)begin
        WB_IDEX_reg <= 0;
        MEM_IDEX_reg <= 0;
        EX_IDEX_reg <= 0;
        part_jump_addr_reg <= 0;
        PCaddTwo_reg <= 0;
        RSdata_reg <= 0;
        RTdata_reg <= 0;
        SignExtend_reg <= 0;
        ZeroFilled_reg <= 0;
    end
    else begin
        if(DHZ_i == 1 || CHZ_i == 1)begin
            WB_IDEX_reg <= 0;
            MEM_IDEX_reg <= 0;
            EX_IDEX_reg <= 0;
            part_jump_addr_reg <= part_jump_addr_i;
            PCaddTwo_reg <= PCadder1_sum_i;
            RSdata_reg <= RSdata_i;
            RTdata_reg <= RTdata_i;
            SignExtend_reg <= SignExtend_i;
            ZeroFilled_reg <= ZeroFilled_i
        end
        else begin
            WB_IDEX_reg <= WB_IDEX_i;
            MEM_IDEX_reg <= MEM_IDEX_i;
            EX_IDEX_reg <= EX_IDEX_i;
            part_jump_addr_reg <= part_jump_addr_i;
            PCaddTwo_reg <= PCadder1_sum_i;
            RSdata_reg <= RSdata_i;
            RTdata_reg <= RTdata_i;
            SignExtend_reg <= SignExtend_i;
            ZeroFilled_reg <= ZeroFilled_i;
        end
    end
end

//Initialize to 0
initial begin
    WB_IDEX_reg = 0;
    MEM_IDEX_reg = 0;
    EX_IDEX_reg = 0;
    part_jump_addr_reg = 0;
    PCaddTwo_reg = 0;
    RSdata_reg = 0;
    RTdata_reg = 0;
    SignExtend_reg = 0;
    ZeroFilled_reg = 0;
end
    
endmodule