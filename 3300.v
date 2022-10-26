`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Menglai Yin
// 
// Create Date: 10/11/2022 01:44:18 PM
// Design Name: The example is condensed, the default next state is going back to the original state.
// The next state always goes back to zero if the level = 0, which is correct and could be modify the other way around.
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


module edge_detect_mealy (input wire clk, reset, level, 
output reg tick);
     localparam [1:0] zero=1.b0, one=1’b1;
     reg state_reg, state_next;
     always @(posedge clk, posedge reset)
           if (reset)
state_reg<=zero;
           else
state_reg<=state_next;
     always@*
            begin
     state_next=state_reg;
tick=1’b0;
case (state_reg)
   zero:
        if (level)
                 begin
tick=1’b1;//this change is immediate
state_next=one;
                  end
   one: 
       if (~level)
state_next=zero;
  default:   
state_next=zero;
                         endcase
            end
endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2022 01:44:18 PM
// Design Name: 
// Module Name: vision
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


module vision(input sclk, input rA, output[6:0]CA, [7:0] AN);
slowerClkGen clking(sclk, rA, outsignal, type);
upcounter counting(outsignal, Q);
muxdisplay display(Q, type, CA, AN);
endmodule

module muxdisplay(input switch,[1:0] counter, output reg[6:0]CA, reg [7:0] AN);

always@(*)
begin
    case(counter)
    2'b00: 
    begin
        AN = 8'b1111_1110;
        CA = switch?7'b100_1111:7'b000_1000;
    end
    2'b01: 
    begin
        AN = 8'b1111_1101;
        CA = switch?7'b001_0010:7'b110_0000;
    end
    2'b10: 
    begin
        AN = 8'b1111_1011;
        CA = switch?7'b000_0110:7'b011_0001;
    end
    2'b11: 
    begin
        AN = 8'b1111_0111;
        CA = switch?7'b100_1100:7'b100_0010;
    end
    endcase    
end    
endmodule


module upcounter (input Clock, output reg [1:0] Q);
reg[1:0] Q = 0;
reg switch;
always @(posedge Clock) //Q = 0 when reset is 0.
begin
    
        Q <= Q + 1;//Q = 0~3
end
endmodule


module slowerClkGen(input clk, resetA, output outsignal, type);
reg [17:0] counter = 0;
reg [26:0] counter2 = 0;  
reg outsignal = 0;
reg type;
    always @ (posedge clk) //synchronous reset, clk = 0 when reset is 0.
    begin
       if (resetA)
        begin
            counter=0;
            outsignal=0;
        end
        else
        begin
            counter = counter +1; //every positive edge of clock would +1
            counter2 = counter2 +1;
            if (counter == 2) //every 1s toggle, -+- is a wave, toggle twice, so T = 2.5ms, f = 400Hz
            begin
                outsignal=~outsignal;
                counter =0;
                type = 1;
            end
            if (counter2 == 5) //every 1s toggle, -+- is a wave, toggle twice, so T = 2s, f = 0.5Hz
            begin
                outsignal=~outsignal;
                counter2 =0;
                type = ~type;
            end
            
         end
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2022 03:15:21 PM
// Design Name: 
// Module Name: vision_test
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


module vision_test;
reg sclk, rA;
wire outsignal, type;
wire[1:0]Q1;
wire [6:0] CA1;
wire [7:0] AN1;
slowerClkGen clking(sclk, rA,outsignal, type);
upcounter counting(sclk, Q1);
muxdisplay dis(Q1, type, CA1, AN1);

initial begin
rA = 0; sclk = 0;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
#2 sclk=~sclk;
end

endmodule




`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2022 09:42:50 AM
// Design Name: 
// Module Name: JKFF
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


module JKFF(input J, K, clk, sclr, output reg Q, reg Qn);
reg Q = 0; //asynchronous preset
always@(posedge clk)//synchronous reset
begin
    if(!sclr)
        Q = 0;
    else
    begin
        case({J, K})
            2'b01: Q <= 0;
            2'b10: Q <= 1;
            2'b11: Q <= ~Q;
            default: Q <= Q; 
        endcase
    end
    Qn = ~Q;
