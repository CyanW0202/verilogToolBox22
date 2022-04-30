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
