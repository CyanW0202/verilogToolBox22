`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CPP
// Engineer: Chia
// 
// Create Date: 04/29/2022 11:56:50 PM
// Module Name: FFT
// Revision:
// Revision 0.01 - File Created
// Additional Comments: neg edge T ff
// 
//////////////////////////////////////////////////////////////////////////////////


module FFT(
    input T,
    input clk,
    output reg Q
    );
always@(negedge clk)
begin
    if(T)
    Q = ~Q;
    else
    Q = Q;
end
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: FFT_testbench
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FFT_testbench( );
reg T;
reg clk;
wire Q1;

initial begin
T = 0;
#22 T = 1;
#120 T = 0;
#33 T = 1;
#80 T = 0;

end
initial begin
clk = 0;
forever #40 clk = ~clk;
end

FFT dut(.T(T), .clk(clk), .Q(Q1));
endmodule
