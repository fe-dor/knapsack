`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2023 21:10:37
// Design Name: 
// Module Name: circuit
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


module circuit(
    input clk, in_signal_c, in_signal_r, in_signal_u, [3:0]sw,
    output wire [7:0] an, wire [6:0]seg
    );
reg clk2;
integer int;
reg [31:0]NUMBER;
wire out_signal_c, out_signal_enable_c, out_signal_r, out_signal_enable_r, out_signal_u, out_signal_enable_u;
reg [7:0] mask;
integer local_state;
reg [3:0] N;
reg [3:0] W;
reg [31:0] w;
reg [31:0] p;
wire R_O;
wire [7:0] result;
reg R_I;
reg [3:0] state;
reg reset;

wire [4:0] padr;
wire [4:0] wadr;
wire [3:0] pref1;
wire [3:0] pref2;
wire [4:0] conditionN1;
wire [4:0] conditionN2;
wire [3:0] pref3;
wire [3:0] conditionN3;
reg [3:0] dN;

initial
begin
    clk2 = 0;
    int = 0;
    NUMBER = 32'hee000000;
    w = 32'h00000000;
    p = 32'h00000000;
    mask = 8'b00111110;
    local_state = 0;
    N = 4'h0;
    W = 4'h0;
    R_I = 0;
    state = 4'b0000;
    reset = 0;
    dN = 0;
end 

assign conditionN1 = 1 + N;
assign conditionN2 = N + N + 2;
assign conditionN3 = N + N + 1; 
assign wadr = 4*(N+2-local_state) - 1;
assign padr = 4*(N+N+2-local_state) - 1;
assign pref1 = local_state - 1;
assign pref2 = local_state - 1 - N;
assign pref3 = local_state - N;   

always@(posedge clk)
    begin        
        if(state == 0 && out_signal_enable_c && out_signal_c)
        begin
            state <= 1;
            if (local_state == 0)
                begin
                    N <= sw;
                    NUMBER <= {28'hEE00000, sw};
                end
                
            if (local_state == 1)
                begin
                    W <= sw;
                    NUMBER <= {28'hBB00000, sw};
                end
                
            if (local_state > 1 && local_state <= conditionN1)
                begin
                    w[wadr-:4] <= sw;
                    NUMBER <= {pref1, 24'hB00000, sw};
                end
                
            if(local_state > conditionN1 && local_state < conditionN2)
                begin
                    p[padr-:4] <= sw;
                    NUMBER <= {pref2, 24'hC00000, sw};
                end
        end
        
        if(state == 1 && out_signal_enable_r && out_signal_r)
        begin
            local_state <= local_state + 1;
            if (local_state == 0)
                begin
                    if (N > 8)
                        state <= 9; //ошибка 2   
                    else if (N == 0)
                        state <= 8; //ошибка 1 
                    else
                        begin
                            NUMBER <= {32'hBB000000};
                            state <= 0;
                        end    
                end
                
            if (local_state > 0 && local_state < conditionN1)
                begin
                    NUMBER[31:28] <= local_state;
                    NUMBER[27:0] <= 28'hB000000;//b - вес
                    state <= 0;
                end
            
            if(local_state > N && local_state < conditionN3)
                begin 
                    NUMBER <= {pref3, 28'hC000000};
                    state <= 0;
                end
            
            if(local_state == conditionN3)
                begin
                    R_I <= 1;
                    state <= 2;
                end
        end
        
        if (state == 2)
            begin
                if (R_O)
                begin
                    mask <= (8'b11111111 << N);
                    NUMBER[31:28] <= result[0];
                    NUMBER[27:24] <= result[1];
                    NUMBER[23:20] <= result[2];
                    NUMBER[19:16] <= result[3];
                    NUMBER[15:12] <= result[4];
                    NUMBER[11:8] <= result[5];
                    NUMBER[7:4] <= result[6];
                    NUMBER[3:0] <= result[7];
                    state <= 3;
                end
                    R_I <= 0;
            end 
                
        if(out_signal_enable_u == 1 && out_signal_u == 1 && state == 3)
            begin
                NUMBER <= 32'hee000000;
                w <= 32'h00000000;
                p <= 32'h00000000;
                mask <= 8'b00111110;
                local_state <= 0;
                N <= 4'h0;
                W <= 4'h0;
                R_I <= 0;
                state <= 4;
                reset <= 1;
            end
            
        if(state == 4)
            begin
                reset <= 0;
                state <= 4'b0000;
            end
        
        if(state == 8)
            begin
                mask <= 8'b11111100;
                NUMBER <= 8'h000000e1; 
                state <= 3;
            end
        if(state == 9)
            begin
                mask <= 8'b11111100;
                NUMBER <= 8'h000000e2;
                state <= 3;
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
debouncer #(.p(5)) dbu (.clk(clk), .in_signal(in_signal_u), .ce(1'b1), .out_signal(out_signal_u), .out_signal_enable(out_signal_enable_u));
fsm automate(.N(N), .W(W), .w(w), .p(p), .reset(reset), .clk(clk), .R_I(R_I), .out(result), .R_O(R_O));
indicator_control ic (.AN_MASK(mask), .NUMBER(NUMBER), .RESET(0), .clk(clk2), .clk_enable(1'b1), .AN(an), .SEG(seg));
     
endmodule
