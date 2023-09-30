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
 

module test_circuit();
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
            sw = 4'b1100;
            signal_c = 1;
        end
    if(digit == 500)
        begin
            signal_c = 0;
        end    
    if(digit == 1000)
        begin
            signal_r = 1;
        end
    if(digit == 1500)
        begin
            signal_r = 0;
        end
    
    //W
    if(digit == 2000)
        begin
            sw = 4'b1010;
            signal_c = 1;
        end
    if(digit == 2500)
        begin
            signal_c = 0;
        end    
    if(digit == 3000)
        begin
            signal_r = 1;
        end
    if(digit == 3500)
        begin
            signal_r = 0;
        end
    
    //w[0]    
    if(digit == 4000)
        begin
            sw = 4'b0110;
            signal_c = 1;
        end
    if(digit == 4500)
        begin
            signal_c = 0;
        end    
    if(digit == 5000)
        begin
            signal_r = 1;
        end
    if(digit == 5500)
        begin
            signal_r = 0;
        end
   
   //w[1]    
    if(digit == 6000)
        begin
            sw = 4'b0100;
            signal_c = 1;
        end
    if(digit == 6500)
        begin
            signal_c = 0;
        end    
    if(digit == 7000)
        begin
            signal_r = 1;
        end
    if(digit == 7500)
        begin
            signal_r = 0;
        end
        
     //w[2]    
    if(digit == 8000)
        begin
            sw = 4'b0100;
            signal_c = 1;
        end
    if(digit == 8500)
        begin
            signal_c = 0;
        end    
    if(digit == 9000)
        begin
            signal_r = 1;
        end
    if(digit == 9500)
        begin
            signal_r = 0;
        end
        
    //w[3]    
    if(digit == 10000)
        begin
            sw = 4'b0010;
            signal_c = 1;
        end
    if(digit == 10500)
        begin
            signal_c = 0;
        end    
    if(digit == 11000)
        begin
            signal_r = 1;
        end
    if(digit == 11500)
        begin
            signal_r = 0;
        end 
        
    //p[0]    
    if(digit == 12000)
        begin
            sw = 4'b1111;
            signal_c = 1;
        end
    if(digit == 12500)
        begin
            signal_c = 0;
        end    
    if(digit == 13000)
        begin
            signal_r = 1;
        end
    if(digit == 13500)
        begin
            signal_r = 0;
        end
        
    //p[1]    
    if(digit == 14000)
        begin
            sw = 4'b0100;
            signal_c = 1;
        end
    if(digit == 14500)
        begin
            signal_c = 0;
        end    
    if(digit == 15000)
        begin
            signal_r = 1;
        end
    if(digit == 15500)
        begin
            signal_r = 0;
        end
        
    //p[2]    
    if(digit == 16000)
        begin
            sw = 4'b0110;
            signal_c = 1;
        end
    if(digit == 16500)
        begin
            signal_c = 0;
        end    
    if(digit == 17000)
        begin
            signal_r = 1;
        end
    if(digit == 17500)
        begin
            signal_r = 0;
        end
    
    //p[3]    
    if(digit == 18000)
        begin
            sw = 4'b0001;
            signal_c = 1;
        end
    if(digit == 18500)
        begin
            signal_c = 0;
        end    
    if(digit == 19000)
        begin
            signal_r = 1;
        end
    if(digit == 19500)
        begin
            signal_r = 0;
        end          
    
    digit <= digit + 1;                       
end


circuit c (.clk(clk), .in_signal_c(signal_c), .in_signal_r(signal_r), .sw(sw), .an(an), .seg(seg));
endmodule

