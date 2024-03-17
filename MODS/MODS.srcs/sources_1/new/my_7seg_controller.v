`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2024 10:58:03 AM
// Design Name: 
// Module Name: my_7seg_controller
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


module my_7seg_controller(input CLK_10K,
                          SW13, SW14, SW15,
                          BTNC,
                          [3:0] STATE_TOP,
                          [6:0] SEG_PAINT,
                          output reg [7:0] SEG_OUT = 0,
                          reg [3:0] AN_OUT = 0,
                          reg STATE_FINAL = 0);
    
    reg [2:0] COUNT_1K = 0;
    reg CLK_1K_OUT = 0;
    reg [1:0] AN_COUNTER = 0;
    
    reg [1:0] STATE_INT = 0;
    
    reg [7:0] SEG_0 = 8'b11111111;
    reg [7:0] SEG_1 = 8'b11111111;
    
    wire [6:0] SEG_PAINT_FINAL;
    assign SEG_PAINT_FINAL = (SEG_PAINT == 7'b0001001) ? 7'b1111111 : SEG_PAINT;
    
    always @ (posedge CLK_10K) begin
        // Create a slower 1kHz clock for cycling the 4 anodes
        COUNT_1K <= (COUNT_1K == 4) ? 0 : COUNT_1K + 1;
        CLK_1K_OUT <= (COUNT_1K == 0) ? ~CLK_1K_OUT : CLK_1K_OUT;
        
        if (SW15) begin
            SEG_1 <= {1'b1, SEG_PAINT_FINAL};
        end else if (SW14) begin
            SEG_0 <= {1'b1, SEG_PAINT_FINAL};
        end else if (SW13) begin
            SEG_0 <= 8'b11111111;
            SEG_1 <= 8'b11111111;
        end else begin
            SEG_0 <= 8'b10100100;
            SEG_1 <= 8'b11111001;
        end
        
        if (STATE_TOP != 5) begin
            STATE_INT <= 0;
            AN_OUT <= 4'b1111;
        end else begin
            case (AN_COUNTER)
            0 : begin
                    AN_OUT <= 4'b1110;
                    SEG_OUT <= SEG_0;
                end
            1 : begin
                    AN_OUT <= 4'b1101;
                    SEG_OUT <= SEG_1;
                end
            2 : begin
                    AN_OUT <= 4'b1011;
                    SEG_OUT <= 8'b01111001;
                end
            3 : begin
                    AN_OUT <= 4'b0111;
                    SEG_OUT <= 8'b10010010;
                end
            endcase
        end
        
        if (BTNC && SEG_0 == 8'b10100100 && SEG_1 == 8'b11111001 && STATE_TOP == 5) begin
            STATE_INT <= 1;
        end
        
        if (STATE_INT == 1) begin
            SEG_0 <= 8'b10100100;
            SEG_1 <= 8'b11111001;
            STATE_FINAL <= 1;
        end else begin
            STATE_FINAL <= 0;
        end
        
    end
    
    always @ (posedge CLK_1K_OUT) begin
        AN_COUNTER <= (AN_COUNTER == 3) ? 0 : AN_COUNTER + 1;
    end
    
endmodule
