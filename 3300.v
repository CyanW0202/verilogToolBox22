`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 08/31/2022 01:56:37 PM
// Design Name: 4bitsAdder
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2022 01:50:37 PM
// Design Name: 
// Module Name: MUX2to4
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


module MUX2to4(W, S, f);
input [0:3] W;
input [1:0] S;
output reg f;
always @(W, S)
case (S)
0: f = W[0];
1: f = W[1];
2: f = W[2];
3: f = W[3];
endcase
endmodule  



`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2022 02:21:00 PM
// Design Name: 
// Module Name: Mux_testbench
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


module Mux_testbench;
reg[1:0] select;
reg[0:3] data;
wire out;
MUX2to4 uut(.W(data), .S(select), .f(out));

initial begin
    select = 0;
    data = 'b1010;
    #2 select[0] = 1;
    #1 select = ~select;
    #1 select[0] = 1;
end
endmodule







`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 08/31/2022 01:56:37 PM
// Design Name: decoder3to8
// Module Name: 
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

module decoder3to8(input [2:0] data,  output reg [7:0] y );
always @(data)
begin
y=0;
y[data]=1;
end
endmodule

module decoder_testbench;
reg [2:0] test_data;
wire [7:0] test_y;
decoder3to8 uut(.data(test_data), .y(test_y) ); 

initial begin
test_data=0;
 #1 test_data =1;
 #1 test_data =2;
 #1 test_data =3;
 #1 test_data =4;
 #1 test_data =5;
 #1 test_data =6;
 #1 test_data =7;
 end
endmodule


