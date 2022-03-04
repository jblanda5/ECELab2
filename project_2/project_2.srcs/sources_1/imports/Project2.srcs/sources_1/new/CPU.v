`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2022 02:33:06 PM
// Design Name: 
// Module Name: CPU
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

module CPU(
output wire [31:0]mem_addr, //Data Memory Address 
output wire [31:0]write_data, //Data Memory Write Data
input wire [31:0]read_data, //Data Memory Read Data
output wire mem_write,
output wire mem_read,
output reg [31:0]PC, //Instruction Memory Instruction Address
input wire [31:0]instr_data, //Instruction Memory Instruction Data
input wire clk, //Clock Signal
input wire reset //Reset wire
);
///////////////////////////////////////////
//
//    Instantiate Pipeline registers
//
///////////////////////////////////////////
//Instruction Fetch/Decode Stage Registers
reg [31:0]IFID_Instruction;
reg [31:0]IFID_Instruction_Addr;

//Instruction Decode/Execute Stage Registers
reg [10:0]IDEX_ALU_Opcode;
reg [4:0]IDEX_Write_Reg;
reg [31:0]IDEX_Instruction_Addr;
reg [63:0]IDEX_Instruction_Sign_Ex;
reg [63:0]IDEX_Reg_Read_Data_1;
reg [63:0]IDEX_Reg_Read_Data_2;
reg [1:0]IDEX_ALU_Op;
reg IDEX_ALUSrc;
reg IDEX_Branch;
reg IDEX_MemRead;
reg IDEX_MemWrite;
reg IDEX_RegWrite;
reg IDEX_MemtoReg;

//Execute/Memory Stage Registers
reg [31:0]EXMEM_Add_Result;
reg [63:0]EXMEM_Reg_Read_Data_2;
reg [4:0]EXMEM_Write_Reg;
reg EXMEM_Branch;
reg EXMEM_MemRead;
reg EXMEM_MemWrite;
reg EXMEM_RegWrite;
reg EXMEM_MemtoReg;
wire PCSrc;
assign mem_addr = ALU_Result;
assign write_data = EXMEM_Reg_Read_Data_2;
assign mem_read = EXMEM_MemRead;
assign mem_write = EXMEM_MemWrite;
assign PCSrc = zero & EXMEM_Branch;

//Memory/Write Back Stage Registers
reg [31:0]MEMWB_Read_Data;
reg MEMWB_RegWrite;
reg MEMWB_MemtoReg;
reg [4:0]MEMWB_Write_Reg;
reg [63:0]MEMWB_ALU_Result;

///////////////////////////////////////////
//
//    Add Modules
//
///////////////////////////////////////////

//Add Sign Extend Module
wire [63:0]Instruction_Sign_Ex;
Sign_Extend Sign_Extend(
.Instruction(IFID_Instruction),
.Instruction_Sign_Extend(Instruction_Sign_Ex)
);
//Add Instruction Control Module
wire [1:0]ALUOp;
wire ALUSrc;
wire MemRead;
wire MemWrite;
wire RegWrite;
wire MemtoReg;
control control(
.Opcode(IFID_Instruction[31:21]),
.ALUOp(ALUOp),
.ALUSrc(ALUSrc),
.Branch(Branch),
.MemRead(MemRead),
.MemWrite(MemWrite),
.RegWrite(RegWrite),
.MemtoReg(MemtoReg)
);
//Add ALU Control Module
wire [3:0]ALU_Control;
ALU_Ctrl ALU_Ctrl(
.Opcode_Field(IDEX_ALU_Opcode),
.ALU_OP(IDEX_ALU_Op),
.ALU_Control(ALU_Control)
);
//ALU MUX
wire [63:0]ALU_In_2;
wire [63:0]ALU_Result;
wire zero;
wire [63:0]read_data_2;
assign ALU_In_2 = IDEX_ALUSrc ? IDEX_Instruction_Sign_Ex : IDEX_Reg_Read_Data_2;
//Add ALU Module
ALU ALU(
.a(IDEX_Reg_Read_Data_1),
.b(ALU_In_2),
.ALUresult(ALU_Result),
.zero(zero),
.ALUControl(ALU_Control),
.clk(clk)
);

//Add Registers Module
wire [63:0]read_data_1;
wire [4:0]RegIn2;
wire [63:0]reg_write_data;
assign RegIn2 = IFID_Instruction[28] ? IFID_Instruction[20:16] : IFID_Instruction[4:0]; // Rm : Rd
assign reg_write_data = MEMWB_MemtoReg ? MEMWB_Read_Data : MEMWB_ALU_Result;
Registers Registers(
.RegWriteControl(MEMWB_RegWrite),
.RegWriteData(reg_write_data),
.RegIn1(IFID_Instruction[9:5]),
.RegIn2(RegIn2),
.RegWriteNum(MEMWB_Write_Reg),
.RegReadData1(read_data_1),
.RegReadData2(read_data_2),
.CLK(clk),
.reset(reset)
);

///////////////////////////////////////////
//
//    On Clock Cycles...
//
///////////////////////////////////////////

always @(posedge reset) begin
    PC <= 0;
    
    //Instruction Fetch/Decode Stage Registers
    IFID_Instruction <= 0;
    IFID_Instruction_Addr <= 0;

    //Instruction Decode/Execute Stage Registers
    IDEX_ALU_Opcode <=0;
    IDEX_Instruction_Addr <= 0;
    IDEX_Instruction_Sign_Ex <= 0;
    IDEX_ALU_Op <= 0;
    IDEX_ALUSrc <= 0;
    IDEX_Branch <= 0;
    IDEX_MemRead <= 0;
    IDEX_MemWrite <= 0;
    IDEX_RegWrite <= 0;
    IDEX_MemtoReg <= 0;
    IDEX_Write_Reg <= 0;

    //Execute/Memory Stage Registers
    EXMEM_Add_Result <= 0;
    EXMEM_Reg_Read_Data_2 <= 0;
    EXMEM_Branch <= 0;
    EXMEM_MemRead <= 0;
    EXMEM_RegWrite <= 0;
    EXMEM_MemtoReg <= 0;
    EXMEM_Write_Reg <= 0;

    //Memory/Write Back Stage Registers
    MEMWB_Read_Data <= 0;
    MEMWB_RegWrite <= 0;
    MEMWB_MemtoReg <= 0;
    MEMWB_Write_Reg <= 0;
end

always @(posedge clk) begin
    //Instruction Fetch Portion
    PC <=  PCSrc ? EXMEM_Add_Result : (PC + 3'b100);
    IFID_Instruction <= instr_data;
    IFID_Instruction_Addr <= PC;
    
    //Instruction Decode Portion
    IDEX_Instruction_Sign_Ex <= Instruction_Sign_Ex; //Set IDEX Instruction Sign Extended register
    IDEX_ALU_Opcode <= IFID_Instruction[31:21]; //Extract ALU Opcode from Instruction
    IDEX_Write_Reg <= IFID_Instruction[4:0]; //Extract Register Write from Instruction
    IDEX_Instruction_Addr <= IFID_Instruction_Addr; //Pipeline Instruction Address
    IDEX_ALU_Op <= ALUOp;
    IDEX_ALUSrc <= ALUSrc;
    IDEX_Branch <= Branch;
    IDEX_MemRead <= MemRead;
    IDEX_MemWrite <= MemWrite;
    IDEX_RegWrite <= RegWrite;
    IDEX_MemtoReg <= MemtoReg;
    IDEX_Reg_Read_Data_1 <= read_data_1;
    IDEX_Reg_Read_Data_2 <= read_data_2;
    
    //Instruction Execute Portion
    EXMEM_Add_Result <= IDEX_Instruction_Addr + (IDEX_Instruction_Sign_Ex << 2);
    EXMEM_Branch <= IDEX_Branch;
    EXMEM_MemRead <= IDEX_MemRead;
    EXMEM_MemWrite <= IDEX_MemWrite;
    EXMEM_RegWrite <= IDEX_RegWrite;
    EXMEM_MemtoReg <= IDEX_MemtoReg;
    EXMEM_Reg_Read_Data_2 <= IDEX_Reg_Read_Data_2;
    EXMEM_Write_Reg <= IDEX_Write_Reg;
    
    //Memory Access Portion
    MEMWB_Read_Data <= read_data;
    MEMWB_RegWrite <= EXMEM_RegWrite;
    MEMWB_MemtoReg <= EXMEM_MemtoReg;
    MEMWB_Write_Reg <= EXMEM_Write_Reg;
    MEMWB_ALU_Result <= ALU_Result;
    
    //Write Back Portion
end

endmodule
