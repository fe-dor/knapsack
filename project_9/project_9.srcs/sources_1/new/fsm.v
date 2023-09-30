`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2023 21:54:51
// Design Name: 
// Module Name: fsm
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


module fsm(
    input [3:0]N, [3:0]W,[31:0]w, [31:0]p, wire reset, clk, R_I,
    output reg [7:0]out, reg R_O, reg Error
    );
    
reg [6:0] K [0:16][0:16];
    
reg [0:4]c;
reg [0:4]d;

reg [0:7] a;
integer total_weight;
reg [6:0] res;
reg [3:0]g;
reg [3:0]h; 

reg [2:0] state;
reg ready;


initial
begin
c = 5'b00000;
d = 5'b00000;
res = 7'b0000000;
a = 8'b00000000;
g = 0;
h = 0;
total_weight = 0;
R_O = 0;
state = 3'b000;
ready = 0;
end

//Состояние 0
always@(posedge clk)
    begin
        if (state == 0)
            begin
                if(c == 16)
                    begin
                        c <= 0;
                        if(d == 16)
                            begin
                                d <= 0;
                                state <= 1;
                            end
                        else
                            begin
                                d <= d + 1;
                            end    
                    end
                else
                    begin
                        c <= c + 1;
                    end
                K[d][c] <= 7'b0000000;
            end
        
        if(R_I == 1 && state == 1)
            begin
                ready <= 1;
            end
        
        if(state == 1 && ready == 1)
                begin
                    if (c == 0 || d == 0)
                        begin
                            K[d][c] <= 0;      
                        end
                    else 
                        begin
                            if(w[(4*c - 1)-:4] <= d) //d=w, c=i
                                begin
                                    if ( (p[(4*c - 1)-:4] + K[d - w[(4*c - 1)-:4]][c-1]) >= K[d][c-1] )
                                        begin
                                            K[d][c] <= p[(4*c - 1)-:4] + K[d - w[(4*c - 1)-:4]][c-1];
                                        end
                                    else
                                        begin
                                            K[d][c] <= K[d][c-1]; 
                                        end    
                                end
                            else
                                begin
                                    K[d][c] <= K[d][c-1];
                                end    
                        end      
                    if(d >= W)
                        begin
                            d <= 0;
                            if(c >= N)
                                begin
                                    c <= 0;
                                    g <= c;
                                    h <= d;
                                    state <= 2;
                                end
                            else
                                begin
                                    c <= c + 1; //понять что здесь
                                end    
                        end
                    else
                        begin
                            d <= d + 1;
                        end
                end 
        
        if(state == 2)
            begin
                res <= K[W][N];
                state <= 3;
            end
        
        if(state == 3)
                begin
                    if(g == 0 || res == 0)
                        begin
                            state <= 4;                        
                        end  
                    else
                        begin
                            if (res != K[h][g-1] && state == 3)
                                begin
                                    a[g-1] <= 1'b1;
                                    total_weight <= total_weight + w[(4*g - 1)-:4];
                                    res <= res - p[(4*g - 1)-:4];
                                    h <= h - w[(4*g - 1)-:4];
                                end
                            g <= g - 1;
                        end
                end
        
        if (state == 4)
            begin
                out <= a;
                R_O <= 1;
                state <= 5;
            end
            
        if (state == 5)
            begin
                R_O <= 0;
                state <= 6;
            end    
        
        if (state == 6 && reset == 1)
            begin
                c <= 5'b00000;
                d <= 5'b00000;
                res <= 7'b0000000;
                a <= 8'b00000000;
                g <= 0;
                h <= 0;
                total_weight <= 0;
                state <= 3'b000;
                ready <= 0;
            end           
    end
       
endmodule
