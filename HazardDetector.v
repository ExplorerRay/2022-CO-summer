module HazardDetector (RSaddr_IFID_i, RTaddr_IFID_i, RTaddr_IDEX_i, RDaddr_IDEX_i, RegDst_IDEX, RDaddr_EXMEM_i, RegWrite_IDEX, RegWrite_EXMEM, PCsrc_i, Jump_IDEX, DHZ_o, CHZ_o);

//inputs for data hazard
input [3-1:0] RSaddr_IFID_i; //instruction[12:10]
input [3-1:0] RTaddr_IFID_i; //instruction[9:7]
input [3-1:0] RTaddr_IDEX_i; //instruction[9:7] for other format
input [3-1:0] RDaddr_IDEX_i; //instruction[6:4] for R-format
input RegDst_IDEX; //decide whether R-format or other
input [3-1:0] RDaddr_EXMEM_i;
input RegWrite_IDEX;
input RegWrite_EXMEM;
//inputs for control hazard
input PCsrc_i;
input Jump_IDEX;

output wire DHZ_o;//data hazard
output wire CHZ_o;//control hazard

wire [3-1:0] addr_IDEX;
assign addr_IDEX = (RegDst_IDEX == 0) ? RTaddr_IDEX_i : RDaddr_IDEX_i;

assign DHZ_o = (RSaddr_IFID_i == addr_IDEX && RSaddr_IFID_i != 0 && RegWrite_IDEX == 1) ? 1 :
        (RTaddr_IFID_i == addr_IDEX && RTaddr_IFID_i != 0 && RegWrite_IDEX == 1) ? 1 :
        (RSaddr_IFID_i == RDaddr_EXMEM_i && RSaddr_IFID_i != 0 && RegWrite_EXMEM == 1) ? 1 :
        (RTaddr_IFID_i == RDaddr_EXMEM_i && RTaddr_IFID_i != 0 && RegWrite_EXMEM == 1) ? 1 : 0;
assign CHZ_o = (PCsrc_i == 1 || Jump_IDEX == 1) ? 1 : 0;
endmodule