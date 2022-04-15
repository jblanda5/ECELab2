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


/*
    CURRENT ISSUE:
    It doesn't seem that hits are working properly. Replacement seems to be working 

*/


module cache(
input wire [31:0]address,
input wire mem_read,
output reg [31:0]miss_counter,
output reg [31:0]hit_counter,
output reg done,
input wire clk
    );
//We want to implement a caching system with:
// N=16 (Number of Sets) [log_2(N) = number of bits for index]
// K=16 (Lines per Set) [Shares an index]
// First 28 bits will be the tag
// Next bit will be valid flag
// Last 32 bits will be the data.
reg [32:0] data;
reg [60:0]cache[255:0];
reg [3:0]state;
reg [63:0]lru[255:0]; //counter to track LRU
parameter idle = 4'b0000;
parameter read = 4'b0001;
parameter miss = 4'b0010;
parameter reset = 4'b1111;
wire [15:0]max_value;
max max_module(
.a(lru[(address[31:28]<<4)]),
.b(lru[(address[31:28]<<4)+1]),
.c(lru[(address[31:28]<<4)+2]),
.d(lru[(address[31:28]<<4)+3]),
.e(lru[(address[31:28]<<4)+4]),
.f(lru[(address[31:28]<<4)+5]),
.g(lru[(address[31:28]<<4)+6]),
.h(lru[(address[31:28]<<4)+7]),
.i(lru[(address[31:28]<<4)+8]),
.j(lru[(address[31:28]<<4)+9]),
.k(lru[(address[31:28]<<4)+10]),
.l(lru[(address[31:28]<<4)+11]),
.m(lru[(address[31:28]<<4)+12]),
.n(lru[(address[31:28]<<4)+13]),
.o(lru[(address[31:28]<<4)+14]),
.p(lru[(address[31:28]<<4)+15]),
.max_value(max_value)
);


