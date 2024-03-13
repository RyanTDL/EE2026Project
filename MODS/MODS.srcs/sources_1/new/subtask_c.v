`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2024 10:02:23
// Design Name: 
// Module Name: subtask_c
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


module subtask_c(input clk, btnD, input [3:0] state_top, input [12:0] pindex, output reg [15:0] oled_data);
        
    wire [7:0] x;
    wire [7:0] y;
        
    assign x = pindex % 96;
    assign y = pindex / 96;
    
    reg statusC1 = 0;
    reg [31:0] countC1 = 0;
    reg statusC2 = 0;
    reg statusC3 = 0;
    reg [31:0] delay_1p5 = 0;
    reg [31:0] countC2 = 0;
    reg statusC4 = 0;
    reg [31:0] delay_0p5 = 0;
    reg statusC5 = 0;
    reg statusC6 = 0;
    reg statusC7 = 0; 
    reg statusC8 = 0;
    reg statusC9 = 0;
    reg [31:0] countC3 = 0;
    reg [31:0] countC4 = 0;
    reg [31:0] delay_0p5_2 = 0;
    reg statusC10 = 0;
    
    always @ (posedge clk) begin
        
        if (y >= 2 && (y < 7 + countC1/1_250_000) && x >= 45 && x < 50) begin
            oled_data <= 16'b11111_000000_00000;
        end 
                
        else if ( statusC10 == 1 && ((y >= 7 && y < 32 && x >= 45 && x < 50) || (y >= 32 && y < 37 && x >= 45 && x < 65)) ) begin
            oled_data <= 16'b00000_101010_00000;
        end
            
        else begin
            oled_data <= 16'd0;
        end
                
        if (btnD == 1) begin
            statusC1 <= 1;      
        end    
            
        if (statusC1 == 1) begin 
            countC1 <= (countC1 == 37_500_000) ? 37_500_000 : countC1 + 1;      
        end          
               
        if (countC1 == 0 && statusC1 == 1) begin
            statusC2 <= 1;
        end
       
        if (statusC2 == 1) begin
            delay_1p5 <= (delay_1p5 == 37_500_000) ? 37_500_000 : delay_1p5 + 1;            
            if (delay_1p5 == 37_500_000) begin
                statusC3 <= 1;              
            end
        end
       
        if (statusC3 == 1) begin
            countC2 <= (countC2 == 18_750_000) ? 18_750_000 : countC2 + 1;
            if (y >= 2 + countC1/1_250_000 && (y < 7 + countC1/1_250_000) && 
                x >= 45 && x < 50 + countC2/1_250_000) begin  //btw 45 and 65
                oled_data <= 16'b11111_000000_00000;
            end
        end
       
        if (countC2 == 18_750_000) begin
            statusC4 <= 1;
        end
       
        if (statusC4 == 1) begin
            delay_0p5 <= delay_0p5 + 1;
            if (delay_0p5 == 12_500_000) begin
                statusC5 <= 1;
                delay_0p5 <= 0;              
            end
        end
       
        if (statusC5 == 1) begin
            if (y >= 2 + countC1/1_250_000 && (y < 7 + countC1/1_250_000) && 
                x >= 45 + countC2/1_250_000 && x < 50 + countC2/1_250_000) 
            begin
                oled_data <= 16'b00000_101010_00000;
            end
            if (delay_0p5 == 12_500_000) begin
                statusC6 <= 1;               
            end
        end
       
        if (statusC6 == 1) begin
            countC3 <= (countC3 == 37_500_000) ? 37_500_000 : countC3 + 1;
            if (y >= 2 + countC1/1_250_000 && (y < 7 + countC1/1_250_000) && 
                x >= 45 + 15 - countC3/2_500_000 && x < 50 + 15)
            begin
                oled_data <= 16'b00000_101010_00000;
            end            
        end
       
        if (countC3 == 37_500_000) begin
            statusC7 <= 1;            
        end
       
        if (statusC7 == 1) begin
            countC4 <= (countC4 == 75_000_000) ? 75_000_000 : countC4 + 1;
            if (y >= 2 + 30 - countC4/2_500_000 && (y < 7 + 30) && x >= 45 && x < 50) begin
                oled_data <= 16'b00000_101010_00000;
            end
        end
       
        if (countC4 == 75_000_000) begin
            statusC8 <= 1;
            delay_0p5_2 <= 0;   
        end
       
        if (statusC8 == 1) begin
            delay_0p5_2 <= (delay_0p5_2 == 12_500_000)? 12_500_000 : delay_0p5_2 + 1;
            if (delay_0p5_2 == 12_500_000) begin
                statusC9 <= 1;                           
            end
        end
       
        if (statusC9 == 1) begin                    
            statusC1 <= 0;
            statusC2 <= 0;
            statusC3 <= 0;
            statusC4 <= 0; 
            statusC5 <= 0;
            statusC6 <= 0;
            statusC7 <= 0;
            statusC8 <= 0;
            statusC9 <= 0;            
            statusC10 <= 1;    
            countC1 <= 0;  
            delay_1p5 <= 0;
            countC2 <= 0;
            countC3 <= 0;
            countC4 <= 0;
            delay_0p5 <= 0;
            delay_0p5_2 <= 0;                   
        end
        
        if (state_top != 3) begin
            statusC1 <= 0;
            statusC2 <= 0;
            statusC3 <= 0;
            statusC4 <= 0; 
            statusC5 <= 0;
            statusC6 <= 0;
            statusC7 <= 0;
            statusC8 <= 0;
            statusC9 <= 0;            
            statusC10 <= 0;    
            countC1 <= 0;  
            delay_1p5 <= 0;
            countC2 <= 0;
            countC3 <= 0;
            countC4 <= 0;
            delay_0p5 <= 0;
            delay_0p5_2 <= 0;   
        end        
             
    end
    
endmodule
