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
input wire [23:0]address,
input wire mem_read,
output reg [31:0]miss_counter,
output reg [31:0]hit_counter,
output reg done,
input wire clk
    );
//We want to implement a caching system with:
// N=16 (Number of Sets) [log_2(N) = number of bits for index]
// K=16 (Lines per Set) [Shares an index]
// First 20 bits will be the tag
// Next bit will be valid flag
// Last 32 bits will be the data.
reg [32:0] data;
reg [52:0]cache[255:0];
reg [3:0]state;
reg [63:0]lru[255:0]; //counter to track LRU
wire [3:0]INDEX;
parameter idle = 4'b0000;
parameter read = 4'b0001;
parameter miss = 4'b0010;
parameter reset = 4'b1111;
parameter inter = 4'b0011;
wire [63:0]max_value;
max max_module(
.a(lru[(INDEX<<4)+0]),
.b(lru[(INDEX<<4)+1]),
.c(lru[(INDEX<<4)+2]),
.d(lru[(INDEX<<4)+3]),
.e(lru[(INDEX<<4)+4]),
.f(lru[(INDEX<<4)+5]),
.g(lru[(INDEX<<4)+6]),
.h(lru[(INDEX<<4)+7]),
.i(lru[(INDEX<<4)+8]),
.j(lru[(INDEX<<4)+9]),
.k(lru[(INDEX<<4)+10]),
.l(lru[(INDEX<<4)+11]),
.m(lru[(INDEX<<4)+12]),
.n(lru[(INDEX<<4)+13]),
.o(lru[(INDEX<<4)+14]),
.p(lru[(INDEX<<4)+15]),
.max_value(max_value)
);

