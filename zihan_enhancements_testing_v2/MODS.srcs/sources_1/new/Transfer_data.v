`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2024 21:56:06
// Design Name: 
// Module Name: Transfer_data
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


module Transfer_data(input clk, input btnC, btnR, btnL, btnU, btnD, output reg [4:0] out_buttons);
    
     
    always @ (posedge clk) begin
        out_buttons[4] <= btnC;
        out_buttons[3] <= btnU;
        out_buttons[2] <= btnD;
        out_buttons[1] <= btnR;
        out_buttons[0] <= btnL;        
    end      
    
endmodule
