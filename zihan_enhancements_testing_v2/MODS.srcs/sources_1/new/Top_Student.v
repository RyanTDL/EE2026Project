`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (input clk, 
                    btnC, btnU, btnL, btnR, btnD,
                    [15:0] sw,
                    [4:0] JA,
                    output [7:0] JB, 
                    [4:0] JC,
                    [15:0] led, 
                    [7:0] seg, 
                    [3:0] an, 
                    inout PS2Clk, PS2Data);
    
    wire fb;
    wire sending_pix;
    wire sample_pix;
    wire [12:0] pixel_index;
    wire [15:0] oled_data_background, oled_data_final;
    wire [15:0] oled_data_final_1;
    wire [15:0] oled_data_final_2; 
    // oled_data_a, oled_data_b, oled_data_c, oled_data_d;
    
    wire clk25m;
    wire clk12p5m;
    wire clk6p25m;
    wire clk10k;
    wire clk2k;
    wire clk1k;
    wire clk1;
    
    flexible_clock_module CLK_25MHZ(.CLK_100MHZ(clk), .COUNT_M(1), .FLEX_CLK_OUT(clk25m));
    flexible_clock_module CLK_12p5MHZ(.CLK_100MHZ(clk), .COUNT_M(3), .FLEX_CLK_OUT(clk12p5m));
    flexible_clock_module CLK_6p25MHZ(.CLK_100MHZ(clk), .COUNT_M(7), .FLEX_CLK_OUT(clk6p25m));
    flexible_clock_module CLK_10KHZ(.CLK_100MHZ(clk), .COUNT_M(4999), .FLEX_CLK_OUT(clk10k));
    flexible_clock_module CLK_2KHZ(.CLK_100MHZ(clk), .COUNT_M(24999), .FLEX_CLK_OUT(clk2k));
    flexible_clock_module CLK_1KHZ(.CLK_100MHZ(clk), .COUNT_M(49999), .FLEX_CLK_OUT(clk1k));
    flexible_clock_module CLK_1HZ(.CLK_100MHZ(clk), .COUNT_M(49999999), .FLEX_CLK_OUT(clk1));
    
    Oled_Display unit_oled(.clk(clk6p25m), 
                           .reset(0), 
                           .frame_begin(fb), 
                           .sending_pixels(sending_pix),
                           .sample_pixel(sample_pix), 
                           .pixel_index(pixel_index), 
                           .pixel_data(oled_data_final_2), 
                           .cs(JB[0]), 
                           .sdin(JB[1]), 
                           .sclk(JB[3]), 
                           .d_cn(JB[4]), 
                           .resn(JB[5]), 
                           .vccen(JB[6]),
                           .pmoden(JB[7]));
    
//    my_test_background TEST_BACKGROUND(.CLK(clk6p25m),
//                                       .PIXEL_INDEX(pixel_index), 
//                                       .PIXEL_DATA(oled_data_background));
    
    // 0 for P1, 1 for P2
    wire player;
    
    //0 for Multiplayer, 1 for Singleplayer
    wire singleplayer = 0;
    
    // 0 for no bullet, 1 for bullet in flight
    wire bullet_flying;
    
    wire [7:0] p1_xpos;
    wire [7:0] p1_ypos;
//    assign p1_xpos = 9;
//    assign p1_ypos = 7;
    
    wire [7:0] p2_xpos;
    wire [7:0] p2_ypos;
//    assign p2_xpos = 86;
//    assign p2_ypos = 7;
    
    wire [3:0] power_ext;
//    wire [5:0] theta1_ext;
    wire [5:0] theta2_ext; 
//    wire [7:0] gravity_ext;
    
    //CALLING AI MODULE :)
    parameter AI_POWER = 4;
    //NOTE: Try to keep AI_POWER > 3
    wire AI_LEFT, AI_RIGHT, AI_UP, AI_DOWN, AI_CENTRE;
    AI_Module ai (.xpos(p2_xpos), .ypos(p2_ypos), .current_angle(theta2_ext), 
                  .xpos_opp(p1_xpos), .ypos_opp(p1_ypos), 
                  .state((player & singleplayer)), .clk1k(clk1k),
                  .gravity(100), .target_power(AI_POWER), .current_power(power_ext),
                  .left(AI_LEFT), .right(AI_RIGHT), 
                  .up(AI_UP), .down(AI_DOWN),
                  .centre(AI_CENTRE));
    
    wire btnC_p2, btnU_p2, btnD_p2, btnL_p2, btnR_p2;

    Receive_data receive (.clk(clk2k), .data_in(JA), .btnC_p2(btnC_p2), .btnU_p2(btnU_p2),
                 .btnD_p2(btnD_p2), .btnR_p2(btnR_p2), .btnL_p2(btnL_p2));
    
    //Assignment of p2 outputs depending on single or multiplayer
    wire p2_C_output, p2_U_output, p2_D_output, p2_L_output, p2_R_output;
    
    assign p2_C_output = (singleplayer) ? AI_CENTRE : btnC_p2;
    assign p2_U_output = (singleplayer) ? AI_UP : btnU_p2;
    assign p2_D_output = (singleplayer) ? AI_DOWN : btnD_p2;
    assign p2_L_output = (singleplayer) ? AI_LEFT : btnL_p2;
    assign p2_R_output = (singleplayer) ? AI_RIGHT : btnR_p2;
    
    wire btnC_master, btnU_master, btnD_master, btnL_master, btnR_master;
    
    Control_inputs ctl (.clk(clk2k), .player(player), 
    .btnC_p1(btnC), .btnC_p2(p2_C_output), 
    .btnU_p1(btnU), .btnU_p2(p2_U_output), 
    .btnD_p1(btnD), .btnD_p2(p2_D_output),
    .btnL_p1(btnL), .btnL_p2(p2_L_output),
    .btnR_p1(btnR), .btnR_p2(p2_R_output),
    .master_btnC(btnC_master), .master_btnU(btnU_master), .master_btnD(btnD_master), .master_btnL(btnL_master), .master_btnR(btnR_master));
    
    
    battlefield multi_player (.clk_6p25MHz(clk6p25m), 
                              .P1_XPOS_EXT(p1_xpos),
                              .P1_YPOS_EXT(p1_ypos),
                              .P2_XPOS_EXT(p2_xpos),
                              .P2_YPOS_EXT(p2_ypos),
                              .pixel_index(pixel_index), 
                              .btnL(btnL_master), .btnR(btnR_master), .btnC(btnC_master), .btnU(btnU_master), .btnD(btnD_master), 
                              .player(player),
                              .bullet_flying(bullet_flying),
                              .oled_data(oled_data_background)
    //                              .LD0(led[0])
                              ); 
        
    wire [1:0] health_p1, health_p2;     
    wire ending_1, ending_2;       
    wire [2:0] hit_player;

    my_test_ballistic TEST_BALLISTIC(.CLK_6p25M(clk6p25m),
                                     .CLK_1K(clk1k),
                                     .BTNC(btnC_master),
                                     .BTNU(btnU_master),
                                     .BTND(btnD_master),
                                     .PLAYER(player),
                                     .P1_XPOS(p1_xpos),
                                     .P1_YPOS(p1_ypos),
                                     .P2_XPOS(p2_xpos),
                                     .P2_YPOS(p2_ypos),
                                     .PIXEL_INDEX(pixel_index), 
                                     .PIXEL_DATA_INPUT(oled_data_background),
                                     .PIXEL_DATA(oled_data_final),
                                     .LD(led),
                                     .PLAYER_NEW(player),
                                     .BULLET_FLYING(bullet_flying),
//                                     .THETA1_EXT(theta1_ext), 
                                     .THETA2_EXT(theta2_ext),
                                     .POWER_EXT(power_ext),
                                     .HEALTH_P1(health_p1), 
                                     .HEALTH_P2(health_p2));

     
//     wire [1:0] hit1, hit2;
//     assign hit1 = (hit_player == 1) ? hit1 + 1 : hit1;
//     assign hit2 = (hit_player == 2) ? hit2 + 1 : hit2;
     health player1_hp (.clk(clk6p25m), .player(0), .health(health_p1), .end_game(ending_1), 
                        .PIXEL_INDEX(pixel_index), .PIXEL_DATA_IN(oled_data_final), .PIXEL_DATA_OUT(oled_data_final_1));
     health player2_hp (.clk(clk6p25m), .player(1), .health(health_p2), .end_game(ending_2),
                        .PIXEL_INDEX(pixel_index), .PIXEL_DATA_IN(oled_data_final_1), .PIXEL_DATA_OUT(oled_data_final_2));     

      
     Transfer_data transmit (.clk(clk2k), .btnC(btnC), .btnR(btnR), .btnL(btnL), 
                            .btnU(btnU), .btnD(btnD), .out_buttons(JC));
      


endmodule
