`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2022 02:10:53 PM
// Design Name: 
// Module Name: max
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


module max(
input wire [63:0]a,
input wire [63:0]b,
input wire [63:0]c,
input wire [63:0]d,
input wire [63:0]e,
input wire [63:0]f,
input wire [63:0]g,
input wire [63:0]h,
input wire [63:0]i,
input wire [63:0]j,
input wire [63:0]k,
input wire [63:0]l,
input wire [63:0]m,
input wire [63:0]n,
input wire [63:0]o,
input wire [63:0]p,
output wire [63:0]max_value
    );
wire [63:0] ab;
wire [63:0] cd;
wire [63:0] ef;
wire [63:0] gh;
wire [63:0] ij;
wire [63:0] kl;
wire [63:0] mn;
wire [63:0] op;

assign ab = (a>=b) ? a : b;
assign cd = (c>=d) ? c : d;
assign ef = (e>=f) ? e : f;
assign gh = (g>=h) ? g : h;
assign ij = (i>=j) ? i : j;
assign kl = (k>=l) ? k : l;
assign mn = (m>=n) ? m : n;
assign op = (o>=p) ? o : p;

wire [63:0] abcd;
wire [63:0] efgh;
wire [63:0] ijkl;
wire [63:0] mnop;

assign abcd = (ab>=cd) ? ab : cd;
assign efgh = (ef>=gh) ? ef : gh;
assign ijkl = (ij>= kl) ? ij : kl;
assign mnop = (mn >= op) ? mn : op;

wire [63:0] abcdefgh;
wire [63:0] ijklmnop;

assign abcdefgh = (abcd >= efgh) ? abcd : efgh;
assign ijklmnop = (ijkl >= mnop) ? ijkl : mnop;

assign max_value = (abcdefgh >= ijklmnop) ? abcdefgh : ijklmnop;
endmodule
