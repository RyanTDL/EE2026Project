`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2024 17:25:15
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
                         [15:0] ORIGINAL_PIXEL_DATA,
                         output reg [15:0] PIXEL_DATA,
                         output reg LD0);
    

    
//    always @ (posedge CLK_1K) begin        

        
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

        if (STATE_INT == 2 
            && ((x_coord >= bullet_xpos - 1 && x_coord <= bullet_xpos + 1 && y_coord == bullet_ypos) 
            || (y_coord >= bullet_ypos - 1 && y_coord <= bullet_ypos + 1 && x_coord == bullet_xpos))
            ) begin 
            PIXEL_DATA <= 16'b11111_000000_00000;;
        end
    end    
endmodule