end

endmodule


module JKFF_testbench;
reg j,k,CLK, nCLR;
wire q, qn;

JKFF uut( .J(j), .K(k), .clk(CLK), .sclr(nCLR), .Q(q), .Qn(qn));

initial begin
    {j, k} = 2'b00; CLK=0; nCLR = 1;
    #2 CLK=~CLK;
    #1 {j, k} = 2'b01; 
    #1 CLK=~CLK;
    #1 {j, k} = 2'b10; nCLR = 0;
    #1 CLK=~CLK;
    #2 {j, k} = 2'b11; CLK=~CLK; nCLR = 1;
    #1 {j, k} = 2'b10;
    #1 CLK=~CLK; 
    
    
end
endmodule    
    


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2022 03:06:27 PM
// Design Name: 
// Module Name: week5_testb
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


module week5();
endmodule

module TFF(input clr, clk, T, output reg q, qn);
initial begin
q = 0;
end
always @(negedge clk, negedge clr)
begin
    if(!clr)
        q = 0;
    else
    begin
        q = T?~q:q;
    end
    qn = ~q;
end
endmodule


module week5_testb;
reg t, cr, ck;
wire qq, qqn;
TFF uut(.T(t), .clk(ck), .clr(cr),.q(qq), .qn(qqn));

    initial begin
    {t, cr, ck} = 3'b010;
        #1 t = ~t;
        #1 ck = ~ck;
        #1 t = ~t; 
        #2 ck = ~ck;
        #3 ck = ~ck;
        #1 t = ~t;
        #2 ck = ~ck;
        #3 ck = ~ck;
        #1 t = ~t;
        #2 ck = ~ck;
        #1 t = ~t;
        #2 ck = ~ck;
        #3 ck = ~ck;
        #1 t = ~t;        
    end
endmodule



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


module adder4bits(input Cin, [3:0]x, [3:0]y, output cout, [3:0]s);
    fulladd add1(Cin, x[0],y[0], s[0],c1);
    fulladd add2(c1, x[1], y[1],s[1],c2);
    fulladd add3(c2, x[2],y[2],s[2],c3);
    fulladd add4(c3, x[3], y[3],s[3],cout); 
endmodule




module fulladd(input cin,x1,x2, output s, cout);
    //assign f = (x1&x2)|(~x2&x3);
    assign s = x1^x2^cin, cout = (x1&x2)|(x1&cin)|(x2&cin);
endmodule


module adder4nbits_testbench;
reg[3:0] xin, yin;
reg c;
wire[3:0] sum;
wire out;
adder4bits uut(.x(xin), .y(yin), .Cin(c), .s(sum), .cout(out));

initial begin
    xin = 0;
    yin = 0;
    c = 0;
    #1 xin = 1; yin = 1;
    #1 xin = 15; yin =15;
    #1 c = 1;
    #1 xin = 0;
    #1 yin = 0;
    
end
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
////////////////////////////////////////

module MUX(s, A, B, F);
input [2:0] s;
input [3:0] A, B;
output reg[3:0] F;
always @(*)
case (s)
0: F = 0;
1: F = B-A;
2: F = A-B;
3: F = A+B;
4: F = A^B;
5: F = A|B;
6: F = A&B;
7: F = 4'b1111;
endcase
endmodule  
//////////////

module MUX_testbench;

reg[2:0] select;
reg[3:0] d1, d2;
wire[3:0] out;
MUX uut(select, d1, d2, out);

initial begin
    select = 0;
    d1 = 4'b1010;
    d2 = 4'b0011;
    #1 select = 1;
    #1 select = 2;
    #1 select = 3;
    #1 select = 4;
    #1 select = 5;
    #1 select = 6;
    #1 select = 7;
    
end

