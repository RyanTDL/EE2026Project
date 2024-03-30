`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2024 08:54:27 PM
// Design Name: 
// Module Name: my_test_ballistic
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


module my_test_ballistic(input CLK_6p25M, CLK_1K, 
                         BTNC, BTNU, BTND,
                         [7:0] XPOS, YPOS,
                         [12:0] PIXEL_INDEX, 
                         output reg [15:0] PIXEL_DATA,
                         output reg LD0);
    
    parameter G = 100;
    
    wire [7:0] x_coord = PIXEL_INDEX % 96;
    wire [7:0] y_coord = 63 - PIXEL_INDEX / 96;
    
    reg [2:0] STATE_INT = 0;
    
    reg [7:0] THETA = 32;
    wire [15:0] SIN_THETA;
    wire [15:0] COS_THETA;
    my_test_trig sin_1(.angle_in(THETA), .s_c(0), .trig_out(SIN_THETA));
    my_test_trig cos_1(.angle_in(THETA), .s_c(1), .trig_out(COS_THETA));
    
    reg [15:0] flight_time_ms = 0;     //in 1ms
    reg [31:0] flight_time_squared = 0;
    
    reg [7:0] bullet_xpos = 0;
    reg [7:0] bullet_ypos = 0;
    
    parameter POWER = 120;
    wire [7:0] POWER_X;
    wire [7:0] POWER_Y;
    assign POWER_X = ((POWER * COS_THETA) >> 14);
    assign POWER_Y = ((POWER * SIN_THETA) >> 14);
//    assign POWER_X = 50;
//    assign POWER_Y = POWER;
    
    reg [7:0] debouncecount = 0;   // count up to 199
    reg debounceactive = 0;
    
    parameter BARREL = 10;
    wire [7:0] BARREL_X;
    wire [7:0] BARREL_Y;
    assign BARREL_X = XPOS + ((BARREL * COS_THETA) >> 14);
    assign BARREL_Y = YPOS + ((BARREL * SIN_THETA) >> 14);
    
//    always @ (posedge CLK_1K) begin
        
//        if ((BTNU || BTND) && ~debounceactive) begin
//            debounceactive = 1;
//            debouncecount = 0;
//        end
//        if (debouncecount == 19 && debounceactive) begin
//            debounceactive = 0;
//            debouncecount = 0;
//        end
//        else debouncecount = debouncecount + 1;
        
//        if (BTNU && ~debounceactive && STATE_INT == 0 && THETA < 64)
//            THETA <= THETA + 1;
//        else if (BTND && ~debounceactive && STATE_INT == 0 && THETA > 0)
//            THETA <= THETA - 1;
        
        
//        if (STATE_INT == 0) begin
//            bullet_xpos <= XPOS;
//            bullet_ypos <= YPOS;
//            flight_time_ms <= 0;
//            flight_time_squared <= 0;
//            LD0 <= 0;
//        end
        
        
//        if (STATE_INT == 0 && BTNC) STATE_INT <= 1;
        
//        if (STATE_INT == 1 && !BTNC) STATE_INT <= 2;
        
//        if (STATE_INT == 2) begin
//            flight_time_ms <= flight_time_ms + 1;
//            flight_time_squared <= ((flight_time_ms * flight_time_ms));
//            bullet_ypos <= BARREL_Y + ((POWER_Y * flight_time_ms) >> 10) - ((G * flight_time_squared) >> 20);
//            bullet_xpos <= BARREL_X + ((POWER_X * flight_time_ms) >> 10);
            
//            LD0 <= 1;
            
//            if (bullet_xpos <= 0 || bullet_xpos >= 95 || bullet_ypos <= 0 || bullet_ypos >= 63) STATE_INT <= 0;
//        end
        
//    end
    
    always @ (posedge CLK_6p25M) begin
//        if (STATE_INT == 2 
//            && ((x_coord >= bullet_xpos - 1 && x_coord <= bullet_xpos + 1 && y_coord == bullet_ypos) 
//            || (y_coord >= bullet_ypos - 1 && y_coord <= bullet_ypos + 1 && x_coord == bullet_xpos))
//            ) begin 
//            PIXEL_DATA <= 16'b11111_000000_00000;
//        end else if (x_coord == BARREL_X && y_coord == BARREL_Y)
//            PIXEL_DATA <= 16'hffff;
//        else if (x_coord >= XPOS - 2 && x_coord <= XPOS + 2 && y_coord >= YPOS - 2 && y_coord <= YPOS + 2)
//            PIXEL_DATA <= 16'hffff;
//        else
//            PIXEL_DATA <= 0;
        if (x_coord==10) begin
            PIXEL_DATA <= 16'hffff;
        end else
            PIXEL_DATA <= 0;
    end    
endmodule
