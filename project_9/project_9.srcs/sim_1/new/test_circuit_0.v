`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2023 22:29:04
// Design Name: 
// Module Name: test_circuit_0
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


module test_circuit_0();
reg clk;
integer int;
integer digit;
reg signal_c;
reg signal_r;
reg signal_u;
reg [3:0] sw;
wire [7:0] an;
wire [6:0] seg;

initial
    begin
        clk = 0;
        int = 0;
        digit = 0;
        signal_r = 0;
        signal_u = 0;
        signal_c = 0;
        sw = 4'b0000;
    end
    
always #10 clk = ~clk;


always@(posedge clk)
begin
    //N
    if(digit == 0)
        begin
            signal_c = 1;
        end
    if(digit == 50)
        begin
            signal_c = 0;
        end    
    if(digit == 100)
        begin
            signal_r = 1;
        end
    if(digit == 150)
        begin
            signal_r = 0;
        end
    
    //W
    if(digit == 200)
        begin
            signal_c = 1;
        end
    if(digit == 250)
        begin
            signal_c = 0;
        end    
    if(digit == 300)
        begin
            signal_r = 1;
        end
    if(digit == 350)
        begin
            signal_r = 0;
        end
    
    //reset
    if(digit == 400)
        begin
            signal_u = 1;
        end
    if(digit == 450)
        begin
            signal_u = 0;
        end    
     
    //N
    if(digit == 500)
        begin
            sw = 4'b1100;
            signal_c = 1;
        end
    if(digit == 550)
        begin
            signal_c = 0;
        end    
    if(digit == 600)
        begin
            signal_r = 1;
        end
    if(digit == 650)
        begin
            signal_r = 0;
        end
    
    //reset
    if(digit == 700)
        begin
            signal_u = 1;
        end
    if(digit == 750)
        begin
            signal_u = 0;
        end  
    
    
    //N
    if(digit == 800)
        begin
            sw = 4'b0100;
            signal_c = 1;
        end
    if(digit == 850)
        begin
            signal_c = 0;
        end    
    if(digit == 900)
        begin
            signal_r = 1;
        end
    if(digit == 950)
        begin
            signal_r = 0;
        end
    
    //W
    if(digit == 1000)
        begin
            sw = 4'b1010;
            signal_c = 1;
        end
    if(digit == 1050)
        begin
            signal_c = 0;
        end    
    if(digit == 1100)
        begin
            signal_r = 1;
        end
    if(digit == 1150)
        begin
            signal_r = 0;
        end 
     
       
    //w[0]    
    if(digit == 1200)
        begin
            sw = 4'b0110;
            signal_c = 1;
        end
    if(digit == 1250)
        begin
            signal_c = 0;
        end    
    if(digit == 1300)
        begin
            signal_r = 1;
        end
    if(digit == 1350)
        begin
            signal_r = 0;
        end
   
   //w[1]    
    if(digit == 1400)
        begin
            sw = 4'b0100;
            signal_c = 1;
        end
    if(digit == 1450)
        begin
            signal_c = 0;
        end    
    if(digit == 1500)
        begin
            signal_r = 1;
        end
    if(digit == 1550)
        begin
            signal_r = 0;
        end
        
     //w[2]    
    if(digit == 1600)
        begin
            sw = 4'b0100;
            signal_c = 1;
        end
    if(digit == 1650)
        begin
            signal_c = 0;
        end    
    if(digit == 1700)
        begin
            signal_r = 1;
        end
    if(digit == 1750)
        begin
            signal_r = 0;
        end
        
    //w[3]    
    if(digit == 1800)
        begin
            sw = 4'b0010;
            signal_c = 1;
        end
    if(digit == 1850)
        begin
            signal_c = 0;
        end    
    if(digit == 1900)
        begin
            signal_r = 1;
        end
    if(digit == 1950)
        begin
            signal_r = 0;
        end 
        
    //p[0]    
    if(digit == 2000)
        begin
            sw = 4'b1111;
            signal_c = 1;
        end
    if(digit == 2050)
        begin
            signal_c = 0;
        end    
    if(digit == 2100)
        begin
            signal_r = 1;
        end
    if(digit == 2150)
        begin
            signal_r = 0;
        end
        
    //p[1]    
    if(digit == 2200)
        begin
            sw = 4'b0100;
            signal_c = 1;
        end
    if(digit == 2250)
        begin
            signal_c = 0;
        end    
    if(digit == 2300)
        begin
            signal_r = 1;
        end
    if(digit == 2350)
        begin
            signal_r = 0;
        end
        
    //p[2]    
    if(digit == 2400)
        begin
            sw = 4'b0110;
            signal_c = 1;
        end
    if(digit == 2450)
        begin
            signal_c = 0;
        end    
    if(digit == 2500)
        begin
            signal_r = 1;
        end
    if(digit == 2550)
        begin
            signal_r = 0;
        end
    
    //p[3]    
    if(digit == 2600)
        begin
            sw = 4'b0001;
            signal_c = 1;
        end
    if(digit == 2650)
        begin
            signal_c = 0;
        end    
    if(digit == 2700)
        begin
            signal_r = 1;
        end
    if(digit == 2750)
        begin
            signal_r = 0;
        end          

    digit <= digit + 1;                       
end


circuit c (.clk(clk), .in_signal_c(signal_c), .in_signal_r(signal_r), .in_signal_u(signal_u), .sw(sw), .an(an), .seg(seg));
endmodule
