`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2023 17:55:55
// Design Name: 
// Module Name: indicator_control
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


module indicator_control(
    input [7:0]AN_MASK, [31:0]NUMBER, 
    input RESET, clk, clk_enable,
    output reg [7:0]AN, reg [6:0]SEG
    );
wire[3:0] counter_out;
wire[3:0] muxer_out;
wire [3:0] NUMBER_SPLITTER [0:7];
initial
begin
AN = 8'b11111111;
SEG = 8'b11111111;
end

always@(posedge clk)
begin
if(RESET == 1)
    AN <= 8'b11111111;
else
    case (counter_out)
        4'd0: AN <= 8'b11111110 | AN_MASK;
        4'd1: AN <= 8'b11111101 | AN_MASK;
        4'd2: AN <= 8'b11111011 | AN_MASK;
        4'd3: AN <= 8'b11110111 | AN_MASK;
        4'd4: AN <= 8'b11101111 | AN_MASK;
        4'd5: AN <= 8'b11011111 | AN_MASK;
        4'd6: AN <= 8'b10111111 | AN_MASK;
        4'd7: AN <= 8'b01111111 | AN_MASK;
        default: AN <= 8'b11111111 | AN_MASK;
    endcase
end


always@(posedge clk)
begin
case (muxer_out)
    4'h0: SEG <= 8'b11000000;
    4'h1: SEG <= 8'b11111001;
    4'h2: SEG <= 8'b10100100;
    4'h3: SEG <= 8'b10110000;
    4'h4: SEG <= 8'b10011001;
    4'h5: SEG <= 8'b10010010;
    4'h6: SEG <= 8'b10000010;
    4'h7: SEG <= 8'b11111000;
    4'h8: SEG <= 8'b10000000;
    4'h9: SEG <= 8'b10010000;
    4'ha: SEG <= 8'b10001000;
    4'hb: SEG <= 8'b10000011;
    4'hc: SEG <= 8'b11000110;
    4'hd: SEG <= 8'b10100001;
    4'he: SEG <= 8'b10000110;
    4'hf: SEG <= 8'b10001110;
    default: SEG <= 8'b11111111;
endcase   
end

generate
for (genvar i = 0; i < 8; i = i + 1)
    begin
        assign NUMBER_SPLITTER[i] = NUMBER[((i+1)*4-1)-:4];
    end
endgenerate

assign muxer_out = NUMBER_SPLITTER[counter_out];


counter #(.mod(8), .step(1)) cntr (.clk(clk), .plus(1), .minus(0), .q(counter_out), .re(RESET), .ce(1'b1)); 
endmodule
