`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2022 03:34:10 PM
// Design Name: 
// Module Name: TB_CPU
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


module TB_CPU;
reg clk;
reg reset;
wire mem_write;
wire mem_read;
wire [31:0]mem_addr;
wire [31:0]write_data;
wire [31:0]read_data;
wire [31:0]PC;
wire [31:0]instr_data;
CPU TBCPU(
mem_addr, //Data Memory Address 
write_data, //Data Memory Write Data
read_data, //Data Memory Read Data
mem_write,
mem_read,
PC, //Instruction Memory Instruction Address
instr_data, //Instruction Memory Instruction Data
clk, //Clock Signal
reset //Reset wire
);
reg [31:0]MEMORY[16:0]; //16 Memory locations
reg [31:0]INSTRUCTION[64:0]; //64 Instructions

assign instr_data = INSTRUCTION[PC[7:2]];
assign read_data = MEMORY[mem_addr[3:0]];

initial begin
//Default Memory Data:
MEMORY[1] <= 32'b10101010101010101010101010101010;
//Instructions
//Data Hazard testing:
INSTRUCTION[0] <= 32'b10001011000000000000000001000101; //ADD r5 r2 r0 (r5 = r2+r0)
//INSTRUCTION[1] <= 32'b00000000000000000000000000000000; //NO OP
//INSTRUCTION[1] <= 32'b10001011000001110000000011100101; //ADD r5 r7 r7 (r5 = r7+r7)
INSTRUCTION[1] <= 32'b10001011000000100000000010100101; //ADD r5 r5 r2 (r5 = r5+r0)

/* //Structural Hazard testing:
INSTRUCTION[0] <= 32'b00010000011000000000000000100001;
INSTRUCTION[1] <= 32'b10001011000001110000000011100101;
INSTRUCTION[2] <= 32'b10001011000000000000000001000101;
INSTRUCTION[3] <= 32'b10001011000000100000000010100101;
INSTRUCTION[33] <= 32'b00000000000000000000000000000000;
INSTRUCTION[34] <= 32'b00000000000000000000000000000000;
INSTRUCTION[35] <= 32'b00000000000000000000000000000000;
*/
end


initial begin

clk <= 0;
reset <= 0;
#1;
reset <= 1;
#1;
reset <= 0;
while (1) begin
    #1;
    clk <= ~clk;
end
end

initial begin
#3;
    while(1) begin
    if (mem_write) begin
        MEMORY[mem_addr[3:0]] <= write_data;
    end
    #1;
    end
end

endmodule
