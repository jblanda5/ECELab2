`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2022 04:31:24 PM
// Design Name: 
// Module Name: control
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


module control(
input wire [0:10]Opcode,
output reg [0:1]ALUOp,
output reg ALUSrc,
output reg Branch,
output reg MemRead,
output reg MemWrite,
output reg RegWrite,
output reg MemtoReg
);
always @(*) begin
    case(Opcode)
       11'b10001011000: begin//Add
            ALUSrc <= 1'b0;
            MemtoReg <= 1'b0;
            RegWrite <= 1'b1;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            Branch <= 1'b0;
            ALUOp <= 2'b10;
        end
        11'b11001011000: begin //Subtract
            ALUSrc <= 1'b0;
            MemtoReg <= 1'b0;
            RegWrite <= 1'b1;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            Branch <= 1'b0;
            ALUOp <= 2'b10;
        end
        11'b10001010000: begin //AND
            ALUSrc <= 1'b0;
            MemtoReg <= 1'b0;
            RegWrite <= 1'b1;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            Branch <= 1'b0;
            ALUOp <= 2'b10;
        end
        11'b10101010000: begin //OR
            ALUSrc <= 1'b0;
            MemtoReg <= 1'b0;
            RegWrite <= 1'b1;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            Branch <= 1'b0;
            ALUOp <= 2'b10;
        end
        11'b00000000001: begin //LDUR
            ALUSrc <= 1'b1;
            MemtoReg <= 1'b1;
            RegWrite <= 1'b1;
            MemRead <= 1'b1;
            MemWrite <= 1'b0;
            Branch <= 1'b0;
            ALUOp <= 2'b00;
        end
        11'b000000000010: begin //STUR
            ALUSrc <= 1'b1;
            MemtoReg <= 1'b0;
            RegWrite <= 1'b0;
            MemRead <= 1'b0;
            MemWrite <= 1'b1;
            Branch <= 1'b0;
            ALUOp <= 2'b00;
        end
        11'b00000000011: begin //CBZ
            ALUSrc <= 1'b0;
            MemtoReg <= 1'b0;
            RegWrite <= 1'b0;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            Branch <= 1'b1;
            ALUOp <= 2'b01;
        end
        11'b00000000100: begin //B
            ALUSrc <= 1'b0;
            MemtoReg <= 1'b0;
            RegWrite <= 1'b0;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            Branch <= 1'b0;
            ALUOp <= 2'b01;
        end
        default: begin
            ALUSrc <= 1'b0;
            MemtoReg <= 1'b0;
            RegWrite <= 1'b0;
            MemRead <= 1'b1;
            MemWrite <= 1'b0;
            Branch <= 1'b0;
            ALUOp <= 2'b00;
        end
    endcase
end
endmodule
