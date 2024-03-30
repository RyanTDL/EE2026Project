`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2024 10:37:27
// Design Name: 
// Module Name: Basic_Task_B
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


module Basic_Task_B(
    input clk_6p25MHz,
    //input clk_1Hz,
    input sw0,
    input [12:0] pixel_index,
    input btnC, btnL, btnR,
    output [15:0] oled_data
);

    // For the OLED display
    wire [7:0] x_coord = pixel_index%96;
    wire [6:0] y_coord = pixel_index/96;
    
    // For the green border and white squares
    wire [15:0] green_border_oled_data;
    reg [31:0] timer_4sec_toggle = 0;   // moved from timer.v
    reg [1:0] colour_counter = 0; // For the colour changer for squares
    reg [2:0] counter_position = 2; // For the position of the green border
    reg sw0_previous_state = 0; // Trigger for starting the 4-sec delay
    reg counter_position_set = 0; // To ensure counter_position is set to 4 only once
    //timer timer_4_seconds (clk_1Hz, sw0_previous_state, timer_4sec_toggle);
    green_border generate_green_border (clk_6p25MHz, x_coord, y_coord, counter_position, green_border_oled_data); //Generates green border automatically. Position dependent on "colour_counter" value
    white_squares generate_white_squares (clk_6p25MHz, x_coord, y_coord, timer_4sec_toggle, colour_counter, green_border_oled_data, oled_data); //Generates white squares automatically if sw0 turned on for 4 secs
    
    // For the debouncer 
    reg [20:0] debouncer_timer = 0;
    parameter [20:0] DEBOUNCE_TIME = 1250000; // Used to generate 200 milliseconds when used with a 6.25MHz clock    
    
    always @(posedge clk_6p25MHz) begin    
        
        // timer.v moved here
        if (sw0_previous_state==0) begin
            timer_4sec_toggle <= 0;
        end else begin
            timer_4sec_toggle <= (timer_4sec_toggle == 25000000) ? 25000000 : timer_4sec_toggle + 1;
        end
        
        // Set the green border when sw0 first turned on
        // Check if sw0 has been turned on
        if (sw0 && !sw0_previous_state) begin
            // Trigger the 4-second delay
            sw0_previous_state <= 1;
        end
        // When the 4-second timer toggles to 4, set counter_position to 4 if it hasn't been set yet
        if (timer_4sec_toggle == 25000000 && !counter_position_set) begin
            counter_position <= 4;
            counter_position_set <= 1; // Set the flag to prevent re-triggering
        end
        // Reset the counter_position_set if sw0 is turned off
        if (!sw0) begin
            counter_position_set <= 0;
            sw0_previous_state <= 0;
            counter_position <= 2;
            colour_counter <= 0;
        end

        // Use debounced signals instead of raw button presses
        // Toggling position of green border
        if (btnL && debouncer_timer==0 && timer_4sec_toggle==25000000) begin
            counter_position <= (counter_position == 0) ? 0 : (counter_position - 1);
            debouncer_timer <= DEBOUNCE_TIME; // Reset debouncer timer
        end
        if (btnR && debouncer_timer==0 && timer_4sec_toggle==25000000) begin
            counter_position <= (counter_position == 4) ? 4 : (counter_position + 1);
            debouncer_timer <= DEBOUNCE_TIME; // Reset debouncer timer
        end
        
        // Toggling colour of white boxes
        if (btnC && debouncer_timer==0 && timer_4sec_toggle==25000000) begin
            colour_counter <= (colour_counter == 3) ? 0 : (colour_counter + 1);
            debouncer_timer <= DEBOUNCE_TIME; // Reset debouncer timer
        end
        
        // This block can reset the debouncer timer after its duration expires
        if (debouncer_timer > 0) begin
            debouncer_timer <= debouncer_timer - 1;
        end
    end
    
endmodule
