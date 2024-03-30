`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.03.2024 10:18:19
// Design Name: 
// Module Name: flexible_clock
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

module flexible_clock(input CLK_100MHz, input [31:0] COUNT_M, output reg FLEX_CLK_OUT = 0);

    reg [31:0] COUNT = 0;
    
    always @ (posedge CLK_100MHz) begin
        COUNT <= (COUNT == COUNT_M) ? 0 : COUNT + 1;
        FLEX_CLK_OUT <= (COUNT == 0) ? ~FLEX_CLK_OUT : FLEX_CLK_OUT;
    end
endmodule
