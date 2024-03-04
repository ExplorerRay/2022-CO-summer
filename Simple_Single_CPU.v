module Simple_Single_CPU( clk_i, rst_n );
		
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
        .RSaddr_i(Instruction[12:10]) ,  
        .RTaddr_i(Instruction[9:7]) ,  
        .RDaddr_i(RDaddr) ,  
        .RDdata_i(RDdata)  , 
        .RegWrite_i(RegWrite),
        .RSdata_o(RSdata) ,  
        .RTdata_o(RTdata)
        );

Data_Memory DM(
        .clk_i(clk_i),
        .addr_i(FUResult),
        .data_i(RTdata),
        .MemRead_i(MemRead),
        .MemWrite_i(MemWrite),
        .data_o(Mem_Readdata)
        );
/*your code here*/
Decoder DC(
        .instr_op_i(Instruction[15:13]), 
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
ALU_Ctrl AC(       
        .funct_i(Instruction[3:0]), 
        .ALUOp_i(ALUOp), 
        .ALU_operation_o(ALU_operation), 
        .FURslt_o(FUResult_Select)
);
Mux2to1 rgDst(
        .data0_i(Instruction[9:7]),
        .data1_i(Instruction[6:4]), 
        .select_i(RegDst), 
        .data_o(RDaddr)
);
Sign_Extend SE(
        .data_i(Instruction[6:0]),
        .data_o(SignExtend)
);
Mux2to1 ASrc(
        .data0_i(RTdata),
        .data1_i(SignExtend), 
        .select_i(ALUSrc), 
        .data_o(ALU_src2)
);
ALU     alu(
        .aluSrc1(RSdata), 
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
        .data_i(Instruction[6:0]), 
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
        .data0_i(FUResult),
        .data1_i(Mem_Readdata), 
        .select_i(MemtoReg), 
        .data_o(RDdata)
);
Mux2to1 zr(
        .data0_i(Zero),
        .data1_i(~Zero), 
        .select_i(BranchType), 
        .data_o(ZERO)
);
and (PCSrc, Branch, ZERO);

//deal with Program counter (including branch jump)
Adder   ad1(
        .src1_i(PC_ReadAddress), 
        .src2_i(16'b0000_0000_0000_0010), 
        .sum_o(PCadder1_sum)
);
Shift_Left_one_extend sfloe(
        .data_i(Instruction[12:0]),
        .data_o(Jump_shiftleft1)
);
Shift_Left_one sflo(
        .data_i(SignExtend),
        .data_o(SE_shiftleft1)
);
Adder   ad2(
        .src1_i(PCadder1_sum), 
        .src2_i(SE_shiftleft1), 
        .sum_o(PCadder2_sum)
);
Mux2to1 PCs(//PC source
        .data0_i(PCadder1_sum),
        .data1_i(PCadder2_sum), 
        .select_i(PCSrc),
        .data_o(PC_branch)
);
assign PC_jump = {PCadder1_sum[15:14], Jump_shiftleft1};
Mux2to1 jp(
        .data0_i(PC_branch),
        .data1_i(PC_jump), 
        .select_i(Jump), 
        .data_o(PC_in)
);
endmodule

