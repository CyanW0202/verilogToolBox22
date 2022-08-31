`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2022 01:56:37 PM
// Design Name: 
// Module Name: fulladd
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


module adder4(input x[3:0], y[3:0], Cin, output cout, sum1, sum2, sum3, sum0);
    fulladd add1(Cin, x[0],y[0], sum0,c1);
    fulladd add2(c1, x[1], y[1],sum1,c2);
    fulladd add3(c2, x[2],y[2],sum2,c3);
    fulladd add4(c3, x[3], y[3],sum3,cout); 
endmodule



module fulladd(input cin,x1,x2, output s, cout);
    //assign f = (x1&x2)|(~x2&x3);
    assign s = x1^x2^cin, cout = (x1&x2)|(x1&cin)|(x2&cin);
endmodule





