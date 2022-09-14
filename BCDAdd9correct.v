`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2022 01:40:30 PM
// Design Name: 
// Module Name: bcdadd9c
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

//a signed BCD adder. since sum over 9 would be using the MSB sign bit. so we need to correct it by adding 6.
module bcdadd9c(input Cin, [3:0] x, y, output reg cout, reg [3:0] s);
reg [4:0] Z;
always@(x, y, Cin)
begin
    Z = x+y+Cin; //9 is 5 bits: 01001
    if(Z < 10)
        {cout, s} =Z;
    else
        {cout, s} =Z+6;
end
endmodule



module bcdadd_testbench;
reg ci;
reg [3:0] X, Y;
wire co; wire [3:0]S;

bcdadd9c uut (.Cin(ci), .x(X), .y(Y), .cout(co), .s(S));
initial begin
    ci = 0; X= 0; Y=0;
    #1 X=3; Y=4;
    #1 X = 9;
end
endmodule
