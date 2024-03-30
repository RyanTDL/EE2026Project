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
    [12:0] pixel_index,
    btnL, btnR, btnC, btnU, btnD,
    output reg [15:0] oled_data,
    output reg LD0
);    

                                                                         
    // For the OLED display
    wire [7:0] x_coord = pixel_index%96;
    wire [6:0] y_coord = pixel_index/96;
    
    // For the debouncer
    reg [20:0] debouncer_timer = 0;
    parameter [20:0] DEBOUNCE_TIME = 1250000; //Used to generate 0.2s when used with 6.25MHz clock
    
    // For the tank display
    reg [7:0] tank_leftbound = 20;
    reg [7:0] tank_rightbound = 30;
    reg [7:0] wall_leftbound = 46;
    reg [7:0] wall_rightbound = 50;
    

    always @(posedge clk_6p25MHz) begin   
    
    
        // Creating the debouncer. Use debounced signals instead of raw button presses
        if (btnL && debouncer_timer==0) begin
            tank_leftbound <= (tank_leftbound == 0) ? tank_leftbound : (tank_leftbound - 1);
            tank_rightbound <= (tank_leftbound == 0) ? tank_rightbound : (tank_rightbound - 1);
            debouncer_timer <= DEBOUNCE_TIME; // Reset debouncer timer
        end
        if (btnR && debouncer_timer==0) begin
            tank_rightbound <= (tank_rightbound == wall_leftbound) ? tank_rightbound : (tank_rightbound + 1);
            tank_leftbound <= (tank_rightbound == wall_leftbound) ? tank_leftbound : (tank_leftbound + 1);
            debouncer_timer <= DEBOUNCE_TIME; // Reset debouncer timer
        end        
      
        // This block can reset the debouncer timer after its duration expires
        if (debouncer_timer > 0) begin
            debouncer_timer <= debouncer_timer - 1;
        end
        
        
        // Create the grass
        if (y_coord>58) begin   
            oled_data <= 16'b00000_111111_00000;                   
        // Create the wall
        end else if (x_coord>wall_leftbound && x_coord<wall_rightbound && y_coord>40 && y_coord<59) begin   
            oled_data <= 16'b00000_111111_11111;
        // Creates player 1 tank                    
        end else if (
            (x_coord>tank_leftbound && x_coord<tank_rightbound && y_coord>55 && y_coord<59) ||
            (x_coord>tank_leftbound+2 && x_coord<tank_rightbound-2 && y_coord>53 && y_coord<56)
        ) begin
            oled_data <= 16'b00000_111111_11111;
        // Creates player 2 tank                    
        end else if (
            (x_coord>70 && x_coord<80 && y_coord>55 && y_coord<59) ||
            (x_coord>72 && x_coord<78 && y_coord>53 && y_coord<56)
        ) begin
            oled_data <= 16'b00000_000000_11111;     
        end else begin
            oled_data <= 16'b00000_000000_00000;
        end        
    end
    
endmodule