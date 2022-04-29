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
reg [31:0]ADDRESSES[59999:0];
assign address = ADDRESSES[i];

//Read from file, load addresses with values.
integer data_file;
integer scan_file;
integer i;
initial begin
    data_file = $fopen("trace1.txt","r");
    if (data_file == 0) begin
        $display("data_file handle was NULL");
        $finish;
    end
    for (i=0;i<57432;i=i+1) begin //57432 for trace1, 59855 for trace2
        ADDRESSES[i] = 0;
        scan_file = $fscanf(data_file, "%d\n", ADDRESSES[i]);
    end
    #1;
    $fclose(data_file);
end

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