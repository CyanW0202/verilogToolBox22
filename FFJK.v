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
// Using port: the first one in spartan7 (cpga196-2)
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
if(J == K) // this is a T flip flop
    case(J)
    1'b1: Q = ~Q;
    default: Q = Q;
    endcase
else
    Q = J; //this is a D flip flop
end
endmodule

//JK flipflop testbench
module FFJK_testbench();
 reg J;
 reg K;
 reg clk;
 wire Q;
FFJK dut(.J(J), .K(K), .clk(clk), .Q(Q));
initial begin
clk = 0; J = 0; K = 0;
#40 J = 0; K = 1;
#40 K = 0;
#40 J = 1;
#40 K = 1;
#40 J = 0; K = 1;
#40 K = 0;
#40 J = 1;
#40 K = 1;
end
initial begin
forever #60 clk = ~clk; //clk
end
endmodule
//////////////////////////////////////////////////////////////////////////////////
// Module Name: JK ff application
//////////////////////////////////////////////////////////////////////////////////

