`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2022 12:40:15 PM
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(
input wire [3:0]IDEX_Rd,
input wire [3:0]IDEX_Rn,
input wire [3:0]IDEX_Rm,
input wire [3:0]EXMEM_Rd,
input wire [3:0]EXMEM_Rn,
input wire [3:0]EXMEM_Rm,
input wire [3:0]MEMWB_Rd,
input wire [3:0]MEMWB_Rn,
input wire [3:0]MEMWB_Rm,
output reg [1:0]forward_a,
output reg [1:0]forward_b
);
always @(*) begin
    case(IDEX_Rn) //Input A is Rn
        EXMEM_Rd: begin
            forward_a <= 2'b01;
        end
        
        MEMWB_Rd: begin
            forward_a <= 2'b10;
        end
        
        default: begin //doesnt match
            forward_a <= 2'b00;
        end
    endcase
    
    case(IDEX_Rm) //Input A is Rn
        EXMEM_Rd: begin
            forward_b <= 2'b01;
        end
        
        MEMWB_Rd: begin
            forward_b <= 2'b10;
        end
        
        default: begin //doesn't match
            forward_b <= 2'b00;
        end
    endcase
end
endmodule
