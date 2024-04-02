`timescale 1ns / 1ps

module hitbox_check(input [7:0]bullet_xpos, [7:0]bullet_ypos, [7:0]player_xpos, [7:0]player_ypos, output reg hit = 0);

    always @ (bullet_xpos, bullet_ypos) begin
        //code out the hit box here, just a 5x5 box for now
        //since the bullet is a cross can add +2 so it is 7x7
        
        if (bullet_xpos >= (player_xpos - 4) && bullet_xpos <= (player_xpos + 4))begin
            if (bullet_ypos >= (player_ypos - 4) && bullet_ypos <= (player_ypos + 4))
                hit = 1;
            else hit = 0;
        end else hit = 0;
        
    end

endmodule
