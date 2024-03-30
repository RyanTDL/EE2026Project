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
    input basys_clock, 
    input [15:0] sw,
    input btnC, btnL, btnR,
    output [7:0] JC
);

    // Variables required for OLED Display
    wire fb; 
    wire sendPixel;
    wire samplePixel;
    wire [15:0] oled_data;
    wire [12:0] pixel_index;
    wire clk_6p25MHz; // Used to toggle for the 6.25MHz clock
    wire clk_1Hz; // Used to toggle for the 1Hz clock
    
    flexible_clock clock_6p25MHZ (basys_clock, 7, clk_6p25MHz);
    flexible_clock clock_1HZ (basys_clock, 49999999, clk_1Hz); 

    Basic_Task_B(
        .clk_6p25MHz(clk_6p25MHz),
        .clk_1Hz(clk_1Hz),
        .sw0(sw[0]),
        .btnC(btnC),
        .btnL(btnL),
        .btnR(btnR),
        .pixel_index(pixel_index),
        .oled_data(oled_data)
    );
    
    Oled_Display(
        .clk(clk_6p25MHz), 
        .reset(0), 
        .frame_begin (fb), 
        .sending_pixels(sendPixel),
        .sample_pixel(samplePixel), 
        .pixel_index(pixel_index), 
        .pixel_data(oled_data), 
        .cs(JC[0]), 
        .sdin(JC[1]), 
        .sclk(JC[3]), 
        .d_cn(JC[4]), 
        .resn(JC[5]), 
        .vccen(JC[6]),
        .pmoden(JC[7])
    );
    
endmodule
