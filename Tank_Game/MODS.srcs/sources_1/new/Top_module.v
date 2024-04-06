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

//    wire [15:0] oled_data_with_background;
//    wire [15:0] oled_data_with_background_name;
//    wire [15:0] oled_data_with_background_name_tank;
//    wire [15:0] oled_data_select_mode;

    
//    // Used to generate loading screen
//    animated_background animated_background (.clk_6p25MHz(CLK_6p25MHz), 
//                                             .pixel_index(pixel_index), 
//                                             .oled_data(oled_data_with_background));
    
//    home_screen home_screen (.clk_6p25MHz(CLK_6p25MHz), 
//                             .pixel_index(pixel_index), 
//                             .previous_oled_data(oled_data_with_background), 
//                             .oled_data(oled_data_with_background_name));
                             
//    tank_animation tank_animation (.clk_6p25MHz(CLK_6p25MHz), 
//                                   .pixel_index(pixel_index), 
//                                   .previous_oled_data(oled_data_with_background_name), 
//                                   .oled_data(oled_data_with_background_name_tank));
                                   
//    // Used to generate 'Select Mode' screen
//    select_mode select_mode (.clk_6p25MHz(CLK_6p25MHz), 
//                             .pixel_index(pixel_index), 
//                             .oled_data(oled_data_select_mode), 
//                             .btnU(btnU), 
//                             .btnD(btnD), 
//                             .btnC(btnC), 
//                             .start_game(start_game),
//                             .battlefield_number(battlefield_number));
                             
    // Use to generate the ending screen
    wire [15:0] winning_screen;
    wire [15:0] losing_screen;
    
    win_endscreen win_endscreen (.clk_6p25MHz(CLK_6p25MHz), 
                                 .pixel_index(pixel_index), 
                                 .oled_data(winning_screen));
    
    lose_endscreen lose_endscreen (.clk_6p25MHz(CLK_6p25MHz), 
                                  .pixel_index(pixel_index), 
                                  .oled_data(losing_screen));

    always @(posedge CLK_6p25MHz) begin
        // Loading screen
//        if (timer_6sec==0) begin        
//            oled_data <= oled_data_with_background_name_tank;
//        // Select mode screen
//        end else if (timer_6sec==1) begin
//            oled_data <= oled_data_select_mode;
//        end


        //////////////////////////////
        // Temporary, remove later ///
        /////////////////////////////
        oled_data <= losing_screen;
        //////////////////////////////
        //////////////////////////////
    end
        
endmodule
