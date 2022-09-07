`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2022 01:17:36 PM
// Design Name: 
// Module Name: MUX
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module dec2to4 (W, En, Y);
  input [1:0] W;
  input En;
  output reg [0:3] Y;

  always @(W, En)
    case ({En, W}) //000, En 1'b, W 2'b
    3'b100: Y = 4'b1000; //en = 1, W = 00
    3'b101: Y = 4'b0100;
    3'b110: Y = 4'b0010;
    3'b111: Y = 4'b0001;
    default: Y = 4'b0000;
    endcase

endmodule
