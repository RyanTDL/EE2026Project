`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2024 21:26:10
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
    input clk_10khz,
    [12:0] pixel_index,
    output reg [15:0] oled_data
    );    
    
    // For the OLED display
    wire [7:0] x_coord = pixel_index%96;
    wire [6:0] y_coord = pixel_index/96;
    reg [7:0] building1_leftbound = 4;
    reg [7:0] building1_rightbound = 16;
    reg [7:0] building2_leftbound = 20;
    reg [7:0] building2_rightbound = 30;
    reg [7:0] building3_leftbound = 40;
    reg [7:0] building3_rightbound = 52;
    reg [7:0] building4_leftbound = 60;
    reg [7:0] building4_rightbound = 70;
    reg [7:0] building5_leftbound = 78;
    reg [7:0] building5_rightbound = 90;
    reg [31:0] counter = 499999; 
    
    parameter building_colour = 16'b11111_111111_00000;
    
    always @(posedge clk_6p25MHz) begin 
        counter = (counter==0) ? 499999 : counter-1;
        if (counter==0) begin
            building1_leftbound <= (building1_leftbound==0) ? 95 : building1_leftbound-1; 
            building1_rightbound <= (building1_rightbound==0) ? 95 : building1_rightbound-1;
            building2_leftbound <= (building2_leftbound==0) ? 95 : building2_leftbound-1; 
            building2_rightbound <= (building2_rightbound==0) ? 95 : building2_rightbound-1; 
            building3_leftbound <= (building3_leftbound==0) ? 95 : building3_leftbound-1; 
            building3_rightbound <= (building3_rightbound==0) ? 95 : building3_rightbound-1; 
            building4_leftbound <= (building4_leftbound==0) ? 95 : building4_leftbound-1; 
            building4_rightbound <= (building4_rightbound==0) ? 95 : building4_rightbound-1;
            building5_leftbound <= (building5_leftbound==0) ? 95 : building5_leftbound-1; 
            building5_rightbound <= (building5_rightbound==0) ? 95 : building5_rightbound-1;
        end   
                
        // Creates Building 1
        if (x_coord>building1_leftbound && x_coord<building1_rightbound && 
            y_coord>=34 && y_coord<=58 &&
            building1_rightbound>building1_leftbound
        ) begin
            oled_data <= building_colour;
        // Creates Building 2
        end else if (x_coord>building2_leftbound && x_coord<building2_rightbound && 
                     y_coord>=40 && y_coord<=58 &&
                     building2_rightbound>building2_leftbound
        ) begin
            oled_data <= building_colour;
        // Creates Building 3
        end else if (x_coord>building3_leftbound && x_coord<building3_rightbound && 
                     y_coord>=45 && y_coord<=58 &&
                     building3_rightbound>building3_leftbound
        ) begin
            oled_data <= building_colour;
        // Creates Building 4
        end else if (x_coord>building4_leftbound && x_coord<building4_rightbound && 
                     y_coord>=30 && y_coord<=58 &&
                     building4_rightbound>building4_leftbound
        ) begin
            oled_data <= building_colour;
        // Creates Building 5
        end else if (x_coord>building5_leftbound && x_coord<building5_rightbound && 
                     y_coord>=40 && y_coord<=58 &&
                     building5_rightbound>building5_leftbound
        ) begin
            oled_data <= building_colour;
        end else begin
            oled_data <= 16'b00000_000000_00000;
        end
    end

endmodule