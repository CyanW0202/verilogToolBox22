
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Chia
// 
// Create Date: 05/03/2022 12:50:48 AM
// Module Name: Decoder12
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Decoder12(
  input A,
  input e,
  output reg D1,
  output reg D0
);
  always@(*)
  begin
    case({e,A})
      2'b10: D0 = 1;
      2'b11: D1 = 1;
      default: {D1,D0} = 2'b00;
    endcase
  end
endmodule


//testbench

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: Decoder_testbench
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Decoder12_testbench();
  reg A1;
  reg e1;
  wire D01, D11;
  
  
  Decoder12 dut(
    .A(A1),
    .e(e1),
    .D1(D11),
    .D0(D01)
  );
  
  initial begin
    e1 = 0; A1 = 0;
    
    #80 e1 = 1; A1 =0;
    #80 e1 = 0; A1 =1;
    #80 e1 = 1; A1 = 1;
    #80 e1 = 1; A1 =0;
  
  end
endmodule

//Application-3 to 8 Decoder
module Decoder38(
input A[2:0],
input e,
output reg D[7:0]);

Decoder12 D1(
.A(),
.e(),
.D1(),
.D0()
);
Decoder12 D2(
.A(),
.e(),
.D1(),
.D0()
);
Decoder12 D3(
.A(),
.e(),
.D1(),
.D0());
endmodule