assign INDEX = address[23:20];
always @(posedge (clk)) begin
    case(state)
        reset: begin
            miss_counter <= 0;
            hit_counter <= 0;
            //for (integer i=0; i<256; i=i+1) begin
            //    lru[i] <= 0;
            //end
            data <= 0;
            done <= 1;
            state <= idle;
        end
        
        idle: begin
            if (mem_read) begin
                done <= 0;
                lru[(INDEX<<4)+0] <= lru[(INDEX<<4)+0] + 1;
                lru[(INDEX<<4)+1] <= lru[(INDEX<<4)+1] + 1;
                lru[(INDEX<<4)+2] <= lru[(INDEX<<4)+2] + 1;
                lru[(INDEX<<4)+3] <= lru[(INDEX<<4)+3] + 1;
                lru[(INDEX<<4)+4] <= lru[(INDEX<<4)+4] + 1;
                lru[(INDEX<<4)+5] <= lru[(INDEX<<4)+5] + 1;
                lru[(INDEX<<4)+6] <= lru[(INDEX<<4)+6] + 1;
                lru[(INDEX<<4)+7] <= lru[(INDEX<<4)+7] + 1;
                lru[(INDEX<<4)+8] <= lru[(INDEX<<4)+8] + 1;
                lru[(INDEX<<4)+9] <= lru[(INDEX<<4)+9] + 1;
                lru[(INDEX<<4)+10] <= lru[(INDEX<<4)+10] + 1;
                lru[(INDEX<<4)+11] <= lru[(INDEX<<4)+11] + 1;
                lru[(INDEX<<4)+12] <= lru[(INDEX<<4)+12] + 1;
                lru[(INDEX<<4)+13] <= lru[(INDEX<<4)+13] + 1;
                lru[(INDEX<<4)+14] <= lru[(INDEX<<4)+14] + 1;
                lru[(INDEX<<4)+15] <= lru[(INDEX<<4)+15] + 1;
                state <= inter;
            end
            else begin
                done <= 1;
            end
        end
        
        inter: begin
            state <= read;
        end
        
        read: begin
            case(address[19:0])
            
                (cache[(INDEX<<4)+0][52:33]): begin
                    if (cache[(INDEX <<4)][32]) begin //Check valid bit
                        lru[INDEX<<4+0] <= 0;
                        hit_counter <= hit_counter + 1;
                        done <= 1;
                        state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
            
                (cache[(INDEX<<4)+1][52:33]): begin
                    if (cache[(INDEX <<4)+1][32]) begin
                        lru[(INDEX<<4)+1] <= 0;
                        hit_counter <= hit_counter + 1;
                        done <= 1;
                        state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
            
                (cache[(INDEX<<4)+2][52:33]): begin
                    if (cache[(INDEX <<4)+2][32]) begin
                        lru[(INDEX<<4)+2] <= 0;
                        hit_counter <= hit_counter + 1;
                        done <= 1;
                        state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
            
                (cache[(INDEX<<4)+3][52:33]): begin
                    if (cache[(INDEX <<4)+3][32]) begin
                        lru[(INDEX<<4)+3] <= 0;
                        hit_counter <= hit_counter + 1;
                        done <= 1;
                        state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
            
                (cache[(INDEX<<4)+4][52:33]): begin
                    if (cache[(INDEX <<4)+4][32]) begin
                        lru[(INDEX<<4)+4] <= 0;
                        hit_counter <= hit_counter + 1;
                        done <= 1;
                        state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
            
                (cache[(INDEX<<4)+5][52:33]): begin
                    if (cache[(INDEX <<4)+5][32]) begin
                        lru[(INDEX<<4)+5] <= 0;
                        hit_counter <= hit_counter + 1;
                        done <= 1;
                        state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(INDEX<<4)+6][52:33]): begin
                    if (cache[(INDEX <<4)+6][32]) begin
                        lru[(INDEX<<4)+6] <= 0;
                        hit_counter <= hit_counter + 1;
                        done <= 1;
                        state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(INDEX<<4)+7][52:33]): begin
                    if (cache[(INDEX <<4)+7][32]) begin
                        lru[(INDEX<<4)+7] <= 0;
                        hit_counter <= hit_counter + 1;
                        done <= 1;
                        state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(INDEX<<4)+8][52:33]): begin
                    if (cache[(INDEX <<4)+8][32]) begin
                        lru[(INDEX<<4)+8] <= 0;
                        hit_counter <= hit_counter + 1;
                        done <= 1;
                        state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(INDEX<<4)+9][52:33]): begin
                    if (cache[(INDEX <<4)+9][32]) begin
                        lru[(INDEX<<4)+9] <= 0;
                        hit_counter <= hit_counter + 1;
                        done <= 1;
                        state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(INDEX<<4)+10][52:33]): begin
                    if (cache[(INDEX <<4)+10][32]) begin
                        lru[(INDEX<<4)+10] <= 0;
                        hit_counter <= hit_counter + 1;
                        done <= 1;
                        state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(INDEX<<4)+11][52:33]): begin
                    if (cache[(INDEX <<4)+11][32]) begin
                        lru[(INDEX<<4)+11] <= 0;
                        hit_counter <= hit_counter + 1;
                        done <= 1;
                        state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(INDEX<<4)+12][52:33]): begin
                    if (cache[(INDEX <<4)+12][32]) begin
                        lru[(INDEX<<4)+12] <= 0;
                        hit_counter <= hit_counter + 1;
                        done <= 1;
                        state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(INDEX<<4)+13][52:33]): begin
                    if (cache[(INDEX <<4)+13][32]) begin
                        lru[(INDEX<<4)+13] <= 0;
                        hit_counter <= hit_counter + 1;
                        done <= 1;
                        state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(INDEX<<4)+14][52:33]): begin
                    if (cache[(INDEX <<4)+14][32]) begin
                        lru[(INDEX<<4)+14] <= 0;
                        hit_counter <= hit_counter + 1;
                        done <= 1;
                        state <= idle;
                    end
                    else begin
                        state <= miss;
                    end
                end
                
                (cache[(INDEX<<4)+15][52:33]): begin
                    if (cache[(INDEX <<4)+15][32]) begin
                        lru[(INDEX<<4)+15] <= 0;
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
            
                lru[INDEX<<4]: begin
                    cache[(INDEX<<4)+0] <= (address[19:0] << 33) | (1'b1 << 32) | data;
                    lru[(INDEX<<4)+0] <= 0; 
                    state <= idle;
                    done <= 1;
                end
            
                lru[(INDEX<<4)+1]: begin
                    cache[(INDEX<<4)+1] <= (address[19:0] << 33) | (1'b1 << 32) | data; 
                    lru[(INDEX<<4)+1] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(INDEX<<4)+2]: begin
                    cache[(INDEX<<4)+2] <= (address[19:0] << 33) | (1'b1 << 32) | data; 
                    lru[(INDEX<<4)+2] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(INDEX<<4)+3]: begin
                    cache[(INDEX<<4)+3] <= (address[19:0] << 33) | (1'b1 << 32) | data; 
                    lru[(INDEX<<4)+3] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(INDEX<<4)+4]: begin
                    cache[(INDEX<<4)+4] <= (address[19:0] << 33) | (1'b1 << 32) | data; 
                    lru[(INDEX<<4)+4] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(INDEX<<4)+5]: begin
                    cache[(INDEX<<4)+5] <= (address[19:0] << 33) | (1'b1 << 32) | data; 
                    lru[(INDEX<<4)+5] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(INDEX<<4)+6]: begin
                    cache[(INDEX<<4)+6] <= (address[19:0] << 33) | (1'b1 << 32) | data; 
                    lru[(INDEX<<4)+6] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(INDEX<<4)+7]: begin
                    cache[(INDEX<<4)+7] <= (address[19:0] << 33) | (1'b1 << 32) | data; 
                    lru[(INDEX<<4)+7] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(INDEX<<4)+8]: begin
                    cache[(INDEX<<4)+8] <= (address[19:0] << 33) | (1'b1 << 32) | data; 
                    lru[(INDEX<<4)+8] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(INDEX<<4)+9]: begin
                    cache[(INDEX<<4)+9] <= (address[19:0] << 33) | (1'b1 << 32) | data; 
                    lru[(INDEX<<4)+9] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(INDEX<<4)+10]: begin
                    cache[(INDEX<<4)+10] <= (address[19:0] << 33) | (1'b1 << 32) | data; 
                    lru[(INDEX<<4)+10] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(INDEX<<4)+11]: begin
                    cache[(INDEX<<4)+11] <= (address[19:0] << 33) | (1'b1 << 32) | data; 
                    lru[(INDEX<<4)+11] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(INDEX<<4)+12]: begin
                    cache[(INDEX<<4)+12] <= (address[19:0] << 33) | (1'b1 << 32) | data; 
                    lru[(INDEX<<4)+12] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(INDEX<<4)+13]: begin
                    cache[(INDEX<<4)+13] <= (address[19:0] << 33) | (1'b1 << 32) | data; 
                    lru[(INDEX<<4)+13] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(INDEX<<4)+14]: begin
                    cache[(INDEX<<4)+14] <= (address[19:0] << 33) | (1'b1 << 32) | data; 
                    lru[(INDEX<<4)+14] <= 0;
                    state <= idle;
                    done <= 1;
                end
            
                lru[(INDEX<<4)+15]: begin
                    cache[(INDEX<<4)+15] <= (address[19:0] << 33) | (1'b1 << 32) | data; 
                    lru[(INDEX<<4)+15] <= 0;
                    state <= idle;
                    done <= 1;
                end
                
                default: begin //Add value to every single spot in the cache
                    cache[(INDEX<<4)] <= (address[19:0] << 33) | (1'b1 << 32) | data;
                    lru[(INDEX<<4)] <= 0; 
                    cache[(INDEX<<4)+1] <= (address[19:0] << 33) | (1'b1 << 32) | data;
                    lru[(INDEX<<4)+1] <= 0; 
                    cache[(INDEX<<4)+2] <= (address[19:0] << 33) | (1'b1 << 32) | data;
                    lru[(INDEX<<4)+2] <= 0; 
                    cache[(INDEX<<4)+3] <= (address[19:0] << 33) | (1'b1 << 32) | data;
                    lru[(INDEX<<4)+3] <= 0; 
                    cache[(INDEX<<4)+4] <= (address[19:0] << 33) | (1'b1 << 32) | data;
                    lru[(INDEX<<4)+4] <= 0; 
                    cache[(INDEX<<4)+5] <= (address[19:0] << 33) | (1'b1 << 32) | data;
                    lru[(INDEX<<4)+5] <= 0; 
                    cache[(INDEX<<4)+6] <= (address[19:0] << 33) | (1'b1 << 32) | data;
                    lru[(INDEX<<4)+6] <= 0; 
                    cache[(INDEX<<4)+7] <= (address[19:0] << 33) | (1'b1 << 32) | data;
                    lru[(INDEX<<4)+7] <= 0;
                    cache[(INDEX<<4)+8] <= (address[19:0] << 33) | (1'b1 << 32) | data;
                    lru[(INDEX<<4)+8] <= 0; 
                    cache[(INDEX<<4)+9] <= (address[19:0] << 33) | (1'b1 << 32) | data;
                    lru[(INDEX<<4)+9] <= 0;  
                    cache[(INDEX<<4)+10] <= (address[19:0] << 33) | (1'b1 << 32) | data;
                    lru[(INDEX<<4)+10] <= 0; 
                    cache[(INDEX<<4)+11] <= (address[19:0] << 33) | (1'b1 << 32) | data;
                    lru[(INDEX<<4)+11] <= 0; 
                    cache[(INDEX<<4)+12] <= (address[19:0] << 33) | (1'b1 << 32) | data;
                    lru[(INDEX<<4)+12] <= 0;
                    cache[(INDEX<<4)+13] <= (address[19:0] << 33) | (1'b1 << 32) | data;
                    lru[(INDEX<<4)+13] <= 0;
                    cache[(INDEX<<4)+14] <= (address[19:0] << 33) | (1'b1 << 32) | data;
                    lru[(INDEX<<4)+14] <= 0;  
                    cache[(INDEX<<4)+15] <= (address[19:0] << 33) | (1'b1 << 32) | data;
                    lru[(INDEX<<4)+15] <= 0; 
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