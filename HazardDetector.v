module HazardDetector ();

//inputs for data hazard
input [3-1:0] RSaddr_IFID_i; //instruction[12:10]
input [3-1:0] RTaddr_IFID_i; //instruction[9:7]
input [3-1:0] RDaddr_IDEX_i; //instruction[6:4]
input [3-1:0] RDaddr_EXMEM_i;

// branch,jump finished after EX stage, need TWO bubbles
endmodule