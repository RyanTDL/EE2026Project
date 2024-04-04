`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2024 21:56:32
// Design Name: 
// Module Name: Receive_data
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


module Receive_data(input clk, input [4:0] data_in, output reg btnC_p2, btnU_p2, btnD_p2, btnR_p2, btnL_p2);
    
    
    always @ (posedge clk) begin
         
         btnC_p2 <= data_in[4];
         btnU_p2 <= data_in[3];
         btnD_p2 <= data_in[2];
         btnR_p2 <= data_in[1]; 
         btnL_p2 <= data_in[0];
        
    end
    
endmodule

