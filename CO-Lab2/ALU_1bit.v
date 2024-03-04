module ALU_1bit( result, carryOut, a, b, invertA, invertB, aluOp, carryIn, less );
  
  output wire result;
  output wire carryOut;
  
  input wire a;
  input wire b;
  input wire invertA;
  input wire invertB;
  input wire[1:0] aluOp;
  input wire less;
  input wire carryIn;
  
  wire tA, tB;// true A and B (after MUX (invert or not invert))
  assign tA = invertA==1 ? ~a : a;
  assign tB = invertB==1 ? ~b : b;

  wire AND, OR, Sum;
  and (AND, tA, tB);
  or (OR, tA, tB);

  Full_adder Fa(Sum, carryOut, carryIn, tA, tB);

  assign result = (invertA==0 && invertB==0 && aluOp==2'b00) ? AND : // result = a and b
        (invertA==0 && invertB==0 && aluOp==2'b01) ? OR : // result = a or b
        (invertA==1 && invertB==1 && aluOp==2'b00) ? AND : // result = ~a & ~b = a nor b
        (invertA==0 && invertB==0 && aluOp==2'b10) ? Sum : // result of adding
        (invertA==0 && invertB==1 && aluOp==2'b10) ? Sum : // result of subtracting(for the first bit carryIn should be 1) adding b's 2's complement
        less; // result of set on less than when aluOp=2'b11

endmodule