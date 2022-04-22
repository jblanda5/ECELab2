`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2022 01:11:21 PM
// Design Name: 
// Module Name: TB_dat_cache
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


module TB_dat_cache();

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
mem_read <= 1;
//Load memory register from dat file

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