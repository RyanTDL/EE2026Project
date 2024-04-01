`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2024 02:32:46 PM
// Design Name: 
// Module Name: my_test_direction
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


module my_test_direction(input CLK_6p25M, BTNU, BTND,
                         [12:0] PIXEL_INDEX, 
                         output reg [15:0] PIXEL_DATA);
    
    wire [7:0] x_coord = PIXEL_INDEX % 96;
    wire [7:0] y_coord = 63 - PIXEL_INDEX / 96;
    
    reg [23:0] debouncecount = 0;   // count up to 1250000
    reg debounceactive = 0;
    
    parameter DIST = 50;
    
    reg [7:0] THETA = 32;
    
    wire [15:0] SIN_THETA;
    wire [15:0] COS_THETA;
    
    wire [7:0] DIST_X;
    wire [7:0] DIST_Y;
    
    my_test_trig sin_1(.angle_in(THETA), .s_c(0), .trig_out(SIN_THETA));
    my_test_trig cos_1(.angle_in(THETA), .s_c(1), .trig_out(COS_THETA));
    
    assign DIST_X = (DIST * COS_THETA) >> 14;
    assign DIST_Y = (DIST * SIN_THETA) >> 14;
    
    always @ (posedge CLK_6p25M) begin
        
        if ((BTNU || BTND) && ~debounceactive) begin
            debounceactive = 1;
            debouncecount = 0;
        end
        if (debouncecount == 312500 && debounceactive) begin
            debounceactive = 0;
            debouncecount = 0;
        end
        else debouncecount = debouncecount + 1;
        
        if (BTNU && ~debounceactive && THETA < 64)
            THETA <= THETA + 1;
        else if (BTND && ~debounceactive && THETA > 0)
            THETA <= THETA - 1;
            
        if (x_coord == DIST_X && y_coord == DIST_Y) 
            PIXEL_DATA <= 16'hffff;
        else if (x_coord == 0 && y_coord == 0)
            PIXEL_DATA <= 16'hffff;
        else
            PIXEL_DATA <= 0;
    end
    
endmodule
