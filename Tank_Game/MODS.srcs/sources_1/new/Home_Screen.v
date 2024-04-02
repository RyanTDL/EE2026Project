`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2024 11:26:49
// Design Name: 
// Module Name: Home_Screen
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


module home_screen(
    input clk_6p25MHz,
    [12:0] pixel_index,
    [15:0] previous_oled_data,
    output reg [15:0] oled_data
);    

    // For the OLED display
    wire [7:0] x_coord = pixel_index%96;
    wire [6:0] y_coord = pixel_index/96;
    parameter line_width = 5;
    parameter word_width = 15;
    parameter word_height = 15;
    parameter word_colour = 16'b00000_111111_00000;
    
    always @(posedge clk_6p25MHz) begin
        // Takes in previoud OLED data 
        oled_data <= previous_oled_data;
        
        // Border is from x=9 to x=86, y=10 to y=26
        // Creating the word "TANKI". Thickness of line is set above 
        if ((x_coord>8 && x_coord<8+word_width && y_coord>9 && y_coord<9+line_width) || (x_coord>13 && x_coord<13+line_width && y_coord>12 && y_coord<12+word_height)) begin
            oled_data <= word_colour;
        end else if ((x_coord>24 && x_coord<24+word_width && y_coord>9 && y_coord<9+line_width) || (x_coord>24 && x_coord<24+word_width && y_coord>18 && y_coord<18+line_width)
                     || (x_coord>24 && x_coord<24+line_width && y_coord>9 && y_coord<12+word_height) || (x_coord>24+word_width-line_width && x_coord<24+word_width && y_coord>9 && y_coord<12+word_height)) begin
            oled_data <= word_colour;
        end else if ((x_coord>40 && x_coord<40+line_width && y_coord>9 && y_coord<12+word_height) || (x_coord>40+word_width-line_width && x_coord<40+word_width && y_coord>9 && y_coord<12+word_height)
                     || (x_coord>40+line_width-1 && x_coord<40+word_width-line_width+1 && y_coord<15+(x_coord-44)*(12/6) && y_coord>9+(x_coord-44)*(12/6))) begin
            oled_data <= word_colour;  
        end else if ((x_coord>56 && x_coord<56+line_width && y_coord>9 && y_coord<12+word_height)
                     || (x_coord>56+line_width-1 && x_coord<56+word_width && y_coord<21-(x_coord-60)*(10/10) && y_coord>15-(x_coord-60)*(10/10) && y_coord>9)
                     || (x_coord>56+line_width-1 && x_coord<56+word_width && y_coord>15+(x_coord-60)*(10/10) && y_coord<21+(x_coord-60)*(10/10) && y_coord<12+word_height)) begin
            oled_data <= word_colour;
        end else if ((x_coord>72 && x_coord<72+word_width && y_coord>9 && y_coord<9+line_width) 
                     || (x_coord>72 && x_coord<72+word_width && y_coord>12+word_height-line_width && y_coord<12+word_height) 
                     || (x_coord>77 && x_coord<77+line_width && y_coord>12 && y_coord<12+word_height)) begin
            oled_data <= word_colour;  
        // Creating the grass patch  
        end else if (y_coord>58) begin   
            oled_data <= 16'b00000_111111_00000;                
        end 
    end
    
endmodule
