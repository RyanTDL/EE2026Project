`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2024 09:13:07 AM
// Design Name: 
// Module Name: my_basic_task_d
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


module my_basic_task_d(input CLK_6p25M, CLK_10K, 
                       BTNC, BTNU, BTNL, BTNR, 
                       SW0,
                       [3:0] STATE_TOP,
                       [12:0] PIXEL_INDEX,
                       output reg [15:0] PIXEL_DATA = 0);
    
    reg [2:0] STATE_INT = 0;    // 0: initial, 1: BTNC, 2: BTNU, 3: BTNL, 4: BTNR, 5: stopped
    
    wire [7:0] x_coord;
    wire [7:0] y_coord;
    assign x_coord = PIXEL_INDEX % 96;
    assign y_coord = PIXEL_INDEX / 96;
    
    reg [7:0] x_min = 0, x_max = 4, y_min = 0, y_max = 4;
    reg [15:0] colour = 0;
    
    reg [9:0] count_15pix = 0, count_30pix = 0, count_45pix = 0;
    
    always @ (posedge CLK_10K) begin
        
        count_15pix <= (count_15pix == 666) ? 0 : count_15pix + 1;
        count_30pix <= (count_30pix == 332) ? 0 : count_30pix + 1;
        count_45pix <= (count_45pix == 221) ? 0 : count_45pix + 1;
        
        if (STATE_TOP != 4) STATE_INT <= 0;
        
        if (BTNC && (STATE_INT == 0 || STATE_INT == 5)) STATE_INT <= 1;
        
        if (BTNU && STATE_INT != 0) STATE_INT <= 2;
        
        if (BTNL && STATE_INT != 0) STATE_INT <= 3;
        
        if (BTNR && STATE_INT != 0) STATE_INT <= 4;
        
        if (STATE_INT == 0) begin
            x_min <= 0;
            x_max <= 4;
            y_min <= 0;
            y_max <= 4;
            colour <= 16'b00000_000000_11111;
        end

        if (STATE_INT == 1) begin
            x_min <= 45;
            x_max <= 49;
            y_min <= 59;
            y_max <= 63;
            colour <= 16'b11111_111111_11111;
        end

        if (STATE_INT == 2) begin
            if (SW0) begin
                y_min <= (count_15pix == 0 && y_min > 0) ? y_min - 1 : y_min;
                y_max <= (count_15pix == 0 && y_max > 4) ? y_max - 1 : y_max;
            end else begin
                y_min <= (count_45pix == 0 && y_min > 0) ? y_min - 1 : y_min;
                y_max <= (count_45pix == 0 && y_max > 4) ? y_max - 1 : y_max;
            end
            if (y_min == 0) begin
                STATE_INT <= 5;
            end
        end

        if (STATE_INT == 3) begin
            if (SW0) begin
                x_min <= (count_30pix == 0 && x_min > 0) ? x_min - 1 : x_min;
                x_max <= (count_30pix == 0 && x_max > 4) ? x_max - 1 : x_max;
            end else begin
                x_min <= (count_45pix == 0 && x_min > 0) ? x_min - 1 : x_min;
                x_max <= (count_45pix == 0 && x_max > 4) ? x_max - 1 : x_max;
            end
            if (x_min == 0) begin
                STATE_INT <= 5;
            end
        end

        if (STATE_INT == 4) begin
            if (SW0) begin
                x_min <= (count_30pix == 0 && x_min < 91) ? x_min + 1 : x_min;
                x_max <= (count_30pix == 0 && x_max < 95) ? x_max + 1 : x_max;
            end else begin
                x_min <= (count_45pix == 0 && x_min < 91) ? x_min + 1 : x_min;
                x_max <= (count_45pix == 0 && x_max < 95) ? x_max + 1 : x_max;
            end
            if (x_min == 91) begin
                STATE_INT <= 5;
            end
        end
    
    end
    
    always @ (posedge CLK_6p25M) begin
        if (x_coord >= x_min && x_coord <= x_max && y_coord >= y_min && y_coord <= y_max) begin
            PIXEL_DATA <= colour;
        end else begin
            PIXEL_DATA <= 0;
        end
    end
    
endmodule
