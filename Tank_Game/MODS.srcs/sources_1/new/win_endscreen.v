`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2024 15:58:10
// Design Name: 
// Module Name: win_endscreen
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


module win_endscreen(
    input clk_6p25MHz,
    [12:0] pixel_index, 
    output reg [15:0] oled_data
);    
    
    wire [6:0] x;
    wire [7:0] y;
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
    
    always @ (posedge clk_6p25MHz) begin
        if ((((x - 35)*(x - 35) + (y - 20)*(y - 20)) <= 9) || (((x - 60)*(x - 60) + (y - 20)*(y - 20)) <= 9)) begin
            oled_data <= 16'b0;
        end
        else if ((((x - 35)*(x - 35) + (y - 20)*(y - 20)) <= 64) || (((x - 60)*(x - 60) + (y - 20)*(y - 20)) <= 64)) begin
            oled_data <= 16'b1111111111111111;
        end
        else if ((((x - 47)*(x - 48) + (y - 31)*(y - 32)) <= 400) && y >= 32) begin
            oled_data <= 16'b1111100000000000;
        end
        else if (((x - 47)*(x - 48) + (y - 31)*(y - 32)) <= 729) begin
            oled_data <= 16'b1111101111100000;
        end
        else oled_data <= 0;
    end

endmodule
