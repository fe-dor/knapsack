`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2023 19:32:27
// Design Name: 
// Module Name: test_fsm
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


module test_fsm();
reg [3:0] N;
reg [3:0] W;
reg [31:0] w;
reg [31:0] p;
reg clk;

wire [0:7] result;

initial
    begin
        clk = 1'b0;
        N = 4'b0101;
        W = 4'b0111;
        w = 32'h00006132;
        p = 32'h00013245; 
    end


always #10 clk = ~clk;


fsm automate(.N(N), .W(W), .w(w), .p(p), .reset(0), .clk(clk), .R_I(1'b1), .out(result), .R_O(R_O), .Error(er_reg));
endmodule
