`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2023 22:32:44
// Design Name: 
// Module Name: circuit_2
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


module circuit_2(
    input clk, in_signal_c, in_signal_r, [3:0]sw,
    output wire [7:0] an, wire [6:0]seg
    );
reg clk2;
reg [31:0]NUMBER;
reg [31:0]NUMBER_2;
wire out_signal_c, out_signal_enable_c, out_signal_r, out_signal_enable_r;
reg [7:0] mask;
integer int; 
integer digit;
reg [3:0] N;
reg [3:0] W;
reg [31:0] w;
reg [31:0] p;
wire R_O;
wire [7:0] result;
wire er_reg;
reg R_I;
reg [3:0] state;
reg reset;

initial
begin
    clk2 = 0;
    NUMBER = 32'hee000000;
    NUMBER_2 = 32'h00000000;
    w = 32'h00000000;
    p = 32'h00000000;
    mask = 8'b00111110;
    int = 0;
    digit = 0;
    N = 4'b0000;
    W = 4'b0000;
    R_I = 0;
    state = 4'b0000;
    reset = 0;
end 


always@(posedge clk)
    begin
        /*if (out_signal_enable_r == 1 && out_signal_r == 1 && state == 2)
            begin
                reset = ~reset;
                NUMBER = 32'hee000000;
                w = 32'h00000000;
                p = 32'h00000000;
                mask = 8'b00111110;
                digit = 0;
                N = 4'b0000;
                W = 4'b0000;
                R_I = 0;
                state = 4'b0000;
            end
        */
            
        if (state == 2 && N != 0)
            begin
                mask = (8'b11111111 << N);
                NUMBER[31:28] = result[0];
                NUMBER[27:24] = result[1];
                NUMBER[23:20] = result[2];
                NUMBER[19:16] = result[3];
                NUMBER[15:12] = result[4];
                NUMBER[11:8] = result[5];
                NUMBER[7:4] = result[6];
                NUMBER[3:0] = result[7];
            end         
        if(out_signal_enable_c == 1 && out_signal_c == 1 && state == 0)
            begin
                if (digit == 0)
                    begin
                        N = sw;
                        NUMBER[31:28] = 4'b1110;
                        NUMBER[27:24] = 4'b1110;
                        NUMBER[23:4] = 20'b00000000000000000000;
                        NUMBER[3:0] = sw;
                        state = 1;
                    end
                    
                if (digit == 1)
                    begin
                        W = sw;
                        NUMBER[31:28] = 4'b1011;
                        NUMBER[27:24] = 4'b1011;
                        NUMBER[23:4] = 20'b00000000000000000000;
                        NUMBER[3:0] = sw;
                        state = 1;
                    end
                    
                if (digit > 1 && digit < 2 + N)
                    begin
                        w[4*(N+2-digit)-1] = sw[3];
                        w[4*(N+2-digit)-2] = sw[2];
                        w[4*(N+2-digit)-3] = sw[1];
                        w[4*(N+2-digit)-4] = sw[0];
                        NUMBER[31:28] = digit - 1;
                        NUMBER[27:24] = 4'b1011;
                        NUMBER[23:4] = 20'b00000000000000000000;
                        NUMBER[3:0] = sw;
                        state = 1;
                    end
                    
                if(digit > 1 + N && digit < N + N + 2)
                    begin
                        p[4*(N+N+2-digit)-1] = sw[3];
                        p[4*(N+N+2-digit)-2] = sw[2];
                        p[4*(N+N+2-digit)-3] = sw[1];
                        p[4*(N+N+2-digit)-4] = sw[0];
                        NUMBER[31:28] = digit - 1 - N;
                        NUMBER[27:24] = 4'b1100;
                        NUMBER[23:4] = 20'b00000000000000000000;
                        NUMBER[3:0] = sw;
                        state = 1;
                    end
                if (digit >= N + N + 1)
                    begin
                        R_I = 1;
                    end    
            end
        
        if(out_signal_enable_r == 1 && out_signal_r == 1 && state == 1)
            begin
                digit = digit + 1;
                if (digit == 1)
                    begin
                        NUMBER[31:28] = 4'b1011;
                        NUMBER[27:24] = 4'b1011;
                        NUMBER[23:4] = 20'b00000000000000000000;
                        NUMBER[3:0] = 4'b0000;
                        state = 0;
                    end
                    
                if (digit > 1 && digit < 2 + N)
                    begin
                        NUMBER[31:28] = digit - 1;
                        NUMBER[27:24] = 4'b1011;//b - ���
                        NUMBER[23:4] = 20'b00000000000000000000;
                        NUMBER[3:0] = 4'b0000;
                        state = 0;
                    end
                
                if(digit > 1 + N && digit < N + N + 2)
                    begin 
                        NUMBER[31:28] = digit - 1 - N;
                        NUMBER[27:24] = 4'b1100;//� - cena
                        NUMBER[23:4] = 20'b00000000000000000000;
                        NUMBER[3:0] = 4'b0000;
                        state = 0;
                    end
                
                if(digit > N + N + 1)
                    begin
                        state = 2;
                        R_I = 1;
                    end 
            end
       
         if (state == 2 && N == 0)
            begin
                mask = 8'b11111100;
                NUMBER[31:0] = 32'h000000e1; //��� ������ 1
            end
         
    end

always@(posedge clk)
begin
    int <= int + 1;
    if  (int == 1024)
    begin
        clk2 <= ~clk2;
        int <= 0;
    end
end
    
    
debouncer #(.p(5)) dbc (.clk(clk), .in_signal(in_signal_c), .ce(1'b1), .out_signal(out_signal_c), .out_signal_enable(out_signal_enable_c));
debouncer #(.p(5)) dbr (.clk(clk), .in_signal(in_signal_r), .ce(1'b1), .out_signal(out_signal_r), .out_signal_enable(out_signal_enable_r));
fsm automate(.N(N), .W(W), .w(w), .p(p), .reset(reset), .clk(clk), .R_I(R_I), .out(result), .R_O(R_O), .Error(er_reg));
indicator_control ic (.AN_MASK(mask), .NUMBER(NUMBER), .RESET(0), .clk(clk2), .clk_enable(1'b1), .AN(an), .SEG(seg));
     
endmodule
