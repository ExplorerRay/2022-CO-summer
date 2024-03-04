module Pipe_MEMWB (clk_i, rst_n, WB_MEMWB_i, FUresult_i, FUresult_o, RDaddr_i, RDaddr_o, memReadData_i, memReadData_o, WB_MEMWB_o);

// Input and Output
input clk_i;
input rst_n;
input [2-1:0] WB_MEMWB_i; // left bit(MemtoReg), right bit(regWrite)
input [16-1:0] FUresult_i;
input [3-1:0] RDaddr_i;
input [16-1:0] memReadData_i;

output wire [2-1:0] WB_MEMWB_o; // left bit(MemtoReg), right bit(regWrite)
output wire [16-1:0] FUresult_o;
output wire [3-1:0] RDaddr_o;
output wire [16-1:0] memReadData_o;

// register to record the values
reg [2-1:0] WB_MEMWB_reg;
reg [16-1:0] FUresult_reg;
reg [3-1:0] RDaddr_reg;
reg [16-1:0] memReadData_reg;

// read data in reg
assign WB_MEMWB_o = WB_MEMWB_reg;
assign FUresult_o = FUresult_reg;
assign RDaddr_o = RDaddr_reg;
assign memReadData_o = memReadData_reg;

// main function
always @(negedge rst_n or posedge clk_i) begin
    if(rst_n == 0)begin
        WB_MEMWB_reg <= 0;
        FUresult_reg <= 0;
        RDaddr_reg <= 0;
        memReadData_reg <= 0;
    end
    else begin
        WB_MEMWB_reg <= WB_MEMWB_i;
        FUresult_reg <= FUresult_i;
        RDaddr_reg <= RDaddr_i;
        memReadData_reg <= memReadData_i;
    end
end

//Initialize to 0
initial begin
    WB_MEMWB_reg = 0;
    FUresult_reg = 0;
    RDaddr_reg = 0;
    memReadData_reg = 0;
end
    
endmodule