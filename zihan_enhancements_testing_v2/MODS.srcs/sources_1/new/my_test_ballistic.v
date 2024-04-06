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
                         PLAYER,
                         [7:0] P1_XPOS, P1_YPOS,
                         [7:0] P2_XPOS, P2_YPOS,
                         [12:0] PIXEL_INDEX, 
                         [15:0] PIXEL_DATA_INPUT,
                         output reg [15:0] PIXEL_DATA,
                         output reg [15:0] LD,
                         output reg PLAYER_NEW,
                         output BULLET_FLYING,
                         output [5:0] THETA1_EXT, THETA2_EXT,
                         output [7:0] GRAVITY_EXT,
                         output [2:0] POWER_EXT,
                         output reg [2:0] hit_player = 0);
    
    parameter G = 100;
    
    wire [7:0] x_coord = PIXEL_INDEX % 96;
    wire [7:0] y_coord = 63 - PIXEL_INDEX / 96;
    
    reg [2:0] STATE_INT = 0;
    
//    reg PLAYER = 0;
//    assign PLAYER_NEW = PLAYER;
    
    // For angles for P1
    reg [5:0] THETA1 = 31;
    wire [15:0] SIN_THETA1;
    wire [15:0] COS_THETA1;
    my_test_trig sin_1(.angle_in(THETA1+1), .s_c(0), .trig_out(SIN_THETA1));
    my_test_trig cos_1(.angle_in(THETA1+1), .s_c(1), .trig_out(COS_THETA1));
    assign THETA1_EXT = THETA1;
    
    // For anles for P2
    reg [5:0] THETA2 = 31;
    wire [15:0] SIN_THETA2;
    wire [15:0] COS_THETA2;
    my_test_trig sin_2(.angle_in(THETA2+1), .s_c(0), .trig_out(SIN_THETA2));
    my_test_trig cos_2(.angle_in(THETA2+1), .s_c(1), .trig_out(COS_THETA2));
    assign THETA2_EXT = THETA2;
    
    reg [15:0] flight_time_ms = 0;     //in 1ms
    //reg [31:0] flight_time_squared = 0;
    wire [31:0] flight_time_squared;
    assign flight_time_squared = flight_time_ms * flight_time_ms;
    
    reg [7:0] bullet_xpos = 0;
    reg [7:0] bullet_ypos = 0;
    
    
