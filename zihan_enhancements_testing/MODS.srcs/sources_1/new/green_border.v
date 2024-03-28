`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2024 10:18:54
// Design Name: 
// Module Name: green_border
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


module green_border(
    input clk_6p25MHz, 
    input [7:0] x_coord, 
    input [6:0] y_coord,
    input [2:0] counter_position,
    output reg [15:0] oled_data
);
    
    always @(posedge clk_6p25MHz) begin    
        // Leftmost square has green border
        if (counter_position==0) begin       
            if ((x_coord > 4 && x_coord < 8 && y_coord > 21 && y_coord < 42) ||  // Left line 
                (x_coord > 20 && x_coord < 24 && y_coord > 21 && y_coord < 42) ||  // Right line 
                (x_coord > 7 && x_coord < 21 && y_coord > 38 && y_coord < 42) ||  // Top line 
                (x_coord > 7 && x_coord < 21 && y_coord > 21 && y_coord < 25) // Bottom line
            ) begin
                oled_data <= 16'b00000_111111_00000;  
            end 
            else begin
                oled_data <= 16'b00000_000000_00000;  
            end
        end
    
        // 2nd leftmost square has green border
        else if (counter_position==1) begin               
            if ((x_coord > 21 && x_coord < 25 && y_coord > 21 && y_coord < 42) ||  // Left line 
                (x_coord > 37 && x_coord < 41 && y_coord > 21 && y_coord < 42) ||  // Right line 
                (x_coord > 24 && x_coord < 38 && y_coord > 38 && y_coord < 42) ||  // Top line 
                (x_coord > 24 && x_coord < 38 && y_coord > 21 && y_coord < 25) // Bottom line
            ) begin
                oled_data <= 16'b00000_111111_00000;  
            end   
            else begin
                oled_data <= 16'b00000_000000_00000;  
            end            
        end
            
        // Middle square has green border
        else if (counter_position==2) begin
            if ((x_coord > 38 && x_coord < 42 && y_coord > 21 && y_coord < 42) ||  // Left line 
                (x_coord > 54 && x_coord < 58 && y_coord > 21 && y_coord < 42) ||  // Right line 
                (x_coord > 41 && x_coord < 55 && y_coord > 38 && y_coord < 42) ||  // Top line 
                (x_coord > 41 && x_coord < 55 && y_coord > 21 && y_coord < 25) // Bottom line
            ) begin
                oled_data <= 16'b00000_111111_00000;   
            end 
            else begin
                oled_data <= 16'b00000_000000_00000;  
            end            
        end
            
        // 2nd rightmost square has green border
        else if (counter_position==3) begin 
            if ((x_coord > 55 && x_coord < 59 && y_coord > 21 && y_coord < 42) ||  // Left line
                (x_coord > 71 && x_coord < 75 && y_coord > 21 && y_coord < 42) ||  // Right line 
                (x_coord > 58 && x_coord < 72 && y_coord > 38 && y_coord < 42) ||  // Top line
                (x_coord > 58 && x_coord < 72 && y_coord > 21 && y_coord < 25) // Bottom line   
            ) begin
                oled_data <= 16'b00000_111111_00000; 
            end   
            else begin
                oled_data <= 16'b00000_000000_00000;  
            end                      
        end
            
            
        // Leftmost square has green border
        else if (counter_position==4) begin
            if ((x_coord > 72 && x_coord < 76 && y_coord > 21 && y_coord < 42) ||  // Left line 
                (x_coord > 88 && x_coord < 92 && y_coord > 21 && y_coord < 42) ||  // Right line
                (x_coord > 75 && x_coord < 89 && y_coord > 38 && y_coord < 42) || // Top line
                (x_coord > 75 && x_coord < 89 && y_coord > 21 && y_coord < 25) // Bottom line
            ) begin
                oled_data <= 16'b00000_111111_00000;   
            end     
            else begin
                oled_data <= 16'b00000_000000_00000;  
            end                      
        end   
    end     

endmodule
