`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2024 10:55:58 AM
// Design Name: 
// Module Name: diff_freq_clks_module_sim
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


module diff_freq_clks_module_sim();
    
    reg sim_CLOCK;
    wire sim_CLK_6p25MHZ_SIGNAL;
    wire sim_CLK_25MHZ_SIGNAL;
    
    diff_freq_clks_module dut(.CLK_100MHZ(sim_CLOCK), .CLK_6p25MHZ_SIGNAL(sim_CLK_6p25MHZ_SIGNAL), .CLK_25MHZ_SIGNAL(sim_CLK_25MHZ_SIGNAL));
    
    initial begin
        sim_CLOCK = 0;
    end
    
    always begin
        #5 sim_CLOCK = ~sim_CLOCK;
    end
    
endmodule
