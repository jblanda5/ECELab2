`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2022 03:53:01 PM
// Design Name: 
// Module Name: Sign_Extend
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


module Sign_Extend(
input wire [31:0]Instruction,
output wire [63:0]Instruction_Sign_Extend
);
assign Instruction_Sign_Extend = Instruction[31] ? ('hffffffff00000000 + Instruction) : Instruction+64'b0;
endmodule
