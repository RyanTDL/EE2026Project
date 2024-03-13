`timescale 1ns / 1ps

module subtask_a(input clk25m, input [3:0] state_top, input [12:0] pixel_index, input btnC, btnD, output reg [15:0] oled_data = 16'b0);
    
    //USE 25MHz Clock
    
    reg initiate = 0;
    reg [1:0] greenstage = 0;
    reg [2:0] shapestage = 0;
    reg [31:0] count = 1;
    reg [31:0] num = 0;
    reg [31:0] debouncecount = 0;
    // count up to 5000000
    reg debounceactive = 0;
    
    wire [6:0] x;
    wire [7:0] y;
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
    
    always @ (posedge clk25m) begin
        
        if (state_top != 1) begin
            initiate = 0;
            greenstage = 0;
            shapestage = 0;
            count = 1;
            num = 0;
            debouncecount = 0;
            debounceactive = 0;
        end
        else begin
            initiate = btnC ? 1 : initiate;
            
            
            if (((x == 2 || x == 93) && y >= 2 && y <= 61) || ((y == 2 || y == 61) && x >= 2 && x <= 93)) begin
                oled_data <= 16'b1111100000000000;
            end
            
            else if (initiate) begin
            
                if ((x >= 5 && x <= 90 && y >= 5 && y <= 58) && ~(x >= 8 && x <= 87 && y >= 8 && y<= 55)) begin
                    oled_data <= 16'b1111100111100000;
                end
                else oled_data <= 16'b0;
                
                num = (greenstage == 0) ? 50000000:
                      (greenstage == 1) ? 37500000:
                      (greenstage == 2) ? 25000000:
                      (greenstage == 3) ? 25000000:
                      9999;
                count = (count == num) ? 0 : count + 1;
                greenstage = (count == 0) ? greenstage + 1 : greenstage;
    //            greenstage = (greenstage > 3) ? 0 : greenstage;
                
                if (greenstage >= 1) begin
                    if (((x == 11 || x == 84) && y >= 11 && y <= 52) || ((y == 11 || y == 52) && x >= 11 && x <= 84)) begin
                        oled_data <= 16'b0000011111100000;
                    end
    //                else oled_data <= 16'b0;
                end
                if (greenstage >= 2) begin
                    if ((x >= 14 && x <= 81 && y >= 14 && y <= 49) && ~(x >= 16 && x <= 79 && y >= 16 && y <= 47)) begin
                        oled_data <= 16'b0000011111100000;
                    end
    //                else oled_data <= 16'b0;
                end
                if (greenstage >= 3) begin
                    if ((x >= 19 && x <= 76 && y >= 19 && y <= 44) && ~(x >= 22 && x <= 73 && y >= 22 && y <= 41)) begin
                        oled_data <= 16'b0000011111100000;
                    end
    //                else oled_data <= 16'b0;
                end
                
                shapestage = (btnD && ~debounceactive) ? shapestage + 1 : shapestage;
                // ACTIVATION CHECK
                if (btnD && ~debounceactive) begin
                    debounceactive = 1;
                    debouncecount = 0;
                end
                
                if (debouncecount == 5000000 && debounceactive) begin
                    debounceactive = 0;
                    debouncecount = 0;
                end
                else debouncecount = debouncecount + 1;
                
                
                
                shapestage = (shapestage > 3) ? 1 : shapestage;
                if (shapestage == 1) begin
                    if (x >= 45 && x <= 50 && y >= 29 && y <= 34) begin
                        oled_data <= 16'b1111100000000000;        
                    end
                end
                else if (shapestage == 2) begin
                    if (((x - 47)*(x - 48) + (y - 31)*(y - 32)) <= 36) begin
                        oled_data <= 16'b1111100111100000;
                    end
                end
                else if (shapestage == 3)begin
                    if (y >= (-2*x + 125) && y >= (2*x - 67) && y <= 38) begin
                        oled_data <= 16'b0000011111100000;
                    end
                end
                
    //            else oled_data <= 16'b0;
                
            end
            else oled_data <= 16'b0;
        end
    end

endmodule
