`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2024 08:11:33 PM
// Design Name: 
// Module Name: my_test_pixel_loop
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


module my_test_pixel_loop(input CLK, [12:0] PIXEL_INDEX, output reg [15:0] PIXEL_DATA = 0);
    
    parameter R1 = 10;
    parameter R2 = 20;
    parameter K2 = 50;
    parameter K1 = 40;
    
    wire [7:0] x_coord;
    wire [7:0] y_coord;
    assign x_coord = PIXEL_INDEX % 96;
    assign y_coord = 63 - PIXEL_INDEX / 96;
    
    always @ (posedge CLK) begin
        
    end
    
endmodule
