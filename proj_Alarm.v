`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2022 11:32:53 AM
// Design Name: 
// Module Name: alarm
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


module alarm( );
endmodule

module addTime(input clk, btn, clr, output[3:0] numb);
reg[3:0] count;
always@(posedge clk)
begin
    if(clr)
    begin
        count<=0;
    end
    else
    begin
        if(btn == 1)
        begin
            if(count == 9)
                count<=0;
            else
                count <=count+1;
        end
    end
end
assign numb = count;
endmodule

module setTime(input clk, btn, clr, input[3:0] switch, output reg[3:0]ANH);
always@(posedge clk)
begin
    case(switch)
    4'b0001: ANH = ~switch;
    4'b0010: ANH = ~switch;
    4'b0100: ANH = ~switch;
    4'b1000: ANH = ~switch;
    endcase
end
endmodule

module onehr(input sclk, input rA, output[6:0]CA, output [3:0] AN);
wire outsignal, secsig, minsig, un;
wire [1:0] Qp;
wire [5:0] Qs, Qm;
slowerClkGen clking(sclk, rA, outsignal, secsig);
upcounter counting(outsignal, Qp);
upcounterBCD sec(secsig, Qs,minsig);
upcounterBCD min(minsig, Qm, un);
muxdisplay display(Qp,Qs,Qm, CA, AN);
endmodule

module muxdisplay(input [1:0]counterAN,[5:0]counterCAs, counterCAm, output [6:0]CA, reg [3:0] ANL);
reg [3:0] num;
always@(*)
begin
    case(counterAN)
    2'b00: 
    begin
        ANL = 4'b1110;
        num = counterCAs%10;
    end
    2'b01: 
    begin
        ANL = 4'b1101;
        num = counterCAs/10;
    end
    2'b10: 
    begin
        ANL = 8'b1011;
        num = counterCAm%10;
    end
    2'b11: 
    begin
        ANL = 8'b0111;
        num = counterCAm/10;
    end
    endcase    
end    
segment7_control CAcontrol(num, CA);
endmodule

module segment7_control(input[3:0]num, output reg [6:0]C);
    always@(num)
    begin
        case(num)
            0: C = 1;
            1: C = 7'b1001111; //4F
            2: C = 7'b0010010;//12
            3: C = 7'b0000110;//06
            4: C = 7'b1001100;//4C
            5: C = 7'b0100100;//24
            6: C = 7'b0100000;//20
            7: C = 7'b0001111;//0F
            8: C = 0;
            9: C = 7'b0001100;//0C
        endcase
    end
endmodule

module upcounterBCD(input Clock, output [5:0] Qa, output msig);
reg [5:0] Qa = 0; //before clk, Qa =0
reg msig = 0;
always @(posedge Clock)
begin       
    Qa = Qa+1;//Qa = 59+1 = 60
    msig = 0;
    if(Qa == 60)//Qa = 60,
    begin
        Qa = 0;//
        msig = 1;
    end
end

endmodule

module vision(input sclk, input rA, output[6:0]CA, output [7:0] AN);
wire outsignal;
wire [1:0] Qp;
slowerClkGen clking(sclk, rA, outsignal, type);
upcounter counting(outsignal, Qp);
muxdisplay display(type, Qp, CA, AN);
endmodule

////??
//module muxdisplay(input switch,[1:0] counter, output reg[6:0]CA, reg [7:0] AN);
//always@(*)
//begin
//    case(counter)
//    2'b00: 
//    begin
//        AN = 8'b1111_1110;
//        CA = switch?7'b100_1111:7'b000_1000;
//    end
//    2'b01: 
//    begin
//        AN = 8'b1111_1101;
//        CA = switch?7'b001_0010:7'b110_0000;
//    end
//    2'b10: 
//    begin
//        AN = 8'b1111_1011;
//        CA = switch?7'b000_0110:7'b011_0001;
//    end
//    2'b11: 
//    begin
//        AN = 8'b1111_0111;
//        CA = switch?7'b100_1100:7'b100_0010;
//    end
//    endcase    
//end    
//endmodule

module upcounter (input Clock, output reg [1:0] Q);
reg[1:0] Q = 0;
reg switch;
always @(posedge Clock) //Q = 0 when reset is 0.
begin
    
        Q <= Q + 1;
end
endmodule

//remove the second clock, we need a switch between set.
module slowerClkGen(input clk, resetA, output outsignal, type);
reg [17:0] counter = 0;
reg [26:0] counter2 = 0;  
reg outsignal = 0;
reg type;
initial begin
type = 1;
end
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
            if (counter == 125_000) //every 1s toggle, -+- is a wave, toggle twice, so T = 2.5ms, f = 400Hz
            begin
                outsignal=~outsignal;
                counter =0;
            end
            if (counter2 == 50_000_000) //every 1s toggle, -+- is a wave, toggle twice, so T = 1s, f = 1Hz
            begin
                counter2 =0;
                type = ~type;
            end
            
         end
    end
endmodule

module SongPlayer( input clock, input reset, input playSound, output reg 
audioOut, output wire aud_sd);
reg [19:0] counter;
reg [31:0] time1, noteTime;
reg [9:0] msec, number; //millisecond counter, and sequence number of musical note.
wire [4:0] note, duration;
wire [19:0] notePeriod;
parameter clockFrequency = 100_000_000; 
assign aud_sd = 1'b1;
MusicSheet  mysong(number, notePeriod, duration );
always @ (posedge clock) 
  begin
if(reset | ~playSound) 
 begin 
          counter <=0;  
          time1<=0;  
          number <=0;  
          audioOut <=1;
      end
else 
begin
counter <= counter + 1; 
time1<= time1+1;
if( counter >= notePeriod) 
   begin
counter <=0;  
audioOut <= ~audioOut ; 
   end //toggle audio output 
if( time1 >= noteTime) 
begin
time1 <=0;  
number <= number + 1; 
end  //play next note
 if(number == 64) number <=0; // Make the number reset at the end of the song
end
  end
        
always @(duration)
begin 
    noteTime = duration * clockFrequency/8;
 end 
       //number of   FPGA clock periods in one note.
endmodule   

module MusicSheet( input [9:0] number, output reg [19:0] note,//max ? different musical notes
output reg [4:0] duration);
parameter QUARTER = 5'b00010;
parameter HALF = 5'b00100;
parameter ONE = 2* HALF;
parameter TWO = 2* ONE;
parameter FOUR = 2* TWO;
parameter C4= 50_000_000/525, D4= 50_000_000/587, F4= 50_000_000/698.5, G4 = 50_000_000/784, A4 = 50_000_000/880;
parameter B4b = 50_000_000/932, D5 = 50_000_000/1175, C5 = 50_000_000/1047, SP = 1;   
always @ (number) begin
case(number) //Row Row Row your boat
1: begin note = F4; duration = ONE; end //row
2: begin note = F4; duration = HALF; end //
3: begin note = C4; duration = HALF; end //row
4: begin note = F4; duration = HALF; end //
5: begin note = A4; duration = HALF; end //row
6: begin note = F4; duration = HALF; end //
7: begin note = A4; duration = HALF; end //your
8: begin note = C5; duration = ONE; end //boat
9: begin note = B4b; duration = ONE; end //
10: begin note = A4; duration = HALF; end //gently
11: begin note = C5; duration = HALF; end //
12: begin note = A4; duration = HALF; end //down
13: begin note = G4; duration = HALF; end //
14: begin note = F4; duration = HALF; end //
15: begin note = G4; duration = HALF; end //the
16: begin note = F4; duration = ONE; end //stream
17: begin note = F4; duration = ONE; end //
18: begin note = F4; duration = HALF; end //
19: begin note = C4; duration = HALF; end //row
20: begin note = F4; duration = HALF; end //
21: begin note = A4; duration = HALF; end //row
22: begin note = F4; duration = HALF; end //
23: begin note = A4; duration = HALF; end //your
24: begin note = C5; duration = ONE; end //boat
25: begin note = B4b; duration = ONE; end //
26: begin note = A4; duration = HALF; end //gently
27: begin note = C5; duration = HALF; end //
28: begin note = A4; duration = HALF; end //down
29: begin note = G4; duration = HALF; end //
30: begin note = F4; duration = HALF; end //
31: begin note = G4; duration = HALF; end //the
32: begin note = F4; duration = ONE; end //stream
33: begin note = C5; duration = ONE; end //
34: begin note = C5; duration = HALF; end //the
35: begin note = A4; duration = HALF; end //stream
36: begin note = C5; duration = HALF; end //
37: begin note = C5; duration = HALF; end //merrily
38: begin note = A4; duration = HALF; end //
39: begin note = C5; duration = HALF; end //
40: begin note = D5; duration = ONE; end //
41: begin note = A4; duration = HALF; end //
42: begin note = C5; duration = HALF; end //
43: begin note = C5; duration = HALF; end //
44: begin note = C5; duration = HALF; end //
45: begin note = B4b; duration = HALF; end //
46: begin note = A4; duration = HALF; end //
47: begin note = G4; duration = ONE; end //
48: begin note = F4; duration = ONE; end //
49: begin note = F4; duration = HALF; end //
50: begin note = C4; duration = HALF; end //
51: begin note = F4; duration = HALF; end //
52: begin note = A4; duration = HALF; end //
53: begin note = F4; duration = HALF; end //
54: begin note = A4; duration = HALF; end //
55: begin note = C5; duration = ONE; end //
56: begin note = B4b; duration = ONE; end //
57: begin note = A4; duration = HALF; end //
58: begin note = C5; duration = HALF; end //
59: begin note = A4; duration = HALF; end //
60: begin note = G4; duration = HALF; end //
61: begin note = F4; duration = HALF; end //
62: begin note = G4; duration = HALF; end //
63: begin note = F4; duration = ONE; end //
default: begin note = SP; duration = ONE; end
endcase
end
endmodule
