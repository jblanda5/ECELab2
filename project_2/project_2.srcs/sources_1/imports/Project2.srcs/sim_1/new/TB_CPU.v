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
wire [0:31]write_addr;
wire [0:31]write_data;
wire [0:31]read_data;
wire [0:31]PC;
wire [0:31]instr_data;
CPU TBCPU(
write_addr, //Data Memory Address 
write_data, //Data Memory Write Data
read_data, //Data Memory Read Data
mem_write,
mem_read,
PC, //Instruction Memory Instruction Address
instr_data, //Instruction Memory Instruction Data
clk, //Clock Signal
reset //Reset wire
);
reg [31:0]MEMORY[3:0]; //16 Memory locations
reg [31:0]INSTRUCTION[3:0]; //16 Instructions

assign instr_data = INSTRUCTION[PC[0:3]];
assign read_data = MEMORY[write_addr[0:3]];

initial begin
//Default Memory Data:
MEMORY[1] <= 32'b10101010101010101010101010101010;
//Instructions
INSTRUCTION[0] <= 32'b00000000001000000000000000000001; //LDUR r1 r0

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
        MEMORY[write_addr] <= write_data;
    end
    #1;
    end
end

endmodule
