`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2023 22:37:23
// Design Name: 
// Module Name: test_circuit_2
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


module test_circuit_2();
reg clk;
integer int;
integer digit;
reg signal_c;
reg signal_r;
reg [3:0] sw;
wire [7:0] an;
wire [6:0] seg;

//Õ≈œ–¿¬»À‹ÕŒ “¿  œŒƒ Àﬁ◊¿“‹


initial
    begin
        clk = 0;
        int = 0;
        digit = 0;
        signal_r = 0;
        signal_c = 0;
        sw = 4'b0000;
    end
    
always #10 clk = ~clk;


always@(posedge clk)
begin
    //N
    if(digit == 0)
        begin
            sw = 4'b0101;
            signal_c = 1;
        end
    if(digit == 50000)
        begin
            signal_c = 0;
        end    
    if(digit == 100000)
        begin
            signal_r = 1;
        end
    if(digit == 150000)
        begin
            signal_r = 0;
        end
    
    //W
    if(digit == 200000)
        begin
            sw = 4'b0111;
            signal_c = 1;
        end
    if(digit == 250000)
        begin
            signal_c = 0;
        end    
    if(digit == 300000)
        begin
            signal_r = 1;
        end
    if(digit == 350000)
        begin
            signal_r = 0;
        end
    
    //w[0]    
    if(digit == 400000)
        begin
            sw = 4'b0000;
            signal_c = 1;
        end
    if(digit == 450000)
        begin
            signal_c = 0;
        end    
    if(digit == 500000)
        begin
            signal_r = 1;
        end
    if(digit == 550000)
        begin
            signal_r = 0;
        end
   
   //w[1]    
    if(digit == 600000)
        begin
            sw = 4'b0110;
            signal_c = 1;
        end
    if(digit == 650000)
        begin
            signal_c = 0;
        end    
    if(digit == 700000)
        begin
            signal_r = 1;
        end
    if(digit == 750000)
        begin
            signal_r = 0;
        end
        
     //w[2]    
    if(digit == 800000)
        begin
            sw = 4'b0001;
            signal_c = 1;
        end
    if(digit == 850000)
        begin
            signal_c = 0;
        end    
    if(digit == 900000)
        begin
            signal_r = 1;
        end
    if(digit == 950000)
        begin
            signal_r = 0;
        end
        
    //w[3]    
    if(digit == 1000000)
        begin
            sw = 4'b0011;
            signal_c = 1;
        end
    if(digit == 1050000)
        begin
            signal_c = 0;
        end    
    if(digit == 1100000)
        begin
            signal_r = 1;
        end
    if(digit == 1150000)
        begin
            signal_r = 0;
        end 
        
    //w[4]    
    if(digit == 1200000)
        begin
            sw = 4'b0010;
            signal_c = 1;
        end
    if(digit == 1250000)
        begin
            signal_c = 0;
        end    
    if(digit == 1300000)
        begin
            signal_r = 1;
        end
    if(digit == 1350000)
        begin
            signal_r = 0;
        end
        
    //p[0]    
    if(digit == 1400000)
        begin
            sw = 4'b0001;
            signal_c = 1;
        end
    if(digit == 1450000)
        begin
            signal_c = 0;
        end    
    if(digit == 1500000)
        begin
            signal_r = 1;
        end
    if(digit == 1550000)
        begin
            signal_r = 0;
        end
        
    //p[1]    
    if(digit == 1600000)
        begin
            sw = 4'b0011;
            signal_c = 1;
        end
    if(digit == 1650000)
        begin
            signal_c = 0;
        end    
    if(digit == 1700000)
        begin
            signal_r = 1;
        end
    if(digit == 1750000)
        begin
            signal_r = 0;
        end
    
    //p[2]    
    if(digit == 1800000)
        begin
            sw = 4'b0010;
            signal_c = 1;
        end
    if(digit == 1850000)
        begin
            signal_c = 0;
        end    
    if(digit == 1900000)
        begin
            signal_r = 1;
        end
    if(digit == 1950000)
        begin
            signal_r = 0;
        end
                  
    //p[3]    
    if(digit == 2000000)
        begin
            sw = 4'b0100;
            signal_c = 1;
        end
    if(digit == 2050000)
        begin
            signal_c = 0;
        end    
    if(digit == 2100000)
        begin
            signal_r = 1;
        end
    if(digit == 2150000)
        begin
            signal_r = 0;
        end  
    
    //p[4]    
    if(digit == 2200000)
        begin
            sw = 4'b0101;
            signal_c = 1;
        end
    if(digit == 2250000)
        begin
            signal_c = 0;
        end    
    if(digit == 2300000)
        begin
            signal_r = 1;
        end
    if(digit == 2350000)
        begin
            signal_r = 0;
        end 
    
    digit <= digit + 1;                       
end


circuit c (.clk(clk), .in_signal_c(signal_c), .in_signal_r(signal_r), .sw(sw), .an(an), .seg(seg));

endmodule
