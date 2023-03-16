`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2023 05:25:02 PM
// Design Name: 
// Module Name: lab7-q5
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
// Code your design here
module negate(input [3:0] in, output [3:0] out);
  assign out= (~in)+1;
endmodule

module hexEncode(input [3:0] bin, output wire [7:0] hex);

  wire A,B,C,D;

  assign A = bin[3];
  assign B = bin[2];
  assign C = bin[1];
  assign D = bin[0];


    assign hex[7] = 1;
    assign hex[6] = (~A & ~B & ~C & ~D) | (~A & ~B & ~C & D) | (~A & B & C & D);
    assign hex[5] = (~A & ~B & ~C & D) | (~A & ~B & C & ~D) | (~A & ~B & C & D) | (~A & B & C & D) | (A & B & ~C & D);
    assign hex[4] = (~A & ~B & ~C & D) | (~A & ~B & C & D) | (~A & B & ~C & ~D) | (~A & B & ~C & D) | (~A & B & C & D) | (A & ~B & ~C & D);
    assign hex[3] = (~A & ~B & ~C & D) | (~A & B & ~C & ~D) | (~A & B & C & D) | (A & ~B & C & ~D) | (A & B & C & D);
    assign hex[2] = (~A & ~B & C & ~D) | (A & B & ~C & ~D) | (A & B & C & ~D) | (A & B & C & D);
    assign hex[1] = (~A & B & ~C & D) |  (~A & B & C & ~D) | (A & ~B & C & D) |  (A & B & ~C & ~D) | (A & B & C & ~D) |  (A & B & C & D);
  assign hex[0] = (~A & B & ~C & ~D) | (A & ~B & C & D) | (A & B & ~C & D) | (~A&~B&~C&D);
endmodule

module tld(
input [15:0] sw,
output [7:0] D0_seg, D1_seg,
output [3:0] D0_a, D1_a
);
//Sign Checker
assign D0_seg = sw[3] ? 8'b10111111 : 8'b11111111;
  assign D0_a = sw[3] ? 4'b1110 : 4'b1111;
//Negation input
  wire [3:0]tempNeg,ans;
negate n1(sw[3:0], tempNeg);
//Check to see if input is negative and then perform 2's compliment
assign ans = sw[3] ? tempNeg : sw[3:0];
  hexEncode h1(ans, D1_seg);
assign D1_a = 4'b1110;
endmodule


