module Full_adder(sum,cout,cin,inp1,inp2);

  input cin, inp1, inp2;
  output sum,cout;

  wire inp12, inp1cin, inp2cin;
  and (inp12, inp1, inp2);
  and (inp1cin, inp1, cin);
  and (inp2cin, inp2, cin);
  or (cout, inp12, inp1cin, inp2cin);
  // cout = (inp1&inp2) | (inp1&cin) | (inp2&cin)

  xor (sum, inp1, inp2, cin);// sum=inp1^inp2^cin

endmodule