`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2024 20:27:11
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


module timer_module(
    input CLK_1Hz,
    [31:0] COUNT_M,
    output reg FLEX_CLK_OUT = 0
);

    reg [31:0] COUNT = 0;
    
    always @ (posedge CLK_1Hz) begin
        COUNT <= (COUNT == COUNT_M) ? COUNT : COUNT + 1;
        FLEX_CLK_OUT <= (COUNT == COUNT_M) ? 1 : 0; // Returns 1 once timer is reached
    end
    
endmodule
