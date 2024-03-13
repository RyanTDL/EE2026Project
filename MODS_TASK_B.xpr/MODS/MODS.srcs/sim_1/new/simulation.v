`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.03.2024 09:47:25
// Design Name: 
// Module Name: simulation
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

module slow_clock_simulation();

    // Simulation inputs
    reg CLK_100MHz;
    
    // Simulation output;
    wire FLEX_CLK_OUT;
    
    // Instantiation of the module to be simulated
    flexible_clock my_simulation(CLK_100MHz, 7, FLEX_CLK_OUT);
    
    initial begin
        CLK_100MHz = 0;
    end

    always begin
        #5 CLK_100MHz = ~CLK_100MHz;
    end
    
endmodule