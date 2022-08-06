module Pipeline_CPU( clk_i, rst_n );
		
//I/O port
input         clk_i;
input         rst_n;

//Internal Signles
wire [16-1:0] PC_in;
wire [16-1:0] PC_ReadAddress;
wire [16-1:0] PCadder1_sum;
wire [16-1:0] PCadder2_sum;
wire [16-1:0] Instruction;
wire  [3-1:0] RDaddr;
wire [16-1:0] RDdata;
wire [16-1:0] RSdata;
wire [16-1:0] RTdata;

//Decoder
wire 	        RegDst;
wire 		RegWrite;
wire	[2-1:0] ALUOp;
wire	        ALUSrc;
wire	        Branch;
wire		MemtoReg;
wire		BranchType;
wire		Jump;
wire		MemRead;
wire		MemWrite;

//AC
wire  [4-1:0] ALU_operation;
wire  [2-1:0] FUResult_Select;
wire [16-1:0] FUResult; //for getting the answer of 3-to-1 MUX

//ALU
wire [16-1:0] SignExtend; 
wire [16-1:0] ALU_src2;
wire Zero;
wire Overflow;
wire [16-1:0] ALU_result;

//DM
wire [16-1:0] Mem_Readdata;

//branch
wire ZERO;
wire PCSrc;

//ZF
wire [16-1:0] ZeroFilled;

//shifter
wire [16-1:0] Shifter_result;

//PC
wire [16-1:0] SE_shiftleft1;
wire [16-1:0] PC_branch;
wire [14-1:0] Jump_shiftleft1;
wire [16-1:0] PC_jump;

// IFID
wire [16-1:0] Instruction_o_IFID;
wire [16-1:0] PCadder1_sum_o_IFID;

// IDEX
wire [2-1:0] WB_IDEX;
wire [2-1:0] MEM_IDEX;
wire [7-1:0] EX_IDEX;
wire [13-1:0] Instr_12to0_IDEX; //part_jump_addr
wire [16-1:0] PCadder1_sum_o_IDEX;
wire [16-1:0] RSdata_IDEX;
wire [16-1:0] RTdata_IDEX;
wire [16-1:0] SignExtend_IDEX;
wire [16-1:0] ZeroFilled_IDEX;

// EXMEM
wire [2-1:0] WB_EXMEM;
wire [2-1:0] MEM_EXMEM;
wire [16-1:0] FUresult_EXMEM;
wire [16-1:0] RTdata_EXMEM;
wire [3-1:0] RDaddr_EXMEM;

// MEMWB
wire [16-1:0] FUresult_MEMWB;
wire [3-1:0] RDaddr_MEMWB;
wire [16-1:0] memReadData_MEMWB;
wire [2-1:0] WB_MEMWB;

//module
Program_Counter PC(
        .clk_i(clk_i),      
        .rst_n(rst_n),     
        .pc_in_i(PC_in) ,   
        .pc_out_o(PC_ReadAddress) 
        );
	
Instr_Memory IM(
        .pc_addr_i(PC_ReadAddress),  
        .instr_o(Instruction)    
        );
	
Reg_File RF(
        .clk_i(clk_i),      
	.rst_n(rst_n) ,     
        .RSaddr_i(Instruction_o_IFID[12:10]) ,  
        .RTaddr_i(Instruction_o_IFID[9:7]) ,  
        .RDaddr_i(RDaddr_MEMWB) ,  
        .RDdata_i(RDdata)  , 
        .RegWrite_i(WB_MEMWB[0]),
        .RSdata_o(RSdata) ,  
        .RTdata_o(RTdata)
        );

Data_Memory DM(
        .clk_i(clk_i),
        .addr_i(FUresult_EXMEM),
        .data_i(RTdata_EXMEM),
        .MemRead_i(MEM_EXMEM[0]),
        .MemWrite_i(MEM_EXMEM[1]),
        .data_o(Mem_Readdata)
        );
