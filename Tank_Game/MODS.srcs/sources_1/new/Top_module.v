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


module load_game(
    input CLK_6p25MHz,
    input [12:0] pixel_index,
    input timer_6sec,
    input btnU, btnD, btnC,
    output reg [15:0] oled_data,
    output start_game,
    output battlefield_number
);

    parameter [15:0] initial_oled_data= 16'b00000_000000_00111; // Temporary variable for now
    wire [15:0] oled_data_with_name;
    wire [15:0] oled_data_with_name_and_tank;
    wire [15:0] oled_data_select_mode;

    
    // Used to generate loading screen
    home_screen home_screen (.clk_6p25MHz(CLK_6p25MHz), 
                             .pixel_index(pixel_index), 
                             .previous_oled_data(initial_oled_data), 
                             .oled_data(oled_data_with_name));
                             
    tank_animation tank_animation (.clk_6p25MHz(CLK_6p25MHz), 
                                   .pixel_index(pixel_index), 
                                   .previous_oled_data(oled_data_with_name), 
                                   .oled_data(oled_data_with_name_and_tank));
                                   
    // Used to generate 'Select Mode' screen
    select_mode select_mode (.clk_6p25MHz(CLK_6p25MHz), 
                             .pixel_index(pixel_index), 
                             .oled_data(oled_data_select_mode), 
                             .btnU(btnU), 
                             .btnD(btnD), 
                             .btnC(btnC), 
                             .start_game(start_game),
                             .battlefield_number(battlefield_number));
    
    always @(posedge CLK_6p25MHz) begin
        // Loading screen
        if (timer_6sec==0) begin        
            oled_data <= oled_data_with_name_and_tank;
        // Select mode screen
        end else if (timer_6sec==1) begin
            oled_data <= oled_data_select_mode;
        end
    end
        
endmodule
