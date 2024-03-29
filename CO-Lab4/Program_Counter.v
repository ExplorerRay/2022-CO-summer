module Program_Counter( clk_i, rst_n, DHZ_i, pc_in_i, pc_out_o );

//I/O ports
input           clk_i;
input	        rst_n;
input           DHZ_i;
input  [16-1:0] pc_in_i;
output [16-1:0] pc_out_o;
 
//Internal Signals
reg    [16-1:0] pc_out_o;

//Main function
always @(posedge clk_i) begin
    if(~rst_n)
	    pc_out_o <= 0;
	else if(DHZ_i == 0)
	    pc_out_o <= pc_in_i;
end

endmodule
