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
                         [7:0] P1_XPOS, P1_YPOS,
                         [12:0] PIXEL_INDEX, 
                         [15:0] PIXEL_DATA_INPUT,
                         output reg [15:0] PIXEL_DATA,
                         output reg [15:0] LD);
    
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
    //reg [31:0] flight_time_squared = 0;
    wire [31:0] flight_time_squared;
    assign flight_time_squared = flight_time_ms * flight_time_ms;
    
    reg [7:0] bullet_xpos = 0;
    reg [7:0] bullet_ypos = 0;
    
    
    parameter POWER = 150;
    
    reg [7:0] POWER_INPUT = 30;
    reg POWER_COUNT_UP = 1;
    
//    reg [7:0] POWER_X = 0;
//    reg [7:0] POWER_Y = 0;
    wire [23:0] POWER_X;
    wire [23:0] POWER_Y;
    assign POWER_X = ((POWER_INPUT * COS_THETA) >> 14);
    assign POWER_Y = ((POWER_INPUT * SIN_THETA) >> 14);
//    assign POWER_X = 50;
//    assign POWER_Y = POWER;
    wire [31:0] DIST_X;
    wire [31:0] DIST_Y;
    wire [35:0] GRAVITY_COMP;
    assign DIST_X = ((POWER_X[16:0] * flight_time_ms) >> 10);
    assign DIST_Y = ((POWER_Y[16:0] * flight_time_ms) >> 10);
    assign GRAVITY_COMP = ((G * flight_time_squared) >> 20);
    
    
    reg [7:0] debouncecount = 0;   // count up to 19
    reg debounceactive = 0;
    
    reg [9:0] debouncecount_updown = 0;   // count up to 199
    reg debounceactive_updown = 0;
    
    parameter BARREL = 6;
    wire [7:0] BARREL_X;
    wire [7:0] BARREL_Y;
    assign BARREL_X = P1_XPOS + ((BARREL * COS_THETA) >> 14);
    assign BARREL_Y = P1_YPOS + ((BARREL * SIN_THETA) >> 14);
    
    always @ (posedge CLK_1K) begin
        
        // Debounce up and down
        if ((BTNU || BTND) && ~debounceactive) begin
            debounceactive <= 1;
            debouncecount <= 0;
        end
        if (debouncecount >= 19 && debounceactive) begin
            debounceactive <= 0;
            debouncecount <= 0;
        end
        else debouncecount <= debouncecount + 1;
        
        // Debounce centre
        if (BTNC && ~debounceactive_updown) begin
            debounceactive_updown <= 1;
            debouncecount_updown <= 0;
        end
        if (debouncecount_updown >= 332 && debounceactive_updown) begin
            debounceactive_updown <= 0;
            debouncecount_updown <= 0;
        end
        else debouncecount_updown <= debouncecount_updown + 1;
        
        if (STATE_INT == 0) begin
            bullet_xpos <= P1_XPOS;
            bullet_ypos <= P1_YPOS;
            flight_time_ms <= 0;
            //flight_time_squared <= 0;
            POWER_COUNT_UP <= 1;
            POWER_INPUT <= 30;
            LD <= 0;
        end
        
        if (STATE_INT != 2 && ~debounceactive) begin
            if (BTNU && THETA < 64)
                THETA <= THETA + 1;
            else if (BTND && THETA > 0)
                THETA <= THETA - 1;
        end
        
        if (STATE_INT == 0 && BTNC) STATE_INT <= 1;
        
        if (STATE_INT == 1 && BTNC && ~debounceactive_updown) begin
            if (POWER_COUNT_UP && POWER_INPUT < 150)
                POWER_INPUT <= POWER_INPUT + 30;
            else if (~POWER_COUNT_UP && POWER_INPUT > 30)
                POWER_INPUT <= POWER_INPUT - 30;
            else if (POWER_INPUT >= 150) begin
                POWER_COUNT_UP <= 0;
                POWER_INPUT <= POWER_INPUT - 30;
            end
            else if (POWER_INPUT <= 30) begin
                POWER_COUNT_UP <= 1;
                POWER_INPUT <= POWER_INPUT + 30;
            end
        end
        
        if (STATE_INT == 1 || STATE_INT == 2) begin
            case (POWER_INPUT)
                30 : LD <= 16'b1000_0000_0000_0000;
                60 : LD <= 16'b1100_0000_0000_0000;
                90 : LD <= 16'b1110_0000_0000_0000;
                120 : LD <= 16'b1111_0000_0000_0000;
                150 : LD <= 16'b1111_1000_0000_0000;
            endcase
        end
        
        if (STATE_INT == 1 && !BTNC) STATE_INT <= 2;
        
        if (STATE_INT == 2) begin
//            POWER_X <= ((POWER_INPUT * COS_THETA) >> 14);
//            POWER_Y <= ((POWER_INPUT * SIN_THETA) >> 14);
            
            flight_time_ms <= flight_time_ms + 1;
            //flight_time_squared <= ((flight_time_ms * flight_time_ms));
            bullet_ypos <= BARREL_Y + DIST_Y - GRAVITY_COMP;
            bullet_xpos <= BARREL_X + DIST_X;
            
            //LD[0] <= 1;
            
            //if (bullet_xpos <= 0 || bullet_xpos >= 95 || bullet_ypos <= 0 || bullet_ypos >= 63) STATE_INT <= 0;
            if (bullet_xpos <= 0 || bullet_xpos >= 95 || bullet_ypos <= 5)
                STATE_INT <= 0;
        end
        
    end
    
    always @ (posedge CLK_6p25M) begin
        if (STATE_INT == 2 
            && ((x_coord >= bullet_xpos - 1 && x_coord <= bullet_xpos + 1 && y_coord == bullet_ypos) 
            || (y_coord >= bullet_ypos - 1 && y_coord <= bullet_ypos + 1 && x_coord == bullet_xpos))
            ) begin 
            PIXEL_DATA <= 16'b11111_000000_00000;
        end else if (x_coord == BARREL_X && y_coord == BARREL_Y)
            PIXEL_DATA <= 16'hffff;
        else if (x_coord >= P1_XPOS - 2 && x_coord <= P1_XPOS + 2 && y_coord >= P1_YPOS - 2 && y_coord <= P1_YPOS + 2)
            PIXEL_DATA <= 16'hffff;
        else
            PIXEL_DATA <= PIXEL_DATA_INPUT;
    end    
endmodule
