`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2022 02:52:47 PM
// Design Name: 
// Module Name: TB_cache
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


module TB_cache;
wire [31:0]address;
reg mem_read;
wire done;
reg clk;
wire [31:0] hit_counter;
wire [31:0] miss_counter;
cache cache(
address,
mem_read,
miss_counter,
hit_counter,
done,
clk
);
integer i;
reg [31:0]ADDRESSES[31:0];
assign address = ADDRESSES[i];
initial begin
clk <= 0;
    while(1) begin
    #1;
    clk <= ~clk;
    end
end
initial begin
i <= 0;
mem_read <= 0;
ADDRESSES[0] <= 'h00000001;
ADDRESSES[1] <= 'h0000000F;
ADDRESSES[2] <= 'h000000A1;
ADDRESSES[3] <= 'h00000BF1;
ADDRESSES[4] <= 'h00000001;
ADDRESSES[5] <= 'h0FFFFFFF;
ADDRESSES[6] <= 'h000000F1;
ADDRESSES[7] <= 'h00000F01;
ADDRESSES[8] <= 'h0000F001;
ADDRESSES[9] <= 'h000F0001;
ADDRESSES[10] <= 'h0F000001;
ADDRESSES[11] <= 'hF0000001;
ADDRESSES[12] <= 'h0A000001;
ADDRESSES[13] <= 'h000A0001;
ADDRESSES[14] <= 'h0000A001;
ADDRESSES[15] <= 'h00000A01;
ADDRESSES[16] <= 'h000000A1;
ADDRESSES[17] <= 'h00000001;
ADDRESSES[18] <= 'h0000000F;
ADDRESSES[19] <= 'h000000A1;
ADDRESSES[20] <= 'h00000BF1;
#5;
    while (1) begin
    #2;
        if (done) begin
            i = i+1;
            mem_read <= 1;
        end
        else begin
            mem_read <= 0;
        end
    end
end

endmodule
