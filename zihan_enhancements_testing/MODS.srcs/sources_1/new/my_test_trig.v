`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2024 10:27:03 AM
// Design Name: 
// Module Name: my_test_trig
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


module my_test_trig(input [7:0] angle_in, input s_c, output reg [15:0] trig_out = 0);
    
    reg [15:0] trig_data [64:0];
    
    initial begin
        $readmemh("sine_lut.mem", trig_data);
    end 
    
    wire [7:0] angle;
    assign angle = s_c ? (angle_in + 64) % 256 : angle_in;  // input s_c =0 for sine, =1 for cosine
    
    always @ (angle) begin
        if (angle >= 0 && angle <= 64) begin
            trig_out <= trig_data[angle];
        end else if (angle >= 65 && angle <= 128) begin
            trig_out <= trig_data[128 - angle];
        end else if (angle >= 129 && angle <= 192) begin
            trig_out <= (trig_data[angle - 128] | (1 << 15));
        end else if (angle >= 193 && angle <= 255) begin
            trig_out <= (trig_data[256 - angle] | (1 << 15));
        end
    end
    
endmodule
