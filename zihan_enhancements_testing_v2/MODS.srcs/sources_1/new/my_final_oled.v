`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2024 12:02:09 AM
// Design Name: 
// Module Name: my_final_oled
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


module my_final_oled(input CLK, input [12:0] PIXEL_INDEX, output reg [15:0] PIXEL_DATA);
    
        
    reg [15:0] pic1 [6143:0]; 
    
    initial begin
        $readmemh("shrek.mem",pic1);
    end
    
        
    always @ (posedge CLK) begin
        PIXEL_DATA <= pic1[PIXEL_INDEX];
    end
    
endmodule
