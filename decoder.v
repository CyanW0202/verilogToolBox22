
module Decoder12(
  input A;
  input e;
  output reg D1;
  output reg D2;
);
  always@(*)
  begin
    case([e,A])
      2'b10: D0 = 1;
      2'b11: D1 = 1;
      default: D1 = 0; D0 = 0;
    endcase
  end
endmodule

//testbench

module Decoder12_testbench();
  reg A;
  reg e;
  wire D0, D1;
  
  Decoder12 dut(
    .A(A),
    .e(e),
    .D1(D1),
    .D0(D0)
  );
  
  initial begin
    e = 0; A = 0;
  #80: e = 1; A = 0;
  #80: e = 0; A = 1;
  #80: e = 1; A = 1;
  #80: e = 1; A = 0;
  end
endmodule  
