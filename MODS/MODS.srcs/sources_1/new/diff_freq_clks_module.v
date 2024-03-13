`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2024 10:52:49 AM
// Design Name: 
// Module Name: diff_freq_clks_module
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


module diff_freq_clks_module(input CLK_100MHZ, output CLK_6p25MHZ_SIGNAL, CLK_25MHZ_SIGNAL);
    
    flexible_clock_module CLK_6p25MHZ(.CLK_100MHZ(CLK_100MHZ), .COUNT_M(7), .FLEX_CLK_OUT(CLK_6p25MHZ_SIGNAL));
    flexible_clock_module CLK_25MHZ(.CLK_100MHZ(CLK_100MHZ), .COUNT_M(1), .FLEX_CLK_OUT(CLK_25MHZ_SIGNAL));
    
endmodule
