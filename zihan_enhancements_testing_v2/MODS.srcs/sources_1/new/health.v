`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2024 19:55:07
// Design Name: 
// Module Name: health
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


module health(input clk, input [2:0] health, input player, output reg end_game = 0,
              input [12:0] PIXEL_INDEX, input [15:0] PIXEL_DATA_IN, output reg [15:0] PIXEL_DATA_OUT);
    
    wire [7:0] x_coord = PIXEL_INDEX % 96;
    wire [7:0] y_coord = PIXEL_INDEX / 96;
    
    wire [7:0] x1, x2, x3;
    wire [15:0] oled_data_1, oled_data_2, oled_data_3;
    wire state1, state2, state3;
    assign x1 = (player == 0) ? (health > 0 ? 3 : 255): (health > 0 ? 92 : 255);
    assign x2 = (player == 0) ? (health > 1 ? 9 : 255) : (health > 1 ? 86 : 255);
    assign x3 = (player == 0) ? (health > 2 ? 15 : 255) : (health > 2 ? 80 : 255);
    
    
    draw_heart heart1 (.clk(clk), .pixel_index_input(PIXEL_INDEX), .pixel_data_input(PIXEL_DATA_IN),
                   .heart_x(x1), .heart_y(3), .pixel_data_out(oled_data_1), .state(state1));
                   
    draw_heart heart2 (.clk(clk), .pixel_index_input(PIXEL_INDEX), .pixel_data_input(oled_data_1),
                   .heart_x(x2), .heart_y(3), .pixel_data_out(oled_data_2), .state(state2));
                                      
    draw_heart heart3 (.clk(clk), .pixel_index_input(PIXEL_INDEX), .pixel_data_input(oled_data_2),
                   .heart_x(x3), .heart_y(3), .pixel_data_out(oled_data_3), .state(state3));
    
    always @ (posedge clk) begin       
        PIXEL_DATA_OUT <= oled_data_3;
    end

endmodule