always @(posedge (clk)) begin
    case(state)
        reset: begin
            miss_counter <= 0;
            hit_counter <= 0;
            for (integer i=0; i<256; i=i+1) begin
                lru[i] <= 0;
            end
            data <= 0;
            done <= 1;
            state <= idle;
        end
        
        idle: begin
            if (mem_read) begin
                done <= 0;
                state <= read;
                    lru[(address[31:28]<<4)] <= lru[(address[31:28]<<4)] + 1;
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
            end
            else begin
                done <= 1;
            end
        end
        
        read: begin
            case(address)
            
                (cache[(address[31:28]<<4)][60:33]): begin
                    if (cache[(address[31:28] <<4)][32]) begin //Check valid bit
                    lru[address[31:28]<<4] <= 0;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
            
                (cache[(address[31:28]<<4)+1][60:33]): begin
                    if (cache[(address[31:28] <<4)+1][32]) begin
                    lru[(address[31:28]<<4)+1] <= 0;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
            
                (cache[(address[31:28]<<4)+2][60:33]): begin
                    if (cache[(address[31:28] <<4)+2][32]) begin
                    lru[(address[31:28]<<4)+2] <= 0;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
            
                (cache[(address[31:28]<<4)+3][60:33]): begin
                    if (cache[(address[31:28] <<4)+3][32]) begin
                    lru[(address[31:28]<<4)+3] <= 0;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
            
                (cache[(address[31:28]<<4)+4][60:33]): begin
                    if (cache[(address[31:28] <<4)+4][32]) begin
                    lru[(address[31:28]<<4)+4] <= 0;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
            
                (cache[(address[31:28]<<4)+5][60:33]): begin
                    if (cache[(address[31:28] <<4)+5][32]) begin
                    lru[(address[31:28]<<4)+5] <= 0;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+6][60:33]): begin
                    if (cache[(address[31:28] <<4)+6][32]) begin
                    lru[(address[31:28]<<4)+6] <= 0;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+7][60:33]): begin
                    if (cache[(address[31:28] <<4)+7][32]) begin
                    lru[(address[31:28]<<4)+7] <= 0;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+8][60:33]): begin
                    if (cache[(address[31:28] <<4)+8][32]) begin
                    lru[(address[31:28]<<4)+8] <= 0;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+9][60:33]): begin
                    if (cache[(address[31:28] <<4)+9][32]) begin
                    lru[(address[31:28]<<4)+9] <= 0;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+10][60:33]): begin
                    if (cache[(address[31:28] <<4)+10][32]) begin
                    lru[(address[31:28]<<4)+10] <= 0;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+11][60:33]): begin
                    if (cache[(address[31:28] <<4)+11][32]) begin
                    lru[(address[31:28]<<4)+11] <= 0;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+12][60:33]): begin
                    if (cache[(address[31:28] <<4)+12][32]) begin
                    lru[(address[31:28]<<4)+12] <= 0;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+13][60:33]): begin
                    if (cache[(address[31:28] <<4)+13][32]) begin
                    lru[(address[31:28]<<4)+13] <= 0;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+14][60:33]): begin
                    if (cache[(address[31:28] <<4)+14][32]) begin
                    lru[(address[31:28]<<4)+14] <= 0;
                    hit_counter <= hit_counter + 1;
                    done <= 1;
                    state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(address[31:28]<<4)+15][60:33]): begin
                    if (cache[(address[31:28] <<4)+15][32]) begin
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
            case (max_value)
            
                lru[address[31:28]<<4]: begin
                    cache[(address[31:28]<<4)] <= (address[27:0] << 32) | (1'b1 << 31) | data;
                    lru[(address[31:28]<<4)] <= 0; 
                    state <= idle;
                    done <= 1;
                end
            
                lru[(address[31:28]<<4)+1]: begin
                    cache[(address[31:28]<<4)+1] <= (address[27:0] << 32) | (1'b1 << 31) | data; 
                    lru[(address[31:28]<<4)+1] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(address[31:28]<<4)+2]: begin
                    cache[(address[31:28]<<4)+2] <= (address[27:0] << 32) | (1'b1 << 31) | data; 
                    lru[(address[31:28]<<4)+2] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(address[31:28]<<4)+3]: begin
                    cache[(address[31:28]<<4)+3] <= (address[27:0] << 32) | (1'b1 << 31) | data; 
                    lru[(address[31:28]<<4)+3] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(address[31:28]<<4)+4]: begin
                    cache[(address[31:28]<<4)+4] <= (address[27:0] << 32) | (1'b1 << 31) | data; 
                    lru[(address[31:28]<<4)+4] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(address[31:28]<<4)+5]: begin
                    cache[(address[31:28]<<4)+5] <= (address[27:0] << 32) | (1'b1 << 31) | data; 
                    lru[(address[31:28]<<4)+5] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(address[31:28]<<4)+6]: begin
                    cache[(address[31:28]<<4)+6] <= (address[27:0] << 32) | (1'b1 << 31) | data; 
                    lru[(address[31:28]<<4)+6] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(address[31:28]<<4)+7]: begin
                    cache[(address[31:28]<<4)+7] <= (address[27:0] << 32) | (1'b1 << 31) | data; 
                    lru[(address[31:28]<<4)+7] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(address[31:28]<<4)+8]: begin
                    cache[(address[31:28]<<4)+8] <= (address[27:0] << 32) | (1'b1 << 31) | data; 
                    lru[(address[31:28]<<4)+8] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(address[31:28]<<4)+9]: begin
                    cache[(address[31:28]<<4)+9] <= (address[27:0] << 32) | (1'b1 << 31) | data; 
                    lru[(address[31:28]<<4)+9] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(address[31:28]<<4)+10]: begin
                    cache[(address[31:28]<<4)+10] <= (address[27:0] << 32) | (1'b1 << 31) | data; 
                    lru[(address[31:28]<<4)+10] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(address[31:28]<<4)+11]: begin
                    cache[(address[31:28]<<4)+11] <= (address[27:0] << 32) | (1'b1 << 31) | data; 
                    lru[(address[31:28]<<4)+11] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(address[31:28]<<4)+12]: begin
                    cache[(address[31:28]<<4)+12] <= (address[27:0] << 32) | (1'b1 << 31) | data; 
                    lru[(address[31:28]<<4)+12] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(address[31:28]<<4)+13]: begin
                    cache[(address[31:28]<<4)+13] <= (address[27:0] << 32) | (1'b1 << 31) | data; 
                    lru[(address[31:28]<<4)+13] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(address[31:28]<<4)+14]: begin
                    cache[(address[31:28]<<4)+14] <= (address[27:0] << 32) | (1'b1 << 31) | data; 
                    lru[(address[31:28]<<4)+14] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(address[31:28]<<4)+15]: begin
                    cache[(address[31:28]<<4)+15] <= (address[27:0] << 32) | (1'b1 << 31) | data; 
                    lru[(address[31:28]<<4)+15] <= 0;
                    state <= idle;
                    done <= 1;
                end
                
                default: begin //Add value to every single spot in the cache
                    cache[(address[31:28]<<4)] <= (address[27:0] << 32) | (1'b1 << 31) | data;
                    lru[(address[31:28]<<4)] <= 0; 
                    cache[(address[31:28]<<4)+1] <= (address[27:0] << 32) | (1'b1 << 31) | data;
                    lru[(address[31:28]<<4)+1] <= 0; 
                    cache[(address[31:28]<<4)+2] <= (address[27:0] << 32) | (1'b1 << 31) | data;
                    lru[(address[31:28]<<4)+2] <= 0; 
                    cache[(address[31:28]<<4)+3] <= (address[27:0] << 32) | (1'b1 << 31) | data;
                    lru[(address[31:28]<<4)+3] <= 0; 
                    cache[(address[31:28]<<4)+4] <= (address[27:0] << 32) | (1'b1 << 31) | data;
                    lru[(address[31:28]<<4)+4] <= 0; 
                    cache[(address[31:28]<<4)+5] <= (address[27:0] << 32) | (1'b1 << 31) | data;
                    lru[(address[31:28]<<4)+5] <= 0; 
                    cache[(address[31:28]<<4)+6] <= (address[27:0] << 32) | (1'b1 << 31) | data;
                    lru[(address[31:28]<<4)+6] <= 0; 
                    cache[(address[31:28]<<4)+7] <= (address[27:0] << 32) | (1'b1 << 31) | data;
                    lru[(address[31:28]<<4)+7] <= 0;
                    cache[(address[31:28]<<4)+8] <= (address[27:0] << 32) | (1'b1 << 31) | data;
                    lru[(address[31:28]<<4)+8] <= 0; 
                    cache[(address[31:28]<<4)+9] <= (address[27:0] << 32) | (1'b1 << 31) | data;
                    lru[(address[31:28]<<4)+9] <= 0;  
                    cache[(address[31:28]<<4)+10] <= (address[27:0] << 32) | (1'b1 << 31) | data;
                    lru[(address[31:28]<<4)+10] <= 0; 
                    cache[(address[31:28]<<4)+11] <= (address[27:0] << 32) | (1'b1 << 31) | data;
                    lru[(address[31:28]<<4)+11] <= 0; 
                    cache[(address[31:28]<<4)+12] <= (address[27:0] << 32) | (1'b1 << 31) | data;
                    lru[(address[31:28]<<4)+12] <= 0;
                    cache[(address[31:28]<<4)+13] <= (address[27:0] << 32) | (1'b1 << 31) | data;
                    lru[(address[31:28]<<4)+13] <= 0;
                    cache[(address[31:28]<<4)+14] <= (address[27:0] << 32) | (1'b1 << 31) | data;
                    lru[(address[31:28]<<4)+14] <= 0;  
                    cache[(address[31:28]<<4)+15] <= (address[27:0] << 32) | (1'b1 << 31) | data;
                    lru[(address[31:28]<<4)+15] <= 0; 
                    state <= idle;
                    done <= 1;
                end
            endcase
        end
        
        default: begin
            state <= reset;
        end
        
    endcase
end
endmodule







