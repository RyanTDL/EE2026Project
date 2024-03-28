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


module Top_Student (input clk, 
                    btnC, btnU, btnL, btnR, btnD,
                    [15:0] sw,
                    output [7:0] JB, 
                    [15:0] led, 
                    [7:0] seg, 
                    [3:0] an, 
                    inout PS2Clk, PS2Data);
    
    wire fb;
    wire sending_pix;
    wire sample_pix;
    wire [12:0] pixel_index;
    wire [15:0] oled_data_final, oled_data_a, oled_data_b, oled_data_c, oled_data_d;
    
    wire clk25m;
    wire clk12p5m;
    wire clk6p25m;
    wire clk10k;
    wire clk1k;
    wire clk1;
    
    flexible_clock_module CLK_25MHZ(.CLK_100MHZ(clk), .COUNT_M(1), .FLEX_CLK_OUT(clk25m));
    flexible_clock_module CLK_12p5MHZ(.CLK_100MHZ(clk), .COUNT_M(3), .FLEX_CLK_OUT(clk12p5m));
    flexible_clock_module CLK_6p25MHZ(.CLK_100MHZ(clk), .COUNT_M(7), .FLEX_CLK_OUT(clk6p25m));
    flexible_clock_module CLK_10KHZ(.CLK_100MHZ(clk), .COUNT_M(4999), .FLEX_CLK_OUT(clk10k));
    flexible_clock_module CLK_1KHZ(.CLK_100MHZ(clk), .COUNT_M(49999), .FLEX_CLK_OUT(clk1k));
    flexible_clock_module CLK_1HZ(.CLK_100MHZ(clk), .COUNT_M(49999999), .FLEX_CLK_OUT(clk1));
    
    Oled_Display unit_oled(.clk(clk6p25m), 
                           .reset(0), 
                           .frame_begin(fb), 
                           .sending_pixels(sending_pix),
                           .sample_pixel(sample_pix), 
                           .pixel_index(pixel_index), 
                           .pixel_data(oled_data_final), 
                           .cs(JB[0]), 
                           .sdin(JB[1]), 
                           .sclk(JB[3]), 
                           .d_cn(JB[4]), 
                           .resn(JB[5]), 
                           .vccen(JB[6]),
                           .pmoden(JB[7]));
    
    wire [7:0] xpos;
    wire [7:0] ypos;
    assign xpos = 15;
    assign ypos = 15;
    my_test_ballistic TEST_BALLISTIC(.CLK_6p25M(clk6p25m),
                                     .CLK_1K(clk1k),
                                     .BTNC(btnC),
                                     .BTNU(btnU),
                                     .BTND(btnD),
                                     .XPOS(xpos),
                                     .YPOS(ypos),
                                     .PIXEL_INDEX(pixel_index), 
                                     .PIXEL_DATA(oled_data_final),
                                     .LD0(led[0]));
    
//    wire [3:0] outer_count_out;
//    wire [3:0] inner_count_out;
//    my_test_nested_loops TEST_NESTED(.clk(clk1),
//                                     .outer_count_out(outer_count_out),
//                                     .inner_count_out(inner_count_out),
//                                     .led(led));
    
//    my_test_direction TEST_DIRECTION(.CLK_6p25M(clk6p25m), 
//                             .BTNU(btnU),
//                             .BTND(btnD),
//                             .PIXEL_INDEX(pixel_index), 
//                             .PIXEL_DATA(oled_data_final));
    
//    my_final_oled FINAL_OLED(.CLK(clk6p25m), 
//                             .PIXEL_INDEX(pixel_index), 
//                             .PIXEL_DATA(oled_data_final));
    
//    wire [11:0] xpos;
//    wire [11:0] ypos;
//    wire [3:0] zpos;
//    wire left;
//    wire middle;
//    wire right;
//    wire new_event;
    
//    MouseCtl unit_mouse(.clk(clk),
//                        .rst(0),
//                        .xpos(xpos),
//                        .ypos(ypos),
//                        .zpos(zpos),
//                        .left(left),
//                        .middle(middle),
//                        .right(right),
//                        .new_event(new_event),
//                        .value(0),
//                        .setx(0),
//                        .sety(0),
//                        .setmax_x(0),
//                        .setmax_y(0),
//                        .ps2_clk(PS2Clk),
//                        .ps2_data(PS2Data));
    
//    assign led [15:13] = {left, middle, right};
    
//    paint unit_paint(.clk_100M(clk),
//                     .clk_25M(clk25m), 
//                     .clk_12p5M(clk12p5m), 
//                     .clk_6p25M(clk6p25m), 
//                     .slow_clk(clk1),
//                     .mouse_l(left), 
//                     .reset(right), 
//                     .enable(1),  
//                     .mouse_x(xpos), 
//                     .mouse_y(ypos),
//                     .pixel_index(pixel_index),
//                     .led(led),
//                     .seg(seg[6:0]), 
//                     .colour_chooser(oled_data));
    
//    assign an = 4'b1000;
    
//    wire [3:0] state_top;       // 0: None,  1: Task A,  2: Task B,  3: Task C,  4: Task D
    
//    assign state_top = (sw[4] ? 4 : 
//                       (sw[3] ? 3 : 
//                       (sw[2] ? 2 : 
//                       (sw[1] ? 1 : 0))));
    
//    assign led[3:0] = (sw[4] ? 4'b1000 : 
//                      (sw[3] ? 4'b0100 : 
//                      (sw[2] ? 4'b0010 : 
//                      (sw[1] ? 4'b0001 : 0))));
    
//    assign oled_data_final = (sw[4] ? oled_data_d : 
//                             (sw[3] ? oled_data_c : 
//                             (sw[2] ? oled_data_b : 
//                             (sw[1] ? oled_data_a : 0))));

endmodule
