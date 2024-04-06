`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2024 20:11:40
// Design Name: 
// Module Name: background
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


module battlefield(
    input clk_6p25MHz,
    input [12:0] pixel_index,
    input btnL, btnR, btnC, btnU, btnD,
    input player,
    input bullet_flying,
    output reg [15:0] oled_data,
    output [7:0] P1_XPOS_EXT, P1_YPOS_EXT,
    output [7:0] P2_XPOS_EXT, P2_YPOS_EXT,
    output reg LD0
);    

                                                                         
    // For the OLED display
    wire [7:0] x_coord = pixel_index%96;
    wire [6:0] y_coord = pixel_index/96;
    
    // For the debouncer
    reg [20:0] debouncer_timer = 0;
    parameter [20:0] DEBOUNCE_TIME = 400000; //Used to generate 0.1s when used with 6.25MHz clock
    
    // For the tank display
//    reg [7:0] tank_leftbound = 20;
//    reg [7:0] tank_rightbound = 30;
    reg [7:0] P1_XPOS = 9;
    reg [7:0] P1_YPOS = 7;
    wire [7:0] tank1_leftbound;
    wire [7:0] tank1_rightbound;
    assign tank1_leftbound = P1_XPOS - 6;
    assign tank1_rightbound = P1_XPOS + 4;
    
    assign P1_XPOS_EXT = P1_XPOS;
    assign P1_YPOS_EXT = P1_YPOS;
    
    reg [7:0] P2_XPOS = 86;
    reg [7:0] P2_YPOS = 7;
    wire [7:0] tank2_leftbound;
    wire [7:0] tank2_rightbound;
    assign tank2_leftbound = P2_XPOS - 6;
    assign tank2_rightbound = P2_XPOS + 4;
    
    assign P2_XPOS_EXT = P2_XPOS;
    assign P2_YPOS_EXT = P2_YPOS;
    
    reg [7:0] wall_leftbound = 46;
    reg [7:0] wall_rightbound = 50;
    
    always @(posedge clk_6p25MHz) begin   
    
    
        // Creating the debouncer. Use debounced signals instead of raw button presses
        if (!bullet_flying) begin
            if (btnL && debouncer_timer==0) begin
                if (!player)
                    P1_XPOS <= (tank1_leftbound == 0) ? P1_XPOS : (P1_XPOS - 1);
                else
                    P2_XPOS <= (tank2_leftbound == wall_rightbound) ? P2_XPOS : (P2_XPOS - 1);
                debouncer_timer <= DEBOUNCE_TIME; // Reset debouncer timer
            end
            if (btnR && debouncer_timer==0) begin
                if (!player)
                    P1_XPOS <= (tank1_rightbound == wall_leftbound) ? P1_XPOS : (P1_XPOS + 1);
                else 
                    P2_XPOS <= (tank2_rightbound == 95) ? P2_XPOS : (P2_XPOS + 1);
                debouncer_timer <= DEBOUNCE_TIME; // Reset debouncer timer
            end        
          
            // This block can reset the debouncer timer after its duration expires
            if (debouncer_timer > 0) begin
                debouncer_timer <= debouncer_timer - 1;
            end
        end
        
        
        // Create the grass
        if (y_coord>58) begin   
            oled_data <= 16'b00000_111111_00000;                   
        // Create the wall
        end else if (x_coord>wall_leftbound && x_coord<wall_rightbound && y_coord>40 && y_coord<59) begin   
            oled_data <= 16'b11000_110001_11000;
        // Creates player 1 tank                    
        end else if (
            (x_coord>tank1_leftbound && x_coord<tank1_rightbound && y_coord>55 && y_coord<59) ||
            (x_coord>tank1_leftbound+2 && x_coord<tank1_rightbound-2 && y_coord>53 && y_coord<56)
        ) begin
            oled_data <= 16'b11111_000000_00000;
        // Creates player 2 tank                    
        end else if (
            (x_coord>tank2_leftbound && x_coord<tank2_rightbound && y_coord>55 && y_coord<59) ||
            (x_coord>tank2_leftbound+2 && x_coord<tank2_rightbound-2 && y_coord>53 && y_coord<56)
        ) begin
            oled_data <= 16'b00000_000000_11111;     
        end else begin
            oled_data <= 16'b00000_000000_00000;
        end        
    end
    
endmodule