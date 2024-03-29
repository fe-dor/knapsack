`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.11.2022 11:58:00
// Design Name: 
// Module Name: test
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
module test (
    output error_reg
);

reg [5:0] args;
reg clk;
wire res;
reg [0:31] reference_reg, error_reg;

initial
begin
    reference_reg = 31'h114689AD;
    args = 5'b00000;
    clk = 0;
    error_reg = 0;
end

always #10 clk = ~clk;

always@(posedge clk)
begin
    error_reg[args] = res ~^ reference_reg[args];
    args = args + 1;
    if(args > 5'b11111)
         $finish;
end

// sdnf mod_f (.in(args[4:0]), .f(res))?\
assign res = (args[0] & args[1]) | args[2] ^ args[3];
endmodule
