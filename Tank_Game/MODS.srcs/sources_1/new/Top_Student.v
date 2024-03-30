`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input clk,
    btnC, btnU, btnL, btnR, btnD,
    [15:0] sw,
    output [7:0] JC, 
    [15:0] led, 
    [6:0] seg, 
    [3:0] an, 
    inout PS2Clk, PS2Data
);

    wire fb;
    wire sending_pix;
    wire sample_pix;
    wire [12:0] pixel_index;
    wire [15:0] oled_data_final, oled_data_loading_screen, oled_data_battlefield;
    
    wire clk25m;
    wire clk12p5m;
    wire clk6p25m;
    wire clk10k;
    wire clk1k;
    wire clk10;
    wire clk1;
    
    flexible_clock_module CLK_25MHZ(.CLK_100MHZ(clk), .COUNT_M(1), .FLEX_CLK_OUT(clk25m));
    flexible_clock_module CLK_12p5MHZ(.CLK_100MHZ(clk), .COUNT_M(3), .FLEX_CLK_OUT(clk12p5m));
    flexible_clock_module CLK_6p25MHZ(.CLK_100MHZ(clk), .COUNT_M(7), .FLEX_CLK_OUT(clk6p25m));
    flexible_clock_module CLK_10KHZ(.CLK_100MHZ(clk), .COUNT_M(4999), .FLEX_CLK_OUT(clk10k));
    flexible_clock_module CLK_10HZ(.CLK_100MHZ(clk), .COUNT_M(4999999), .FLEX_CLK_OUT(clk10));
    flexible_clock_module CLK_1KHZ(.CLK_100MHZ(clk), .COUNT_M(49999), .FLEX_CLK_OUT(clk1k));
    flexible_clock_module CLK_1HZ(.CLK_100MHZ(clk), .COUNT_M(49999999), .FLEX_CLK_OUT(clk1));
    
    
    // Set up OLED display
    Oled_Display unit_oled(.clk(clk6p25m), 
                   .reset(0), 
                   .frame_begin(fb), 
                   .sending_pixels(sending_pix),
                   .sample_pixel(sample_pix), 
                   .pixel_index(pixel_index), 
                   .pixel_data(oled_data_final), 
                   .cs(JC[0]), 
                   .sdin(JC[1]), 
                   .sclk(JC[3]), 
                   .d_cn(JC[4]), 
                   .resn(JC[5]), 
                   .vccen(JC[6]),
                   .pmoden(JC[7]));
   
   /////////////////////////////////////////////////////////// 
   ///////////   Start up the tank game   //////////////////// 
   /////////////////////////////////////////////////////////// 
    wire start_game;
    wire battlefield_number;   
    
    // Set up loading screen
    wire timer_6sec;
    timer_module Timer_6sec(.CLK_1Hz(clk1), .COUNT_M(6), .FLEX_CLK_OUT(timer_6sec));  
                
    load_game load_game(
        .CLK_6p25MHz(clk6p25m), 
        .pixel_index(pixel_index),
        .timer_6sec(timer_6sec), 
        .btnU(btnU),
        .btnD(btnD),
        .btnC(btnC),
        .oled_data(oled_data_loading_screen),
        .start_game(start_game),
        .battlefield_number(battlefield_number)
    );    
    
    // Set up battlefield
    wire [15:0] oled_data_singleplayer_battlefield;
    wire [15:0] oled_data_multiplayer_battlefield;
    battlefield single_player (.clk_6p25MHz(clk6p25m), 
                               .pixel_index(pixel_index), 
                               .btnL(btnL), .btnR(btnR), .btnC(btnC), .btnU(btnU), .btnD(btnD),
                               .oled_data(oled_data_singleplayer_battlefield),
                               .LD0(led[0])); 
                               
    battlefield multi_player (.clk_6p25MHz(clk6p25m), 
                              .pixel_index(pixel_index), 
                              .btnL(btnL), .btnR(btnR), .btnC(btnC), .btnU(btnU), .btnD(btnD), 
                              .oled_data(oled_data_multiplayer_battlefield),
                              .LD0(led[0])); 
                              
    assign oled_data_battlefield = (battlefield_number ? oled_data_multiplayer_battlefield : oled_data_singleplayer_battlefield);
       
    // Displays either loading screen or battlefield screen
    assign oled_data_final = (start_game ? oled_data_battlefield : oled_data_loading_screen);                                     

endmodule