`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module Decoder(input [2:0] data, output reg [7:0] y);
    always @data
    begin
        y=0;
        y[data] = 1;
    end
endmodule

/////////////////////////////////////////////////////////////////////////////////
module Decoder(input [5:0] data, output reg [32:0] y);
    always @data
    begin
        y=0;
        y[data] = 1;
    end
endmodule

/////////////////////////////////////////////////////////////////////////////////

module Decoder(input [6:0] data, output reg [64:0] y);
    always @data
    begin
        y=0;
        y[data] = 1;
    end
endmodule
