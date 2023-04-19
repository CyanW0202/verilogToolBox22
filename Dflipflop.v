
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CPP
// Engineer: Chia
// 
// Create Date: 04/30/2022 10:40:50 PM
// Module Name: FFD
// Revision: 
// Additional Comments: pos edge D ff
// output = input at rising.
// Use for building memory 
//////////////////////////////////////////////////////////////////////////////////


module FFD(
    input D,
    input clk,
    output reg Q
    );
initial begin
Q = 0;
end
always@(posedge clk)
begin
Q = D;
end
endmodule

module FFDt(input D, input clk,output reg Q);
wire w, w1, w2;
FFD d1(.D(D), .clk(clk), .Q(w));
FFD d2(.D(w), .clk(clk), .Q(w1));
FFD d3(.D(w1), .clk(clk), .Q(Q));
endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 04/30/2022 09:44:04 PM
// Module Name: FFT_testbench
// Description: I move the circuit to here.
// 
//////////////////////////////////////////////////////////////////////////////////
module FFD_testbench( );
reg D;
reg clk;

initial begin
D = 0;
forever #50 D = ~D;
end
initial begin
clk = 0;
forever #40 clk = ~clk;
end
wire w, w1, w2;
FFD d1(.D(D), .clk(clk), .Q(w));
FFD d2(.D(w), .clk(clk), .Q(w1));
FFD d3(.D(w1), .clk(clk), .Q(w2));

endmodule
