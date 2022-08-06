module Pipe_EXMEM (clk_i, rst_n, WB_EXMEM_i, MEM_EXMEM_i, FUresult_i, FUresult_o, RTdata_i, RTdata_o, RDaddr_i, RDaddr_o, WB_EXMEM_o, MEM_EXMEM_o);

// Input and Output
input clk_i;
input rst_n;
input [2-1:0] WB_EXMEM_i; // left bit(MemtoReg), right bit(regWrite)
input [2-1:0] MEM_EXMEM_i; // left bit(memWrite), right bit(memRead)
input [16-1:0] FUresult_i;
input [16-1:0] RTdata_i;
input [3-1:0] RDaddr_i;

output wire [2-1:0] WB_EXMEM_o; // left bit(MemtoReg), right bit(regWrite)
output wire [2-1:0] MEM_EXMEM_o; // left bit(memWrite), right bit(memRead)
output wire [16-1:0] FUresult_o;
output wire [16-1:0] RTdata_o;
output wire [3-1:0] RDaddr_o;

// register to record the values
reg [2-1:0] WB_EXMEM_reg;
reg [2-1:0] MEM_EXMEM_reg;
reg [16-1:0] FUresult_reg;
reg [16-1:0] RTdata_reg;
reg [3-1:0] RDaddr_reg;

// read data in reg
assign WB_EXMEM_o = WB_EXMEM_reg;
assign MEM_EXMEM_o = MEM_EXMEM_reg;
assign FUresult_o = FUresult_reg;
assign RTdata_o = RTdata_reg;
assign RDaddr_o = RDaddr_reg;

// main function
always @(negedge rst_n or posedge clk_i) begin
    if(rst_n == 0)begin
        WB_EXMEM_reg <= 0;
        MEM_EXMEM_reg <= 0;
        FUresult_reg <= 0;
        RTdata_reg <= 0;
        RDaddr_reg <= 0;
    end
    else begin
        WB_EXMEM_reg <= WB_EXMEM_i;
        MEM_EXMEM_reg <= MEM_EXMEM_i;
        FUresult_reg <= FUresult_i;
        RTdata_reg <= RTdata_i;
        RDaddr_reg <= RDaddr_i;
    end
end

//Initialize to 0
initial begin
    WB_EXMEM_reg = 0;
    MEM_EXMEM_reg = 0;
    FUresult_reg = 0;
    RTdata_reg = 0;
    RDaddr_reg = 0;
end
    
endmodule