`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2024 09:30:38 PM
// Design Name: 
// Module Name: my_test_nested_loops
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


module my_test_nested_loops(input clk,
                            output [3:0] outer_count_out,
                            output [3:0] inner_count_out,
                            output [15:0] led);
    
    reg [3:0] outer_count_reg = 0;
    reg [3:0] inner_count_reg = 0;
    
    always @ (posedge clk) begin
        if (inner_count_reg == 3) begin
            inner_count_reg <= 0;
            outer_count_reg <= (outer_count_reg == 3) ? 0 : outer_count_reg + 1;
        end else begin
            inner_count_reg <= inner_count_reg + 1;
        end
    end
    
    assign outer_count_out = outer_count_reg;
    assign inner_count_out = inner_count_reg;
    
    assign led[15] = outer_count_reg == 3 ? 1 : 0;
    assign led[14] = outer_count_reg == 2 ? 1 : 0;
    assign led[13] = outer_count_reg == 1 ? 1 : 0;
    assign led[12] = outer_count_reg == 0 ? 1 : 0;
    
    assign led[3] = inner_count_reg == 3 ? 1 : 0;
    assign led[2] = inner_count_reg == 2 ? 1 : 0;
    assign led[1] = inner_count_reg == 1 ? 1 : 0;
    assign led[0] = inner_count_reg == 0 ? 1 : 0;
    
endmodule
