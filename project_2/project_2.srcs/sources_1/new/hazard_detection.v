`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2022 02:28:56 PM
// Design Name: 
// Module Name: hazard_detection
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


module hazard_detection(
input wire PCSrc,
output reg mux_select,
input wire clk
);
reg state;
always @(posedge clk) begin
    case (state)
        1'b0: begin
            if (PCSrc == 1) begin
                mux_select <= 1;
            end
            else begin
                mux_select <= 0;
            end
        end
        default: begin
            mux_select <= 0;
            state <= 0;
        end
    endcase
end
endmodule
