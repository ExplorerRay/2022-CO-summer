module Sign_Extend( data_i, data_o );

//I/O ports
input	[7-1:0]     data_i;
output	[16-1:0]    data_o;

//Internal Signals
wire	[16-1:0]    data_o;

//Main function
assign data_o = { {9{data_i[6]}}, data_i };

endmodule      
