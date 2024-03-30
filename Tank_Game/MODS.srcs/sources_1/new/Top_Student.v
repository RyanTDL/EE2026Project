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
    wire [15:0] oled_data;
    
    wire clk25m;
    wire clk12p5m;
    wire clk6p25m;
    wire clk10k;
    wire clk10;
    wire clk1;
    
    flexible_clock_module CLK_25MHZ(.CLK_100MHZ(clk), .COUNT_M(1), .FLEX_CLK_OUT(clk25m));
    flexible_clock_module CLK_12p5MHZ(.CLK_100MHZ(clk), .COUNT_M(3), .FLEX_CLK_OUT(clk12p5m));
    flexible_clock_module CLK_6p25MHZ(.CLK_100MHZ(clk), .COUNT_M(7), .FLEX_CLK_OUT(clk6p25m));
    flexible_clock_module CLK_10KHZ(.CLK_100MHZ(clk), .COUNT_M(4999), .FLEX_CLK_OUT(clk10k));
    flexible_clock_module CLK_10HZ(.CLK_100MHZ(clk), .COUNT_M(4999999), .FLEX_CLK_OUT(clk10));
    flexible_clock_module CLK_1HZ(.CLK_100MHZ(clk), .COUNT_M(49999999), .FLEX_CLK_OUT(clk1));
    
    
    wire timer_6sec;
    timer_module Timer_6sec(.CLK_1Hz(clk1), .COUNT_M(6), .FLEX_CLK_OUT(timer_6sec));
    
    
    top_module top_module(
        .CLK_6p25MHz(clk6p25m), 
        .pixel_data(pixel_index),
        .timer_6sec(timer_6sec), 
        .btnU(btnU),
        .btnD(btnD),
        .btnC(btnC),
        .btnL(btnL), 
        .btnR(btnR),
        .oled_data(oled_data)
    );    
    
                
    Oled_Display unit_oled(.clk(clk6p25m), 
                       .reset(0), 
                       .frame_begin(fb), 
                       .sending_pixels(sending_pix),
                       .sample_pixel(sample_pix), 
                       .pixel_index(pixel_index), 
                       .pixel_data(oled_data), 
                       .cs(JC[0]), 
                       .sdin(JC[1]), 
                       .sclk(JC[3]), 
                       .d_cn(JC[4]), 
                       .resn(JC[5]), 
                       .vccen(JC[6]),
                       .pmoden(JC[7]));


endmodule