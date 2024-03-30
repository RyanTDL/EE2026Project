`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2024 20:47:27
// Design Name: 
// Module Name: select_mode
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


module select_mode(
    input clk_6p25MHz,
    [12:0] pixel_index,
    btnU, btnD, btnC, 
    output reg [15:0] oled_data,
    output reg [1:0] start_game=0
);    
    
    // For the OLED display
    wire [7:0] x_coord = pixel_index%96;
    wire [6:0] y_coord = pixel_index/96;
    parameter line_width = 3;
    parameter word_width = 10;
    parameter word_height = 10;
    parameter word_colour = 16'b11111_000000_11111;
    
    reg select_icon = 0;
    
    always @(posedge clk_6p25MHz) begin

        // Creating the word "SET". Thickness of line is set above 
        if ((x_coord>4 && x_coord<4+word_width && y_coord>9 && y_coord<9+line_width) || 
            (x_coord>4 && x_coord<4+word_width && y_coord>13 && y_coord<13+line_width) ||
            (x_coord>4 && x_coord<4+word_width && y_coord>17 && y_coord<17+line_width) ||
            (x_coord>4 && x_coord<8 && y_coord>8+line_width && y_coord<14) ||
            (x_coord>word_width && x_coord<4+word_width && y_coord>15 && y_coord<18)
        ) begin
            oled_data <= word_colour; 
        end else if ((x_coord>15 && x_coord<15+word_width && y_coord>9 && y_coord<9+line_width) || 
            (x_coord>15 && x_coord<15+word_width && y_coord>13 && y_coord<13+line_width) ||
            (x_coord>15 && x_coord<15+word_width && y_coord>17 && y_coord<17+line_width) ||
            (x_coord>15 && x_coord<19 && y_coord>8+line_width && y_coord<14) ||
            (x_coord>15 && x_coord<19 && y_coord>15 && y_coord<18)
        ) begin
            oled_data <= word_colour;  
        end else if ((x_coord>26 && x_coord<26+word_width && y_coord>9 && y_coord<9+line_width) || (x_coord>29 && x_coord<33 && y_coord>11 && y_coord<20)) begin  
            oled_data <= word_colour;
        // Creating the word "GAME"
        end else if (
            (x_coord>40 && x_coord<40+word_width && y_coord>9 && y_coord<9+line_width) || 
            (x_coord>44 && x_coord<40+word_width && y_coord>13 && y_coord<13+line_width) ||
            (x_coord>40 && x_coord<40+word_width && y_coord>17 && y_coord<17+line_width) ||
            (x_coord>40 && x_coord<44 && y_coord>8+line_width && y_coord<18) ||
            (x_coord>46 && x_coord<40+word_width && y_coord>15 && y_coord<18)            
        ) begin  
            oled_data <= word_colour;
        end else if (
            (x_coord>51 && x_coord<51+word_width && y_coord>9 && y_coord<9+line_width) || 
            (x_coord>54 && x_coord<58 && y_coord>14 && y_coord<14+line_width) ||
            (x_coord>51 && x_coord<55 && y_coord>8+line_width && y_coord<20) ||
            (x_coord>57 && x_coord<51+word_width && y_coord>8+line_width && y_coord<20)            
        ) begin
            oled_data <= word_colour;
        end else if (
            (x_coord>62 && x_coord<66 && y_coord>9 && y_coord<20) ||
            (x_coord>65 && x_coord<71 && y_coord>9+(x_coord-66)*(8/4) && y_coord<16+(x_coord-66)*(8/4) && y_coord<20) || 
            (x_coord>69 && x_coord<75 && y_coord<20-(x_coord-70)*(8/4) && y_coord>13-(x_coord-70)*(8/4) && y_coord<20 && y_coord>9) ||           
            (x_coord>73 && x_coord<77 && y_coord>9 && y_coord<20)
        ) begin    
            oled_data <= word_colour;                      
        end else if (
            (x_coord>78 && x_coord<78+word_width && y_coord>9 && y_coord<9+line_width) || 
            (x_coord>78 && x_coord<78+word_width && y_coord>13 && y_coord<13+line_width) ||
            (x_coord>78 && x_coord<78+word_width && y_coord>17 && y_coord<17+line_width) ||
            (x_coord>78 && x_coord<82 && y_coord>8+line_width && y_coord<14) ||
            (x_coord>78 && x_coord<82 && y_coord>15 && y_coord<18)      
        ) begin 
            oled_data <= word_colour;  
        end else if (
            (x_coord>90 && x_coord<93 && y_coord>11 && y_coord<14) ||  
            (x_coord>90 && x_coord<93 && y_coord>15 && y_coord<18)    
        ) begin 
            oled_data <= word_colour;
            
        ////////////////////////////////////////// ////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////// Create the 'Singleplayer'//////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                
        //////////////////////////////////////////
        /////// Create the 'Single'///////////////
        //// Height is 31 to 37 //////////////////
        //////////////////////////////////////////             
        end else if (
            (x_coord>7 && x_coord<14 && y_coord==31) || 
            (x_coord>7 && x_coord<14 && y_coord==34) ||
            (x_coord>7 && x_coord<14 && y_coord==37) ||
            (x_coord==8 && y_coord>31 && y_coord<34) ||
            (x_coord==13 && y_coord>34 && y_coord<37)
        ) begin
            oled_data <= word_colour; 
        end else if (
            (x_coord>14 && x_coord<20 && y_coord==31) || 
            (x_coord>14 && x_coord<20 && y_coord==37) ||
            (x_coord==17 && y_coord>31 && y_coord<37)
        ) begin
            oled_data <= word_colour;  
        end else if (
            (x_coord==21 && y_coord>30 && y_coord<38) || 
            (x_coord==26 && y_coord>30 && y_coord<38) ||
            (x_coord>21 && x_coord<26 && y_coord== 31+(6/4)*(x_coord-21) && y_coord<38)
        ) begin
            oled_data <= word_colour; 
        end else if (
            (x_coord>27 && x_coord<34 && y_coord==31) || 
            (x_coord>30 && x_coord<34 && y_coord==34) || 
            (x_coord>27 && x_coord<34 && y_coord==37) ||
            (x_coord==28 && y_coord>31 && y_coord<37) || 
            (x_coord==33 && y_coord>34 && y_coord<37)
        ) begin
            oled_data <= word_colour;  
        end else if (
            (x_coord==35 && y_coord>30 && y_coord<37) || 
            (x_coord>35 && x_coord<41 && y_coord==37)
        ) begin
            oled_data <= word_colour; 
        end else if (
            (x_coord==42 && y_coord>30 && y_coord<38) || 
            (x_coord>42 && x_coord<48 && y_coord==31) ||
            (x_coord>42 && x_coord<48 && y_coord==34) ||
            (x_coord>42 && x_coord<48 && y_coord==37)
        ) begin
            oled_data <= word_colour;
        //////////////////////////////////////////
        /////// Create the 'Player'///////////////
        ////////////////////////////////////////// 
        end else if (
            (x_coord==49 && y_coord>30 && y_coord<38) || 
            (x_coord>49 && x_coord<56 && y_coord==31) ||
             (x_coord>49 && x_coord<56 && y_coord==34) ||
            (x_coord==55 && y_coord>31 && y_coord<34)
        ) begin
            oled_data <= word_colour;    
        end else if (
            (x_coord==57 && y_coord>30 && y_coord<38) ||
            (x_coord>57 && x_coord<63 && y_coord==37)
        ) begin
            oled_data <= word_colour; 
        end else if (
            (x_coord==64 && y_coord>30 && y_coord<38) ||
            (x_coord==69 && y_coord>30 && y_coord<38) ||
            (x_coord>64 && x_coord<69 && y_coord==31) ||
            (x_coord>64 && x_coord<69 && y_coord==34)
        ) begin
            oled_data <= word_colour; 
        end else if (
            (x_coord>70 && x_coord<75 && y_coord==31+(3/3)*(x_coord-71)) ||
            (x_coord>73 && x_coord<78 && y_coord==34-(3/3)*(x_coord-74)) ||
            (x_coord==74 && y_coord>33 && y_coord<38)
        ) begin
            oled_data <= word_colour;  
        end else if (
            (x_coord==79 && y_coord>30 && y_coord<38) ||
            (x_coord>79 && x_coord<85 && y_coord==31) ||
            (x_coord>79 && x_coord<85 && y_coord==34) ||
            (x_coord>79 && x_coord<85 && y_coord==37)
        ) begin
            oled_data <= word_colour;  
        end else if (
            (x_coord==87 && y_coord>30 && y_coord<38) ||
            (x_coord==92 && y_coord>30 && y_coord<35) ||
            (x_coord>87 && x_coord<92 && y_coord==31) ||
            (x_coord>87 && x_coord<92 && y_coord==34) ||
            (x_coord>87 && x_coord<92 && y_coord==34+(3/3)*(x_coord-88))
        ) begin
            oled_data <= word_colour;
        ////////////////////////////////////////// ////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////// Create the 'Multiplayer' //////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    
        //////////////////////////////////////////
        /////// Create the 'Multi'///////////////
        //// Height is 46 to 52 //////////////////
        //////////////////////////////////////////             
        end else if (
            (x_coord==8 && y_coord>45 && y_coord<53) || 
            (x_coord==16 && y_coord>45 && y_coord<53) || 
            (x_coord>8 && x_coord<13 && y_coord==46+(4/4)*(x_coord-8)) ||
            (x_coord>11 && x_coord<16 && y_coord==50-(4/4)*(x_coord-12))
        ) begin
            oled_data <= word_colour;  
        end else if (
            (x_coord==18 && y_coord>45 && y_coord<53) || 
            (x_coord==24 && y_coord>45 && y_coord<53) ||
            (x_coord>18 && x_coord<24 && y_coord==52)
        ) begin
            oled_data <= word_colour; 
        end else if (
            (x_coord>26 && x_coord<33 && y_coord==52) || 
            (x_coord==27 && y_coord>45 && y_coord<52)
        ) begin
            oled_data <= word_colour;  
        end else if (
            (x_coord==37 && y_coord>46 && y_coord<53) || 
            (x_coord>33 && x_coord<41 && y_coord==46)
        ) begin
            oled_data <= word_colour; 
        end else if (
            (x_coord>41 && x_coord<47 && y_coord==46) ||
            (x_coord==44 && y_coord>46 && y_coord<52) ||
            (x_coord>41 && x_coord<47 && y_coord==52)
        ) begin
            oled_data <= word_colour;
        //////////////////////////////////////////
        /////// Create the 'Player'///////////////
        ////////////////////////////////////////// 
        end else if (
            (x_coord==49 && y_coord>45 && y_coord<53) || 
            (x_coord>49 && x_coord<56 && y_coord==46) ||
             (x_coord>49 && x_coord<56 && y_coord==49) ||
            (x_coord==55 && y_coord>46 && y_coord<49)
        ) begin
            oled_data <= word_colour;    
        end else if (
            (x_coord==57 && y_coord>45 && y_coord<53) ||
            (x_coord>57 && x_coord<63 && y_coord==52)
        ) begin
            oled_data <= word_colour; 
        end else if (
            (x_coord==64 && y_coord>45 && y_coord<53) ||
            (x_coord==69 && y_coord>45 && y_coord<53) ||
            (x_coord>64 && x_coord<69 && y_coord==46) ||
            (x_coord>64 && x_coord<69 && y_coord==49)
        ) begin
            oled_data <= word_colour; 
        end else if (
            (x_coord>70 && x_coord<75 && y_coord==46+(3/3)*(x_coord-71)) ||
            (x_coord>73 && x_coord<78 && y_coord==49-(3/3)*(x_coord-74)) ||
            (x_coord==74 && y_coord>48 && y_coord<53)
        ) begin
            oled_data <= word_colour;  
        end else if (
            (x_coord==79 && y_coord>45 && y_coord<53) ||
            (x_coord>79 && x_coord<85 && y_coord==46) ||
            (x_coord>79 && x_coord<85 && y_coord==49) ||
            (x_coord>79 && x_coord<85 && y_coord==52)
        ) begin
            oled_data <= word_colour;  
        end else if (
            (x_coord==87 && y_coord>45 && y_coord<53) ||
            (x_coord==92 && y_coord>45 && y_coord<50) ||
            (x_coord>87 && x_coord<92 && y_coord==46) ||
            (x_coord>87 && x_coord<92 && y_coord==49) ||
            (x_coord>87 && x_coord<92 && y_coord==49+(3/3)*(x_coord-88))
        ) begin
            oled_data <= word_colour;
        //////////////////////////////////////////
        ////// Creates the select icon ///////////
        ///////////////////////////////////////// 
        end else if (select_icon==0 && ((x_coord>3 && x_coord<7 && y_coord>31+(3/3)*(x_coord-3) && y_coord<37-(3/3)*(x_coord-3)))
        ) begin
            oled_data <= word_colour;
        end else if (select_icon==1 && ((x_coord>3 && x_coord<7 && y_coord>46+(3/3)*(x_coord-3) && y_coord<52-(3/3)*(x_coord-3)))
        ) begin
            oled_data <= word_colour;                        
        //////////////////////////////////////////
        /////// Deals with the rest //////////////
        //////////////////////////////////////////                                                           
        end else begin          
            oled_data <= 16'b00000_000000_00000;          
        end
        
        // Control the 'Select mode' icon
        if (btnU==1) begin
            select_icon <= 0;
        end 
        if (btnD==1) begin
            select_icon <= 1;
        end 
        if (btnC==1 && select_icon==0) begin
            start_game <= 1;
        end else if (btnC==1 && select_icon==1) begin
            start_game <= 2;
        end
    end
endmodule