/*your code here*/
Pipe_IFID IFID(
        .clk_i(clk_i), 
        .rst_n(rst_n), 
        .Instruction_i(Instruction), 
        .PCadder1_sum_i(PCadder1_sum), 
        .Instruction_o(Instruction_o_IFID), 
        .PCadder1_sum_o(PCadder1_sum_o_IFID)
);
Decoder DC(
        .instr_op_i(Instruction_o_IFID[15:13]), 
        .RegWrite_o(RegWrite),
        .ALUOp_o(ALUOp), 
        .ALUSrc_o(ALUSrc), 
        .RegDst_o(RegDst), 
        .Branch_o(Branch), 
        .BranchType_o(BranchType), 
        .MemToReg_o(MemtoReg), 
        .MemRead_o(MemRead), 
        .MemWrite_o(MemWrite), 
        .Jump_o(Jump)   
);
Pipe_IDEX IDEX(
        .clk_i(clk_i), 
        .rst_n(rst_n), 
        .WB_IDEX_i( {MemtoReg, RegWrite} ), 
        .MEM_IDEX_i( {MemWrite, MemRead} ), 
        .EX_IDEX_i( {ALUSrc, ALUOp, RegDst, Jump, BranchType, Branch} ), 
        .part_jump_addr_i(Instruction_o_IFID[12:0]), 
        .PCadder1_sum_i(PCadder1_sum_o_IFID), 
        .RSdata_i(RSdata), 
        .RTdata_i(RTdata), 
        .SignExtend_i(SignExtend), 
        .ZeroFilled_i(ZeroFilled), 
        .WB_IDEX_o(WB_IDEX), 
        .MEM_IDEX_o(MEM_IDEX), 
        .EX_IDEX_o(EX_IDEX), 
        .part_jump_addr_o(Instr_12to0_IDEX), 
        .PCadder1_sum_o(PCadder1_sum_o_IDEX), 
        .RSdata_o(RSdata_IDEX), 
        .RTdata_o(RTdata_IDEX), 
        .SignExtend_o(SignExtend_IDEX), 
        .ZeroFilled_o(ZeroFilled_IDEX)
);
ALU_Ctrl AC(       
        .funct_i(Instr_12to0_IDEX[3:0]), 
        .ALUOp_i(EX_IDEX[5:4]), 
        .ALU_operation_o(ALU_operation), 
        .FURslt_o(FUResult_Select)
);
Mux2to1 rgDst(
        .data0_i(Instr_12to0_IDEX[9:7]),
        .data1_i(Instr_12to0_IDEX[6:4]), 
        .select_i(EX_IDEX[3]), 
        .data_o(RDaddr)
);
Sign_Extend SE(
        .data_i(Instruction_o_IFID[6:0]),
        .data_o(SignExtend)
);
Mux2to1 ASrc(
        .data0_i(RTdata_IDEX),
        .data1_i(SignExtend_IDEX), 
        .select_i(EX_IDEX[6]), 
        .data_o(ALU_src2)
);
ALU     alu(
        .aluSrc1(RSdata_IDEX), 
        .aluSrc2(ALU_src2), 
        .ALU_operation_i(ALU_operation), 
        .result(ALU_result), 
        .zero(Zero), 
        .overflow(Overflow)
);
Shifter sf(      
        .result(Shifter_result), 
        .leftRight(ALU_operation[0]), // make the first bit of ALU_operation equal to leftRight, so this works well
        .sftSrc(ALU_src2)
);
Zero_Filled zf(
        .data_i(Instruction_o_IFID[6:0]), 
        .data_o(ZeroFilled)
);
Mux3to1 furslt(
        .data0_i(ALU_result), 
        .data1_i(Shifter_result), 
        .data2_i(ZeroFilled), 
        .select_i(FUResult_Select), 
        .data_o(FUResult)
);
Mux2to1 MemReg(
        .data0_i(FUresult_MEMWB),
        .data1_i(memReadData_MEMWB), 
        .select_i(WB_MEMWB[1]), 
        .data_o(RDdata)
);
Mux2to1 zr(
        .data0_i(Zero),
        .data1_i(~Zero), 
        .select_i(EX_IDEX[1]), //branch type
        .data_o(ZERO)
);
and (PCSrc, EX_IDEX[0], ZERO); // branch and zero
Pipe_EXMEM EXMEM(
        .clk_i(clk_i), 
        .rst_n(rst_n), 
        .WB_EXMEM_i(WB_IDEX), 
        .MEM_EXMEM_i(MEM_IDEX), 
        .FUresult_i(FUResult), 
        .FUresult_o(FUresult_EXMEM), 
        .RTdata_i(RTdata_IDEX), 
        .RTdata_o(RTdata_EXMEM), 
        .RDaddr_i(RDaddr), 
        .RDaddr_o(RDaddr_EXMEM), 
        .WB_EXMEM_o(WB_EXMEM), 
        .MEM_EXMEM_o(MEM_EXMEM)
);
Pipe_MEMWB MEMWB(
        .clk_i(clk_i), 
        .rst_n(rst_n), 
        .WB_MEMWB_i(WB_EXMEM), 
        .FUresult_i(FUresult_EXMEM), 
        .FUresult_o(FUresult_MEMWB), 
        .RDaddr_i(RDaddr_EXMEM), 
        .RDaddr_o(RDaddr_MEMWB), 
        .memReadData_i(Mem_Readdata), 
        .memReadData_o(memReadData_MEMWB), 
        .WB_MEMWB_o(WB_MEMWB)
);

//deal with Program counter (including branch jump)
Adder   ad1(
        .src1_i(PC_ReadAddress), 
        .src2_i(16'b0000_0000_0000_0010), 
        .sum_o(PCadder1_sum)
);
Shift_Left_one_extend sfloe(
        .data_i(Instr_12to0_IDEX),
        .data_o(Jump_shiftleft1)
);
Shift_Left_one sflo(
        .data_i(SignExtend),
        .data_o(SE_shiftleft1)
);
Adder   ad2(
        .src1_i(PCadder1_sum_o_IDEX), 
        .src2_i(SE_shiftleft1), 
        .sum_o(PCadder2_sum)
);
Mux2to1 PCs(//PC source
        .data0_i(PCadder1_sum_o_IDEX),
        .data1_i(PCadder2_sum), 
        .select_i(PCSrc),
        .data_o(PC_branch)
);
assign PC_jump = {PCadder1_sum_o_IDEX[15:14], Jump_shiftleft1};
Mux2to1 jp(
        .data0_i(PC_branch),
        .data1_i(PC_jump), 
        .select_i(EX_IDEX[2]), 
        .data_o(PC_in)
);
endmodule

