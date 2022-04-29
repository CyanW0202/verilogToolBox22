//this is in verilog
//using Vivado 2019
//JK flipflop
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: C_Yuan Wu
// 
// Create Date: 04/28/2022 04:43:09 PM
// Module Name: FFJK
// Target Devices: 
// Tool Versions: 
// Description: 
// Using port: the first one in satan7
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FFJK(
    input J,
    input K,
    input clk,
    output reg Q
    );
always@(posedge clk)
begin
if(J == K)
    case(J)
    1'b1: Q = ~Q;
    default: Q = Q;
    endcase
else
    case(J):
    
    endcase
end
endmodule
