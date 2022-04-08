`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2022 02:11:37 PM
// Design Name: 
// Module Name: cache
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


module cache(
input wire [31:0]address,
output reg [31:0]data,
input wire mem_read,
output reg done,
input wire clk
    );
//We want to implement a caching system with:
// N=16 (Number of Sets) [log_2(N) = number of bits for index]
// K=16 (Lines per Set) [Shares an index]
// First 4 bits will be index
// Next 28 bits will be the tag
// Next bit will be valid flag
// Last 32 bits will be the data.
reg [31:0]miss_counter;
reg [31:0]hit_counter;
reg [64:0]cache[255:0];
reg [3:0]state;
reg [15:0]lru[255:0]; //counter to track LRU
parameter idle = 4'b0000;
parameter read = 4'b0001;
parameter miss = 4'b0010;
parameter reset = 4'b1111;

always @(posedge (clk)) begin
    case(state)
        reset: begin
            miss_counter <= 0;
            hit_counter <= 0;
            done <= 0;
            state <= idle;
        end
        
        idle: begin
            done <= 0;
            if (mem_read) begin
                state <= read;
            end
        end
        
        read: begin
            case(address)
            
                (cache[(address[31:28]<<4)][64:33]): begin
                    if (cache[(address[31:28] <<4)][32]) begin //Check valid bit
                    lru[address[31:28]<<4] <= 0;
                    lru[(address[31:28]<<4)+1] <= lru[(address[31:28]<<4)+1] + 1;
                    lru[(address[31:28]<<4)+2] <= lru[(address[31:28]<<4)+2] + 1;
                    lru[(address[31:28]<<4)+3] <= lru[(address[31:28]<<4)+3] + 1;
                    lru[(address[31:28]<<4)+4] <= lru[(address[31:28]<<4)+4] + 1;
                    lru[(address[31:28]<<4)+5] <= lru[(address[31:28]<<4)+5] + 1;
                    lru[(address[31:28]<<4)+6] <= lru[(address[31:28]<<4)+6] + 1;
                    lru[(address[31:28]<<4)+7] <= lru[(address[31:28]<<4)+7] + 1;
                    lru[(address[31:28]<<4)+8] <= lru[(address[31:28]<<4)+8] + 1;
                    lru[(address[31:28]<<4)+9] <= lru[(address[31:28]<<4)+9] + 1;
                    lru[(address[31:28]<<4)+10] <= lru[(address[31:28]<<4)+10] + 1;
                    lru[(address[31:28]<<4)+11] <= lru[(address[31:28]<<4)+11] + 1;
                    lru[(address[31:28]<<4)+12] <= lru[(address[31:28]<<4)+12] + 1;
                    lru[(address[31:28]<<4)+13] <= lru[(address[31:28]<<4)+13] + 1;
                    lru[(address[31:28]<<4)+14] <= lru[(address[31:28]<<4)+14] + 1;
                    lru[(address[31:28]<<4)+15] <= lru[(address[31:28]<<4)+15] + 1;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
            
                (cache[(address[31:28]<<4)+1][64:33]): begin
                    if (cache[(address[31:28] <<4)+1][32]) begin
                    lru[address[31:28]<<4] <= lru[address[31:28]<<4] + 1;
                    lru[(address[31:28]<<4)+1] <= 0;
                    lru[(address[31:28]<<4)+2] <= lru[(address[31:28]<<4)+2] + 1;
                    lru[(address[31:28]<<4)+3] <= lru[(address[31:28]<<4)+3] + 1;
                    lru[(address[31:28]<<4)+4] <= lru[(address[31:28]<<4)+4] + 1;
                    lru[(address[31:28]<<4)+5] <= lru[(address[31:28]<<4)+5] + 1;
                    lru[(address[31:28]<<4)+6] <= lru[(address[31:28]<<4)+6] + 1;
                    lru[(address[31:28]<<4)+7] <= lru[(address[31:28]<<4)+7] + 1;
                    lru[(address[31:28]<<4)+8] <= lru[(address[31:28]<<4)+8] + 1;
                    lru[(address[31:28]<<4)+9] <= lru[(address[31:28]<<4)+9] + 1;
                    lru[(address[31:28]<<4)+10] <= lru[(address[31:28]<<4)+10] + 1;
                    lru[(address[31:28]<<4)+11] <= lru[(address[31:28]<<4)+11] + 1;
                    lru[(address[31:28]<<4)+12] <= lru[(address[31:28]<<4)+12] + 1;
                    lru[(address[31:28]<<4)+13] <= lru[(address[31:28]<<4)+13] + 1;
                    lru[(address[31:28]<<4)+14] <= lru[(address[31:28]<<4)+14] + 1;
                    lru[(address[31:28]<<4)+15] <= lru[(address[31:28]<<4)+15] + 1;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
            
                (cache[(address[31:28]<<4)+2][64:33]): begin
                    if (cache[(address[31:28] <<4)+2][32]) begin
                    lru[address[31:28]<<4] <= lru[address[31:28]<<4] + 1;
                    lru[(address[31:28]<<4)+1] <= lru[(address[31:28]<<4)+1] + 1;
                    lru[(address[31:28]<<4)+2] <= 0;
                    lru[(address[31:28]<<4)+3] <= lru[(address[31:28]<<4)+3] + 1;
                    lru[(address[31:28]<<4)+4] <= lru[(address[31:28]<<4)+4] + 1;
                    lru[(address[31:28]<<4)+5] <= lru[(address[31:28]<<4)+5] + 1;
                    lru[(address[31:28]<<4)+6] <= lru[(address[31:28]<<4)+6] + 1;
                    lru[(address[31:28]<<4)+7] <= lru[(address[31:28]<<4)+7] + 1;
                    lru[(address[31:28]<<4)+8] <= lru[(address[31:28]<<4)+8] + 1;
                    lru[(address[31:28]<<4)+9] <= lru[(address[31:28]<<4)+9] + 1;
                    lru[(address[31:28]<<4)+10] <= lru[(address[31:28]<<4)+10] + 1;
                    lru[(address[31:28]<<4)+11] <= lru[(address[31:28]<<4)+11] + 1;
                    lru[(address[31:28]<<4)+12] <= lru[(address[31:28]<<4)+12] + 1;
                    lru[(address[31:28]<<4)+13] <= lru[(address[31:28]<<4)+13] + 1;
                    lru[(address[31:28]<<4)+14] <= lru[(address[31:28]<<4)+14] + 1;
                    lru[(address[31:28]<<4)+15] <= lru[(address[31:28]<<4)+15] + 1;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
            
                (cache[(address[31:28]<<4)+3][64:33]): begin
                    if (cache[(address[31:28] <<4)+3][32]) begin
                    lru[address[31:28]<<4] <= lru[address[31:28]<<4] + 1;
                    lru[(address[31:28]<<4)+1] <= lru[(address[31:28]<<4)+1] + 1;
                    lru[(address[31:28]<<4)+2] <= lru[(address[31:28]<<4)+2] + 1;
                    lru[(address[31:28]<<4)+3] <= 0;
                    lru[(address[31:28]<<4)+4] <= lru[(address[31:28]<<4)+4] + 1;
                    lru[(address[31:28]<<4)+5] <= lru[(address[31:28]<<4)+5] + 1;
                    lru[(address[31:28]<<4)+6] <= lru[(address[31:28]<<4)+6] + 1;
                    lru[(address[31:28]<<4)+7] <= lru[(address[31:28]<<4)+7] + 1;
                    lru[(address[31:28]<<4)+8] <= lru[(address[31:28]<<4)+8] + 1;
                    lru[(address[31:28]<<4)+9] <= lru[(address[31:28]<<4)+9] + 1;
                    lru[(address[31:28]<<4)+10] <= lru[(address[31:28]<<4)+10] + 1;
                    lru[(address[31:28]<<4)+11] <= lru[(address[31:28]<<4)+11] + 1;
                    lru[(address[31:28]<<4)+12] <= lru[(address[31:28]<<4)+12] + 1;
                    lru[(address[31:28]<<4)+13] <= lru[(address[31:28]<<4)+13] + 1;
                    lru[(address[31:28]<<4)+14] <= lru[(address[31:28]<<4)+14] + 1;
                    lru[(address[31:28]<<4)+15] <= lru[(address[31:28]<<4)+15] + 1;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
            
                (cache[(address[31:28]<<4)+4][64:33]): begin
                    if (cache[(address[31:28] <<4)+4][32]) begin
                    lru[address[31:28]<<4] <= lru[address[31:28]<<4] + 1;
                    lru[(address[31:28]<<4)+1] <= lru[(address[31:28]<<4)+1] + 1;
                    lru[(address[31:28]<<4)+2] <= lru[(address[31:28]<<4)+2] + 1;
                    lru[(address[31:28]<<4)+3] <= lru[(address[31:28]<<4)+3] + 1;
                    lru[(address[31:28]<<4)+4] <= 0;
                    lru[(address[31:28]<<4)+5] <= lru[(address[31:28]<<4)+5] + 1;
                    lru[(address[31:28]<<4)+6] <= lru[(address[31:28]<<4)+6] + 1;
                    lru[(address[31:28]<<4)+7] <= lru[(address[31:28]<<4)+7] + 1;
                    lru[(address[31:28]<<4)+8] <= lru[(address[31:28]<<4)+8] + 1;
                    lru[(address[31:28]<<4)+9] <= lru[(address[31:28]<<4)+9] + 1;
                    lru[(address[31:28]<<4)+10] <= lru[(address[31:28]<<4)+10] + 1;
                    lru[(address[31:28]<<4)+11] <= lru[(address[31:28]<<4)+11] + 1;
                    lru[(address[31:28]<<4)+12] <= lru[(address[31:28]<<4)+12] + 1;
                    lru[(address[31:28]<<4)+13] <= lru[(address[31:28]<<4)+13] + 1;
                    lru[(address[31:28]<<4)+14] <= lru[(address[31:28]<<4)+14] + 1;
                    lru[(address[31:28]<<4)+15] <= lru[(address[31:28]<<4)+15] + 1;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
            
                (cache[(address[31:28]<<4)+5][64:33]): begin
                    if (cache[(address[31:28] <<4)+5][32]) begin
                    lru[address[31:28]<<4] <= lru[address[31:28]<<4] + 1;
                    lru[(address[31:28]<<4)+1] <= lru[(address[31:28]<<4)+1] + 1;
                    lru[(address[31:28]<<4)+2] <= lru[(address[31:28]<<4)+2] + 1;
                    lru[(address[31:28]<<4)+3] <= lru[(address[31:28]<<4)+3] + 1;
                    lru[(address[31:28]<<4)+4] <= lru[(address[31:28]<<4)+4] + 1;
                    lru[(address[31:28]<<4)+5] <= 0;
                    lru[(address[31:28]<<4)+6] <= lru[(address[31:28]<<4)+6] + 1;
                    lru[(address[31:28]<<4)+7] <= lru[(address[31:28]<<4)+7] + 1;
                    lru[(address[31:28]<<4)+8] <= lru[(address[31:28]<<4)+8] + 1;
                    lru[(address[31:28]<<4)+9] <= lru[(address[31:28]<<4)+9] + 1;
                    lru[(address[31:28]<<4)+10] <= lru[(address[31:28]<<4)+10] + 1;
                    lru[(address[31:28]<<4)+11] <= lru[(address[31:28]<<4)+11] + 1;
                    lru[(address[31:28]<<4)+12] <= lru[(address[31:28]<<4)+12] + 1;
                    lru[(address[31:28]<<4)+13] <= lru[(address[31:28]<<4)+13] + 1;
                    lru[(address[31:28]<<4)+14] <= lru[(address[31:28]<<4)+14] + 1;
                    lru[(address[31:28]<<4)+15] <= lru[(address[31:28]<<4)+15] + 1;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+6][64:33]): begin
                    if (cache[(address[31:28] <<4)+6][32]) begin
                    lru[address[31:28]<<4] <= lru[address[31:28]<<4] + 1;
                    lru[(address[31:28]<<4)+1] <= lru[(address[31:28]<<4)+1] + 1;
                    lru[(address[31:28]<<4)+2] <= lru[(address[31:28]<<4)+2] + 1;
                    lru[(address[31:28]<<4)+3] <= lru[(address[31:28]<<4)+3] + 1;
                    lru[(address[31:28]<<4)+4] <= lru[(address[31:28]<<4)+4] + 1;
                    lru[(address[31:28]<<4)+5] <= lru[(address[31:28]<<4)+5] + 1;
                    lru[(address[31:28]<<4)+6] <= 0;
                    lru[(address[31:28]<<4)+7] <= lru[(address[31:28]<<4)+7] + 1;
                    lru[(address[31:28]<<4)+8] <= lru[(address[31:28]<<4)+8] + 1;
                    lru[(address[31:28]<<4)+9] <= lru[(address[31:28]<<4)+9] + 1;
                    lru[(address[31:28]<<4)+10] <= lru[(address[31:28]<<4)+10] + 1;
                    lru[(address[31:28]<<4)+11] <= lru[(address[31:28]<<4)+11] + 1;
                    lru[(address[31:28]<<4)+12] <= lru[(address[31:28]<<4)+12] + 1;
                    lru[(address[31:28]<<4)+13] <= lru[(address[31:28]<<4)+13] + 1;
                    lru[(address[31:28]<<4)+14] <= lru[(address[31:28]<<4)+14] + 1;
                    lru[(address[31:28]<<4)+15] <= lru[(address[31:28]<<4)+15] + 1;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+7][64:33]): begin
                    if (cache[(address[31:28] <<4)+7][32]) begin
                    lru[address[31:28]<<4] <= lru[address[31:28]<<4] + 1;
                    lru[(address[31:28]<<4)+1] <= lru[(address[31:28]<<4)+1] + 1;
                    lru[(address[31:28]<<4)+2] <= lru[(address[31:28]<<4)+2] + 1;
                    lru[(address[31:28]<<4)+3] <= lru[(address[31:28]<<4)+3] + 1;
                    lru[(address[31:28]<<4)+4] <= lru[(address[31:28]<<4)+4] + 1;
                    lru[(address[31:28]<<4)+5] <= lru[(address[31:28]<<4)+5] + 1;
                    lru[(address[31:28]<<4)+6] <= lru[(address[31:28]<<4)+6] + 1;
                    lru[(address[31:28]<<4)+7] <= 0;
                    lru[(address[31:28]<<4)+8] <= lru[(address[31:28]<<4)+8] + 1;
                    lru[(address[31:28]<<4)+9] <= lru[(address[31:28]<<4)+9] + 1;
                    lru[(address[31:28]<<4)+10] <= lru[(address[31:28]<<4)+10] + 1;
                    lru[(address[31:28]<<4)+11] <= lru[(address[31:28]<<4)+11] + 1;
                    lru[(address[31:28]<<4)+12] <= lru[(address[31:28]<<4)+12] + 1;
                    lru[(address[31:28]<<4)+13] <= lru[(address[31:28]<<4)+13] + 1;
                    lru[(address[31:28]<<4)+14] <= lru[(address[31:28]<<4)+14] + 1;
                    lru[(address[31:28]<<4)+15] <= lru[(address[31:28]<<4)+15] + 1;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+8][64:33]): begin
                    if (cache[(address[31:28] <<4)+8][32]) begin
                    lru[address[31:28]<<4] <= lru[address[31:28]<<4] + 1;
                    lru[(address[31:28]<<4)+1] <= lru[(address[31:28]<<4)+1] + 1;
                    lru[(address[31:28]<<4)+2] <= lru[(address[31:28]<<4)+2] + 1;
                    lru[(address[31:28]<<4)+3] <= lru[(address[31:28]<<4)+3] + 1;
                    lru[(address[31:28]<<4)+4] <= lru[(address[31:28]<<4)+4] + 1;
                    lru[(address[31:28]<<4)+5] <= lru[(address[31:28]<<4)+5] + 1;
                    lru[(address[31:28]<<4)+6] <= lru[(address[31:28]<<4)+6] + 1;
                    lru[(address[31:28]<<4)+7] <= lru[(address[31:28]<<4)+7] + 1;
                    lru[(address[31:28]<<4)+8] <= 0;
                    lru[(address[31:28]<<4)+9] <= lru[(address[31:28]<<4)+9] + 1;
                    lru[(address[31:28]<<4)+10] <= lru[(address[31:28]<<4)+10] + 1;
                    lru[(address[31:28]<<4)+11] <= lru[(address[31:28]<<4)+11] + 1;
                    lru[(address[31:28]<<4)+12] <= lru[(address[31:28]<<4)+12] + 1;
                    lru[(address[31:28]<<4)+13] <= lru[(address[31:28]<<4)+13] + 1;
                    lru[(address[31:28]<<4)+14] <= lru[(address[31:28]<<4)+14] + 1;
                    lru[(address[31:28]<<4)+15] <= lru[(address[31:28]<<4)+15] + 1;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+9][64:33]): begin
                    if (cache[(address[31:28] <<4)+9][32]) begin
                    lru[address[31:28]<<4] <= lru[address[31:28]<<4] + 1;
                    lru[(address[31:28]<<4)+1] <= lru[(address[31:28]<<4)+1] + 1;
                    lru[(address[31:28]<<4)+2] <= lru[(address[31:28]<<4)+2] + 1;
                    lru[(address[31:28]<<4)+3] <= lru[(address[31:28]<<4)+3] + 1;
                    lru[(address[31:28]<<4)+4] <= lru[(address[31:28]<<4)+4] + 1;
                    lru[(address[31:28]<<4)+5] <= lru[(address[31:28]<<4)+5] + 1;
                    lru[(address[31:28]<<4)+6] <= lru[(address[31:28]<<4)+6] + 1;
                    lru[(address[31:28]<<4)+7] <= lru[(address[31:28]<<4)+7] + 1;
                    lru[(address[31:28]<<4)+8] <= lru[(address[31:28]<<4)+8] + 1;
                    lru[(address[31:28]<<4)+9] <= 0;
                    lru[(address[31:28]<<4)+10] <= lru[(address[31:28]<<4)+10] + 1;
                    lru[(address[31:28]<<4)+11] <= lru[(address[31:28]<<4)+11] + 1;
                    lru[(address[31:28]<<4)+12] <= lru[(address[31:28]<<4)+12] + 1;
                    lru[(address[31:28]<<4)+13] <= lru[(address[31:28]<<4)+13] + 1;
                    lru[(address[31:28]<<4)+14] <= lru[(address[31:28]<<4)+14] + 1;
                    lru[(address[31:28]<<4)+15] <= lru[(address[31:28]<<4)+15] + 1;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+10][64:33]): begin
                    if (cache[(address[31:28] <<4)+10][32]) begin
                    lru[address[31:28]<<4] <= lru[address[31:28]<<4] + 1;
                    lru[(address[31:28]<<4)+1] <= lru[(address[31:28]<<4)+1] + 1;
                    lru[(address[31:28]<<4)+2] <= lru[(address[31:28]<<4)+2] + 1;
                    lru[(address[31:28]<<4)+3] <= lru[(address[31:28]<<4)+3] + 1;
                    lru[(address[31:28]<<4)+4] <= lru[(address[31:28]<<4)+4] + 1;
                    lru[(address[31:28]<<4)+5] <= lru[(address[31:28]<<4)+5] + 1;
                    lru[(address[31:28]<<4)+6] <= lru[(address[31:28]<<4)+6] + 1;
                    lru[(address[31:28]<<4)+7] <= lru[(address[31:28]<<4)+7] + 1;
                    lru[(address[31:28]<<4)+8] <= lru[(address[31:28]<<4)+8] + 1;
                    lru[(address[31:28]<<4)+9] <= lru[(address[31:28]<<4)+9] + 1;
                    lru[(address[31:28]<<4)+10] <= 0;
                    lru[(address[31:28]<<4)+11] <= lru[(address[31:28]<<4)+11] + 1;
                    lru[(address[31:28]<<4)+12] <= lru[(address[31:28]<<4)+12] + 1;
                    lru[(address[31:28]<<4)+13] <= lru[(address[31:28]<<4)+13] + 1;
                    lru[(address[31:28]<<4)+14] <= lru[(address[31:28]<<4)+14] + 1;
                    lru[(address[31:28]<<4)+15] <= lru[(address[31:28]<<4)+15] + 1;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+11][64:33]): begin
                    if (cache[(address[31:28] <<4)+11][32]) begin
                    lru[address[31:28]<<4] <= lru[address[31:28]<<4] + 1;
                    lru[(address[31:28]<<4)+1] <= lru[(address[31:28]<<4)+1] + 1;
                    lru[(address[31:28]<<4)+2] <= lru[(address[31:28]<<4)+2] + 1;
                    lru[(address[31:28]<<4)+3] <= lru[(address[31:28]<<4)+3] + 1;
                    lru[(address[31:28]<<4)+4] <= lru[(address[31:28]<<4)+4] + 1;
                    lru[(address[31:28]<<4)+5] <= lru[(address[31:28]<<4)+5] + 1;
                    lru[(address[31:28]<<4)+6] <= lru[(address[31:28]<<4)+6] + 1;
                    lru[(address[31:28]<<4)+7] <= lru[(address[31:28]<<4)+7] + 1;
                    lru[(address[31:28]<<4)+8] <= lru[(address[31:28]<<4)+8] + 1;
                    lru[(address[31:28]<<4)+9] <= lru[(address[31:28]<<4)+9] + 1;
                    lru[(address[31:28]<<4)+10] <= lru[(address[31:28]<<4)+10] + 1;
                    lru[(address[31:28]<<4)+11] <= 0;
                    lru[(address[31:28]<<4)+12] <= lru[(address[31:28]<<4)+12] + 1;
                    lru[(address[31:28]<<4)+13] <= lru[(address[31:28]<<4)+13] + 1;
                    lru[(address[31:28]<<4)+14] <= lru[(address[31:28]<<4)+14] + 1;
                    lru[(address[31:28]<<4)+15] <= lru[(address[31:28]<<4)+15] + 1;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+12][64:33]): begin
                    if (cache[(address[31:28] <<4)+12][32]) begin
                    lru[address[31:28]<<4] <= lru[address[31:28]<<4] + 1;
                    lru[(address[31:28]<<4)+1] <= lru[(address[31:28]<<4)+1] + 1;
                    lru[(address[31:28]<<4)+2] <= lru[(address[31:28]<<4)+2] + 1;
                    lru[(address[31:28]<<4)+3] <= lru[(address[31:28]<<4)+3] + 1;
                    lru[(address[31:28]<<4)+4] <= lru[(address[31:28]<<4)+4] + 1;
                    lru[(address[31:28]<<4)+5] <= lru[(address[31:28]<<4)+5] + 1;
                    lru[(address[31:28]<<4)+6] <= lru[(address[31:28]<<4)+6] + 1;
                    lru[(address[31:28]<<4)+7] <= lru[(address[31:28]<<4)+7] + 1;
                    lru[(address[31:28]<<4)+8] <= lru[(address[31:28]<<4)+8] + 1;
                    lru[(address[31:28]<<4)+9] <= lru[(address[31:28]<<4)+9] + 1;
                    lru[(address[31:28]<<4)+10] <= lru[(address[31:28]<<4)+10] + 1;
                    lru[(address[31:28]<<4)+11] <= lru[(address[31:28]<<4)+11] + 1;
                    lru[(address[31:28]<<4)+12] <= 0;
                    lru[(address[31:28]<<4)+13] <= lru[(address[31:28]<<4)+13] + 1;
                    lru[(address[31:28]<<4)+14] <= lru[(address[31:28]<<4)+14] + 1;
                    lru[(address[31:28]<<4)+15] <= lru[(address[31:28]<<4)+15] + 1;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+13][64:33]): begin
                    if (cache[(address[31:28] <<4)+13][32]) begin
                    lru[address[31:28]<<4] <= lru[address[31:28]<<4] + 1;
                    lru[(address[31:28]<<4)+1] <= lru[(address[31:28]<<4)+1] + 1;
                    lru[(address[31:28]<<4)+2] <= lru[(address[31:28]<<4)+2] + 1;
                    lru[(address[31:28]<<4)+3] <= lru[(address[31:28]<<4)+3] + 1;
                    lru[(address[31:28]<<4)+4] <= lru[(address[31:28]<<4)+4] + 1;
                    lru[(address[31:28]<<4)+5] <= lru[(address[31:28]<<4)+5] + 1;
                    lru[(address[31:28]<<4)+6] <= lru[(address[31:28]<<4)+6] + 1;
                    lru[(address[31:28]<<4)+7] <= lru[(address[31:28]<<4)+7] + 1;
                    lru[(address[31:28]<<4)+8] <= lru[(address[31:28]<<4)+8] + 1;
                    lru[(address[31:28]<<4)+9] <= lru[(address[31:28]<<4)+9] + 1;
                    lru[(address[31:28]<<4)+10] <= lru[(address[31:28]<<4)+10] + 1;
                    lru[(address[31:28]<<4)+11] <= lru[(address[31:28]<<4)+11] + 1;
                    lru[(address[31:28]<<4)+12] <= lru[(address[31:28]<<4)+12] + 1;
                    lru[(address[31:28]<<4)+13] <= 0;
                    lru[(address[31:28]<<4)+14] <= lru[(address[31:28]<<4)+14] + 1;
                    lru[(address[31:28]<<4)+15] <= lru[(address[31:28]<<4)+15] + 1;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+14][64:33]): begin
                    if (cache[(address[31:28] <<4)+14][32]) begin
                    lru[address[31:28]<<4] <= lru[address[31:28]<<4] + 1;
                    lru[(address[31:28]<<4)+1] <= lru[(address[31:28]<<4)+1] + 1;
                    lru[(address[31:28]<<4)+2] <= lru[(address[31:28]<<4)+2] + 1;
                    lru[(address[31:28]<<4)+3] <= lru[(address[31:28]<<4)+3] + 1;
                    lru[(address[31:28]<<4)+4] <= lru[(address[31:28]<<4)+4] + 1;
                    lru[(address[31:28]<<4)+5] <= lru[(address[31:28]<<4)+5] + 1;
                    lru[(address[31:28]<<4)+6] <= lru[(address[31:28]<<4)+6] + 1;
                    lru[(address[31:28]<<4)+7] <= lru[(address[31:28]<<4)+7] + 1;
                    lru[(address[31:28]<<4)+8] <= lru[(address[31:28]<<4)+8] + 1;
                    lru[(address[31:28]<<4)+9] <= lru[(address[31:28]<<4)+9] + 1;
                    lru[(address[31:28]<<4)+10] <= lru[(address[31:28]<<4)+10] + 1;
                    lru[(address[31:28]<<4)+11] <= lru[(address[31:28]<<4)+11] + 1;
                    lru[(address[31:28]<<4)+12] <= lru[(address[31:28]<<4)+12] + 1;
                    lru[(address[31:28]<<4)+13] <= lru[(address[31:28]<<4)+13] + 1;
                    lru[(address[31:28]<<4)+14] <= 0;
                    lru[(address[31:28]<<4)+15] <= lru[(address[31:28]<<4)+15] + 1;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+15][64:33]): begin
                    if (cache[(address[31:28] <<4)+15][32]) begin
                        lru[address[31:28]<<4] <= lru[address[31:28]<<4] + 1;
                        lru[(address[31:28]<<4)+1] <= lru[(address[31:28]<<4)+1] + 1;
                        lru[(address[31:28]<<4)+2] <= lru[(address[31:28]<<4)+2] + 1;
                        lru[(address[31:28]<<4)+3] <= lru[(address[31:28]<<4)+3] + 1;
                        lru[(address[31:28]<<4)+4] <= lru[(address[31:28]<<4)+4] + 1;
                        lru[(address[31:28]<<4)+5] <= lru[(address[31:28]<<4)+5] + 1;
                        lru[(address[31:28]<<4)+6] <= lru[(address[31:28]<<4)+6] + 1;
                        lru[(address[31:28]<<4)+7] <= lru[(address[31:28]<<4)+7] + 1;
                        lru[(address[31:28]<<4)+8] <= lru[(address[31:28]<<4)+8] + 1;
                        lru[(address[31:28]<<4)+9] <= lru[(address[31:28]<<4)+9] + 1;
                        lru[(address[31:28]<<4)+10] <= lru[(address[31:28]<<4)+10] + 1;
                        lru[(address[31:28]<<4)+11] <= lru[(address[31:28]<<4)+11] + 1;
                        lru[(address[31:28]<<4)+12] <= lru[(address[31:28]<<4)+12] + 1;
                        lru[(address[31:28]<<4)+13] <= lru[(address[31:28]<<4)+13] + 1;
                        lru[(address[31:28]<<4)+14] <= lru[(address[31:28]<<4)+14] + 1;
                        lru[(address[31:28]<<4)+15] <= 0;
                        hit_counter <= hit_counter + 1;
                        done <= 1;
                        state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                default: begin
                    state <= miss;
                    miss_counter <= miss_counter + 1;
                end
                
            endcase
        end
        
        miss: begin
            
        end
        
    endcase
end
endmodule







