`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2024 10:49:26 PM
// Design Name: 
// Module Name: my_final_oled
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


module my_final_oled(input CLK_6p25M, [12:0] PIXEL_INDEX, output reg [15:0] PIXEL_DATA = 0);
    
    wire [6:0] x;
    wire [7:0] y;
    assign x = PIXEL_INDEX % 96;
    assign y = PIXEL_INDEX / 96;
    always @ (posedge CLK_6p25M) begin
        if ((((x - 35)*(x - 35) + (y - 20)*(y - 20)) <= 9) || (((x - 60)*(x - 60) + (y - 20)*(y - 20)) <= 9)) begin
            PIXEL_DATA <= 16'b0;
        end
        else if ((((x - 35)*(x - 35) + (y - 20)*(y - 20)) <= 64) || (((x - 60)*(x - 60) + (y - 20)*(y - 20)) <= 64)) begin
            PIXEL_DATA <= 16'b1111111111111111;
        end
        else if ((((x - 47)*(x - 48) + (y - 31)*(y - 32)) <= 400) && y >= 32) begin
            PIXEL_DATA <= 16'b1111100000000000;
        end
        else if (((x - 47)*(x - 48) + (y - 31)*(y - 32)) <= 729) begin
            PIXEL_DATA <= 16'b1111101111100000;
        end
        else PIXEL_DATA <= 0;
    end
    
endmodule
