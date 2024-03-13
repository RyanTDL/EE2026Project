`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2024 11:29:18 PM
// Design Name: 
// Module Name: my_test_task_b
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


module my_test_task_b(input CLK_6p25M, CLK_10K, 
                       BTNC,
                       [3:0] STATE_TOP,
                       [12:0] PIXEL_INDEX,
                       output reg [15:0] PIXEL_DATA = 0);
    
    reg [2:0] STATE_INT = 0;
    
    always @ (posedge CLK_10K) begin
        if (STATE_TOP != 2) STATE_INT <= 0;
        
        if (BTNC) STATE_INT <= 1;
        
        if (STATE_INT == 1);
    end
    
    always @ (posedge CLK_6p25M) begin
        PIXEL_DATA <= 16'b00000_111111_00000;
    end
    
endmodule
