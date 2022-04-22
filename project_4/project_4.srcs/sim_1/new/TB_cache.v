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
wire [23:0]address;
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
reg [23:0]ADDRESSES[60000:0];
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
mem_read <= 1;
ADDRESSES[0] <= 'h000001;
ADDRESSES[1] <= 'h00000F;
ADDRESSES[2] <= 'h0000A1;
ADDRESSES[3] <= 'h000BF1;
ADDRESSES[4] <= 'h000001;
ADDRESSES[5] <= 'h0FFFFF;
ADDRESSES[6] <= 'h0000F1;
ADDRESSES[7] <= 'h000F01;
ADDRESSES[8] <= 'h00F001;
ADDRESSES[9] <= 'h0F0001;
ADDRESSES[10] <= 'h000001;
ADDRESSES[11] <= 'h00D001;
ADDRESSES[12] <= 'h000001;
ADDRESSES[13] <= 'h0A0001;
ADDRESSES[14] <= 'h00A001;
ADDRESSES[15] <= 'h000A01;
ADDRESSES[16] <= 'h0000A1;
ADDRESSES[17] <= 'h000001;
ADDRESSES[18] <= 'h00000F;
ADDRESSES[19] <= 'h0000A1;
ADDRESSES[20] <= 'h0A0BF1;
ADDRESSES[21] <= 'h0B00A1;
ADDRESSES[22] <= 'h0C0BF1;
ADDRESSES[23] <= 'h0D00A1;
ADDRESSES[24] <= 'h0E0BF1;
ADDRESSES[25] <= 'hf00001;
ADDRESSES[26] <= 'hf0000F;
ADDRESSES[27] <= 'hf000A1;
ADDRESSES[28] <= 'hf00BF1;
ADDRESSES[29] <= 'hf00001;
ADDRESSES[30] <= 'hfFFFFF;
ADDRESSES[31] <= 'hf000F1;
ADDRESSES[32] <= 'hf00F01;
ADDRESSES[33] <= 'hf0F001;
ADDRESSES[34] <= 'hfF0001;
ADDRESSES[35] <= 'hf00001;
ADDRESSES[36] <= 'hf0D001;
ADDRESSES[37] <= 'hf00001;
ADDRESSES[38] <= 'hfA0001;
ADDRESSES[39] <= 'hf0A001;
ADDRESSES[40] <= 'hf00A01;
ADDRESSES[41] <= 'hf000A1;
ADDRESSES[42] <= 'hf00001;
ADDRESSES[43] <= 'hf0000F;
ADDRESSES[44] <= 'hf000A1;
ADDRESSES[45] <= 'hfA0BF1;
ADDRESSES[46] <= 'hfB00A1;
ADDRESSES[47] <= 'hfC0BF1;
ADDRESSES[48] <= 'hfD00A1;
ADDRESSES[49] <= 'hfE0BF1;
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
