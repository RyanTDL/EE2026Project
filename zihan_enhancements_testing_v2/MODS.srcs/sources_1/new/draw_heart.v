`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2024 14:04:53
// Design Name: 
// Module Name: draw_heart
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


module draw_heart(input clk, input [12:0] pixel_index_input, input [15:0] pixel_data_input, input [7:0] heart_x, 
                  input [7:0] heart_y, output reg [15:0] pixel_data_out, output reg state = 0);
    
    wire [7:0] x, y;              
    assign x = pixel_index_input % 96;
    assign y = pixel_index_input / 96;
    
    always @ (posedge clk) begin
        if (heart_x == 255) begin
            state <= 1;
        end        
        if (state == 0 && 
         ((x == heart_x - 1 && y == heart_y - 1)
         || (x == heart_x + 1 && y == heart_y - 1)
         || (x == heart_x - 2 && y == heart_y)
         || (x == heart_x - 1 && y == heart_y) 
         || (x == heart_x && y == heart_y)
         || (x == heart_x + 2 && y == heart_y)
         || (x == heart_x - 1 && y == heart_y + 1)
         || (x == heart_x && y == heart_y + 1)
         || (x == heart_x + 1 && y == heart_y + 1)
         || (x == heart_x && y == heart_y + 2))
        ) begin
            pixel_data_out <= 16'b11111_000000_00000;
        end
        else if (state == 0 && (x == heart_x + 1 && y == heart_y)) begin
            pixel_data_out <= 16'b11111_110000_11000;
        end
        else begin
            pixel_data_out <= pixel_data_input;
        end

    end              
    
endmodule
