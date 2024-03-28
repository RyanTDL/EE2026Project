`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2024 12:31:49 PM
// Design Name: 
// Module Name: my_final_oled_sim
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


module my_final_oled_sim(

    );
    
    wire [15:0] output_sim;
    
    my_final_oled test_unit_final_oled(.CLK(1), .PIXEL_INDEX(1), .PIXEL_DATA(output_sim));
    
endmodule
