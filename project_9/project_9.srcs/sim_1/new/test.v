`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2023 00:12:58
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


module test();
reg clk;
integer int;
integer digit;
reg signal_c;
reg signal_r;
reg [3:0] sw;
reg [7:0] an;
reg [6:0] seg;

//ÍÅÏĞÀÂÈËÜÍÎ ÒÀÊ ÏÎÄÊËŞ×ÀÒÜ


initial
    begin
        clk = 0;
        int = 0;
        digit = 0;
        signal_r = 0;
        signal_c = 0;
    end
    
always #10 clk = ~clk;


always@(posedge clk)
begin
    int <= int + 1;
    if  (int == 1000)
        begin
            sw = $urandom_range(15,0);
            signal_c = 1;
        end
    if (int == 2000)
        begin
            signal_c = 0;
        end
    if (int == 3000)
        begin
            sw = $urandom_range(15,0);
            signal_r = 1;
        end
    if (int == 4000)
        begin
            signal_r = 0;
        end            
end


circuit #(.clk(clk), .in_signal_c(signal_c), .in_signal_r(signal_r), .sw(sw), .an(an), .seg(seg));
endmodule
