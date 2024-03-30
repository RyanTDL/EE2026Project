`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2024 11:22:36 AM
// Design Name: 
// Module Name: my_test_trig_sim
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


module my_test_trig_sim(

    );
    
    reg [7:0] angle_sim;
    wire [15:0] trig_out_sim;
    
    my_test_trig test_unit_trig(.angle_in(angle_sim), .trig_out(trig_out_sim));
    
    initial begin
        angle_sim = 0; #10;
        angle_sim = 1;
    end
    
endmodule
