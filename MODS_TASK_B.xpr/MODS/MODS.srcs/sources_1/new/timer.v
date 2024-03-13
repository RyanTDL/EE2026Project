`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2024 14:14:54
// Design Name: 
// Module Name: timer
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

module timer(input CLOCK, input reset, output reg [2:0] COUNT = 0);
    initial begin
        COUNT = 0;
    end
    
    always @ (posedge CLOCK) begin
        if (reset==0) begin
            COUNT <= 0;
        end else begin
            COUNT <= (COUNT == 4) ? 4 : COUNT + 1;
        end
    end
endmodule
