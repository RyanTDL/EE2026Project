`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2024 12:20:17
// Design Name: 
// Module Name: white_squares
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


module white_squares(
    input clk_6p25MHz, 
    input [7:0] x_coord, 
    input [6:0] y_coord,
    input [31:0] timer_4sec_toggle,
    input [1:0] colour_counter,
    input [15:0] previous_oled_data,
    output reg [15:0] oled_data
);
    
    reg [15:0] assigned_colour; 
    
    always @(posedge clk_6p25MHz) begin
        oled_data <= previous_oled_data;   
        
        // Determining the colour
        if (colour_counter==0) begin
            assigned_colour <= 16'b11111_111111_11111;
        end
        else if (colour_counter==1) begin
            assigned_colour <= 16'b11111_000000_00000;
        end        
        else if (colour_counter==2) begin
            assigned_colour <= 16'b00000_111111_00000;
        end
        else if (colour_counter==3) begin
            assigned_colour <= 16'b00000_000000_11111;
        end        
                
        // Producing the white squares
        if (timer_4sec_toggle==25000000) begin 
            // Creating the 5 white squares
            if ((x_coord > 11 && x_coord <18 && y_coord >28 && y_coord <35) || 
                (x_coord > 28 && x_coord <35 && y_coord >28 && y_coord <35) ||
                (x_coord > 45 && x_coord <52 && y_coord >28 && y_coord <35) ||
                (x_coord > 62 && x_coord <69 && y_coord >28 && y_coord <35) ||
                (x_coord > 79 && x_coord <86 && y_coord >28 && y_coord <35)
            ) begin
                oled_data <= assigned_colour;
            end   
        end  
    end   
    
endmodule
