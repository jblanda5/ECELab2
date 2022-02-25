`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2022 02:54:42 PM
// Design Name: 
// Module Name: ALU_Ctrl
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


module ALU_Ctrl(
input wire [0:1]ALU_OP,
input wire [0:10]Opcode_Field,
output reg [0:3]ALU_Control
);
always @(*) begin
    case(ALU_OP)
        2'b00: ALU_Control <= 4'b0010; //LDUR/STUR 
        2'b01: ALU_Control <= 4'b0111; //CBZ
        2'b10: begin
            case(Opcode_Field)
                11'b10001011000: ALU_Control <= 4'b0010; //Add
                11'b11001011000: ALU_Control <= 4'b0110; //Subtract
                11'b10001010000: ALU_Control <= 4'b0000; //AND
                11'b10101010000: ALU_Control <= 4'b0001; //OR
                default: ALU_Control <= 4'b0000;
            endcase
        end
        default: ALU_Control <= 4'b0000;
    endcase
end
endmodule
