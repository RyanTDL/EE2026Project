`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2024 09:24:16 PM
// Design Name: 
// Module Name: my_test_background
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


module my_test_background(input CLK, 
                          //input [7:0] XPOS, YPOS,
                          input [12:0] PIXEL_INDEX, 
                          output reg [15:0] PIXEL_DATA);
    
    wire [7:0] x_coord = PIXEL_INDEX % 96;
    wire [7:0] y_coord = PIXEL_INDEX / 96;
    
    always @ (posedge CLK) begin
        if (y_coord > 58) begin
            PIXEL_DATA <= 15'b00000_111111_00000;
        end else begin
            PIXEL_DATA <= 16'h0000;
        end
    end
    
endmodule
