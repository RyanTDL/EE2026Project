`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2024 22:54:29
// Design Name: 
// Module Name: Control_inputs
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


module Control_inputs(input clk, player, btnC_p1, btnC_p2, btnU_p1, btnU_p2, btnD_p1, btnD_p2,
    output reg master_btnC, master_btnU, master_btnD);
    
    
    //player == 0, P1
    always @ (posedge clk) begin
        if (player) begin
            master_btnC <= btnC_p2;
            master_btnU <= btnU_p2;
            master_btnD <= btnD_p2;
        end 
        else begin
            master_btnC <= btnC_p1;
            master_btnU <= btnU_p1;
            master_btnD <= btnD_p1;
        end
    end    
    
endmodule
