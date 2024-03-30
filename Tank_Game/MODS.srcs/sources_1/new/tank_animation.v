`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2024 16:51:17
// Design Name: 
// Module Name: tank_animation
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


module tank_animation(
    input clk_6p25MHz,
    [12:0] pixel_index,
    [15:0] previous_oled_data,
    output reg [15:0] oled_data
);    

    // For the OLED display
    wire [7:0] x_coord = pixel_index%96;
    wire [6:0] y_coord = pixel_index/96;
    
    always @(posedge clk_6p25MHz) begin
        // Takes in previoud OLED data 
        oled_data <= previous_oled_data;
        
        // Creates the tank
        if ((x_coord>40 && x_coord<56 && y_coord<59 && y_coord>53) ||
            (x_coord>44 && x_coord<52 && y_coord<54 && y_coord>48) ||
            (x_coord>51 && x_coord<59 && y_coord<52 && y_coord>49)) begin
            oled_data <= 16'b11111_000000_00000;
        // Create smoke cloud
        end else if (
            (x_coord>19 && x_coord<25 && y_coord<56 && y_coord>50) ||
            (x_coord>27 && x_coord<32 && y_coord<57 && y_coord>52) ||
            (x_coord>34 && x_coord<38 && y_coord<58 && y_coord>54) 
        ) begin
            oled_data <= 16'b11111_111111_11111;
        end   
    end
    
endmodule