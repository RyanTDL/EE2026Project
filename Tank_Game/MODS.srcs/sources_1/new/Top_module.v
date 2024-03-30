`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2024 20:35:21
// Design Name: 
// Module Name: Top_module
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


module top_module(
    input CLK_6p25MHz,
    input [12:0] pixel_data,
    input timer_6sec,
    input btnU, btnD, btnC, btnL, btnR,
    output reg [15:0] oled_data
);

    parameter [15:0] initial_oled_data= 16'b00000_000000_00111; // Temporary variable for now
    wire [15:0] oled_data_with_name;
    wire [15:0] oled_data_with_name_and_tank;
    wire [15:0] oled_data_select_mode;
    wire [15:0] oled_data_singleplayer_battlefield;
    wire [15:0] oled_data_multiplayer_battlefield;
    wire [1:0] start_game;
    
    // Used to generate loading screen
    home_screen home_screen (.clk_6p25MHz(CLK_6p25MHz), .pixel_index(pixel_data), .previous_oled_data(initial_oled_data), .oled_data(oled_data_with_name));
    tank_animation tank_animation (.clk_6p25MHz(CLK_6p25MHz), .pixel_index(pixel_data), .previous_oled_data(oled_data_with_name), .oled_data(oled_data_with_name_and_tank));
    // Used to generate 'Select Mode' screen
    select_mode select_mode (.clk_6p25MHz(CLK_6p25MHz), .pixel_index(pixel_data), .oled_data(oled_data_select_mode), .btnU(btnU), .btnD(btnD), .btnC(btnC), .start_game(start_game));
    // Used to generate 'Battlefield' screen
    battlefield single_player (.clk_6p25MHz(CLK_6p25MHz), .pixel_index(pixel_data), .btnL(btnL), .btnR(btnR), .oled_data(oled_data_singleplayer_battlefield)); 
    battlefield multi_player (.clk_6p25MHz(CLK_6p25MHz), .pixel_index(pixel_data), .btnL(btnL), .btnR(btnR), .oled_data(oled_data_multiplayer_battlefield)); 
    
    always @(posedge CLK_6p25MHz) begin
        // Loading screen
        if (timer_6sec==0) begin        
            oled_data <= oled_data_with_name_and_tank;
        // Select mode screen
        end else if (timer_6sec==1 && start_game==0) begin
            oled_data <= oled_data_select_mode;
        end else if (timer_6sec==1 && start_game==1) begin
            oled_data <= oled_data_singleplayer_battlefield;
        end else if (timer_6sec==1 && start_game==2) begin
            oled_data <= oled_data_multiplayer_battlefield;
        end
    end
        
endmodule