//    parameter POWER = 150;
    
    reg [7:0] POWER_INPUT = 50;
    reg POWER_COUNT_UP = 1;
    
    assign POWER_EXT = (POWER_INPUT == 150 ? 5 : 
                       (POWER_INPUT == 130 ? 4 : 
                       (POWER_INPUT == 110 ? 3 : 
                       (POWER_INPUT == 90 ? 2 : 
                       (POWER_INPUT == 70 ? 1 : 0)))));
    
    wire [23:0] POWER_X;
    wire [23:0] POWER_Y;
    assign POWER_X = PLAYER ? ((POWER_INPUT * COS_THETA2) >> 14) : ((POWER_INPUT * COS_THETA1) >> 14);
    assign POWER_Y = PLAYER ? ((POWER_INPUT * SIN_THETA2) >> 14) : ((POWER_INPUT * SIN_THETA1) >> 14);

    wire [31:0] DIST_X;
    wire [31:0] DIST_Y;
    wire [35:0] GRAVITY_COMP;
    assign DIST_X = ((POWER_X[16:0] * flight_time_ms) >> 10);
    assign DIST_Y = ((POWER_Y[16:0] * flight_time_ms) >> 10);
    assign GRAVITY_COMP = ((G * flight_time_squared) >> 20);
    assign GRAVITY_EXT = GRAVITY_COMP[7:0];
    
    
    reg [7:0] debouncecount = 0;   // count for debouncing barrel position
    reg debounceactive = 0;
    
    reg [9:0] debouncecount_centre = 0;   // count for debouncing power
    reg debounceactive_centre = 0;
    
    parameter BARREL = 6;
    // P1 barrel
    wire [7:0] P1_BARREL_X;
    wire [7:0] P1_BARREL_Y;
    assign P1_BARREL_X = P1_XPOS + ((BARREL * COS_THETA1) >> 14);
    assign P1_BARREL_Y = P1_YPOS + ((BARREL * SIN_THETA1) >> 14);
    // P2 barrel
    wire [7:0] P2_BARREL_X;
    wire [7:0] P2_BARREL_Y;
    assign P2_BARREL_X = P2_XPOS - ((BARREL * COS_THETA2) >> 14);
    assign P2_BARREL_Y = P2_YPOS + ((BARREL * SIN_THETA2) >> 14);
    
    wire hit1;
    wire hit2;
    hitbox_check check1(.bullet_xpos(bullet_xpos), .bullet_ypos(bullet_ypos), .player_xpos(P1_XPOS), .player_ypos(P1_YPOS), .hit(hit1));
    hitbox_check check2(.bullet_xpos(bullet_xpos), .bullet_ypos(bullet_ypos), .player_xpos(P2_XPOS), .player_ypos(P2_YPOS), .hit(hit2));
    
    assign BULLET_FLYING = (STATE_INT == 2);
    
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
        if (BTNC && ~debounceactive_centre) begin
            debounceactive_centre <= 1;
            debouncecount_centre <= 0;
        end
        if (debouncecount_centre >= 399 && debounceactive_centre) begin
            debounceactive_centre <= 0;
            debouncecount_centre <= 0;
        end
        else debouncecount_centre <= debouncecount_centre + 1;
        
        if (STATE_INT == 0) begin
            bullet_xpos <= PLAYER ? P2_XPOS : P1_XPOS;
            bullet_ypos <= PLAYER ? P2_YPOS : P1_YPOS;
            flight_time_ms <= 0;
            POWER_COUNT_UP <= 1;
            POWER_INPUT <= 50;
            LD <= 0;
            hit_player <= 0;
        end
        
        if (STATE_INT != 2 && ~debounceactive) begin
            if (!PLAYER) begin
                if (BTNU && THETA1 < 63)
                    THETA1 <= THETA1 + 1;
                else if (BTND && THETA1 > 0)
                    THETA1 <= THETA1 - 1;
            end else begin
                if (BTNU && THETA2 < 63)
                    THETA2 <= THETA2 + 1;
                else if (BTND && THETA2 > 0)
                    THETA2 <= THETA2 - 1;
            end
        end
        
        if (STATE_INT == 0 && BTNC) STATE_INT <= 1;
        
        if (STATE_INT == 1 && BTNC && ~debounceactive_centre) begin
            if (POWER_COUNT_UP && POWER_INPUT < 150)
                POWER_INPUT <= POWER_INPUT + 20;
            else if (~POWER_COUNT_UP && POWER_INPUT > 70)
                POWER_INPUT <= POWER_INPUT - 20;
            else if (POWER_INPUT >= 150) begin
                POWER_COUNT_UP <= 0;
                POWER_INPUT <= POWER_INPUT - 20;
            end
            else if (POWER_INPUT <= 70) begin
                POWER_COUNT_UP <= 1;
                POWER_INPUT <= POWER_INPUT + 20;
            end
        end
        
        if (STATE_INT == 1 || STATE_INT == 2) begin
            case (POWER_INPUT)
                70 : LD <= PLAYER ? 16'b0000_0000_0000_0001 : 16'b1000_0000_0000_0000;
                90 : LD <= PLAYER ? 16'b0000_0000_0000_0011 : 16'b1100_0000_0000_0000;
                110 : LD <= PLAYER ? 16'b0000_0000_0000_0111 : 16'b1110_0000_0000_0000;
                130 : LD <= PLAYER ? 16'b0000_0000_0000_1111 : 16'b1111_0000_0000_0000;
                150 : LD <= PLAYER ? 16'b0000_0000_0001_1111 : 16'b1111_1000_0000_0000;
            endcase
        end
        
        if (STATE_INT == 1 && !BTNC) STATE_INT <= 2;

        
        if (STATE_INT == 2) begin
            
            flight_time_ms <= flight_time_ms + 1;
            bullet_ypos <= PLAYER ? (P2_BARREL_Y + DIST_Y[7:0] - GRAVITY_COMP[7:0]) : (P1_BARREL_Y + DIST_Y[7:0] - GRAVITY_COMP[7:0]);
            bullet_xpos <= PLAYER ? (P2_BARREL_X - DIST_X[7:0]) : (P1_BARREL_X + DIST_X[7:0]);
            
            
            //If hit terrain
            if (bullet_xpos <= 0 || bullet_xpos >= 95 || bullet_ypos <= 5) begin
                STATE_INT <= 0;
                PLAYER_NEW <= ~PLAYER;
            end
            
            //check if bullet in hit box of player 1
            if (hit1 && flight_time_ms > 500) begin
                STATE_INT <= 0;
                hit_player <= 1;
                PLAYER_NEW <= ~PLAYER;
            end
            if (hit2 && flight_time_ms > 500) begin
                STATE_INT <= 0;
                hit_player <= 2;
                PLAYER_NEW <= ~PLAYER;
            end            
        end
        
    end
    
    always @ (posedge CLK_6p25M) begin
        if (STATE_INT == 2 
            && ((x_coord >= bullet_xpos - 1 && x_coord <= bullet_xpos + 1 && y_coord == bullet_ypos) 
            || (y_coord >= bullet_ypos - 1 && y_coord <= bullet_ypos + 1 && x_coord == bullet_xpos))
            ) begin 
            PIXEL_DATA <= PLAYER ? 16'b00000_000000_11111 : 16'b11111_000000_00000;
        end else if (x_coord == P1_BARREL_X && y_coord == P1_BARREL_Y)
            PIXEL_DATA <= 16'b11111_000000_00000;
        else if (x_coord == P2_BARREL_X && y_coord == P2_BARREL_Y)
            PIXEL_DATA <= 16'b00000_000000_11111;
//        else if (x_coord >= P1_XPOS - 2 && x_coord <= P1_XPOS + 2 && y_coord >= P1_YPOS - 2 && y_coord <= P1_YPOS + 2)
//            PIXEL_DATA <= 16'b11111_000000_00000;
//        else if (x_coord >= P2_XPOS - 2 && x_coord <= P2_XPOS + 2 && y_coord >= P2_YPOS - 2 && y_coord <= P2_YPOS + 2)
//            PIXEL_DATA <= 16'b00000_000000_11111;
        else
            PIXEL_DATA <= PIXEL_DATA_INPUT;
    end    
endmodule
