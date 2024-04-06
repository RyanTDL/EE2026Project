`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2024 14:38:51
// Design Name: 
// Module Name: animated_background
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


module animated_background(
    input clk_6p25MHz,
    [12:0] pixel_index,
    output reg [15:0] oled_data
    );    
    
    // For the OLED display
    wire [7:0] x_coord = pixel_index%96;
    wire [6:0] y_coord = pixel_index/96;
    
    // For the position of the clouds
    reg [7:0] cloud_1 = 17;
    reg [7:0] cloud_2 = 42;
    reg [7:0] cloud_3 = 67;
    reg [7:0] cloud_4 = 92;
    
    reg [31:0] counter = 99999;
    
    always @(posedge clk_6p25MHz) begin
    
        counter = (counter==0) ? 99999 : counter-1;
         
         if (counter==0) begin
            cloud_1 = (cloud_1==0) ? 95 : cloud_1 -1;
            cloud_2 = (cloud_2==0) ? 95 : cloud_2 -1;
            cloud_3 = (cloud_3==0) ? 95 : cloud_3 -1;
            cloud_4 = (cloud_4==0) ? 95 : cloud_4 -1;
         end
        
        // Creates the tank
        if (
            (x_coord>cloud_1-15 && x_coord<cloud_1 && y_coord>33 && y_coord<=58) ||
            (x_coord>cloud_2-15 && x_coord<cloud_2 && y_coord>33 && y_coord<=58) ||
            (x_coord>cloud_3-15 && x_coord<cloud_3 && y_coord>33 && y_coord<=58) ||
            (x_coord>cloud_4-15 && x_coord<cloud_4 && y_coord>33 && y_coord<=58)
        ) begin
            oled_data <= 16'b11111_111111_00000;
        end else begin
            oled_data <= 16'b00000_000000_00000;
        end   
    end

endmodule
