`timescale 1ns / 1ps

module AI_Module(
    input [7:0] xpos,
    input [7:0] ypos,
    input [6:0] current_angle,
    input [7:0] xpos_opp,
    input [7:0] ypos_opp,
    input state,
    input clk1k,
    input [5:0] gravity,
    output reg left = 0,
    output reg right = 0,
    output reg up = 0,
    output reg down = 0,
//    output reg [6:0] target_angle,
    output reg fire = 0,
    output reg done = 0
    );
    
    reg [15:0] arcos [99:0];
        
    initial begin
<<<<<<< Updated upstream
        $readmemh("arco_lut.mem",arcos);
    end 
        
    reg [2:0] random;
=======
        $readmemb("arcos_lut.mem",arcos);
    end 
        
    reg [2:0] random_gg;
>>>>>>> Stashed changes
    
    reg stage = 0;
    
    wire [7:0] dist_to_opp;
    
    //diff in dist
    assign dist_to_opp = xpos - xpos_opp;
    
    //randomizer
<<<<<<< Updated upstream
    lfsr lfsr_3bit(.clk1k(clk1k), .reset(state), .out(random));
    
    integer pre_arcos;
    
    reg direction;
    reg [7:0] dist_travel = 0;;
=======
    //lfsr lfsr_3bit(.clk1k(clk1k), .reset(state), .out(random_gg));
    
    integer pre_arcos;
    
    reg [2:0] direction;
    reg [7:0] dist_travel = 0;
>>>>>>> Stashed changes
    reg [6:0] target_angle = 0;
    reg [6:0] angle_travel = 0;
    reg angle_dir;
    // assume power is 110
    // let trig_data be the arcos lookup table
    always @ (posedge clk1k) begin
        
        // if AI in play, state == 1
        random_gg = $urandom % 8;
        if (state) begin
            if (stage == 0) begin
                //calculate movement
<<<<<<< Updated upstream
                direction = random % 2;
                dist_travel = random * 250;
=======
                direction <= random_gg % 2;
                dist_travel <= random_gg * 100;
>>>>>>> Stashed changes
                stage = 1;
            end
            if (stage == 1) begin
                //actual movements
                //move to left
                if (direction < 3) begin
                    left <= 1;
                    dist_travel <= dist_travel - 1;
                end
                //move to right
                else begin
                    right <= 1;
                    dist_travel <= dist_travel - 1;
                end
                
                if (dist_travel <= 0) begin
                    left <= 0;
                    right <= 0;
                    stage <= 2;
                end
            end
            if (stage == 2) begin
                //calculate firing arcs
<<<<<<< Updated upstream
                pre_arcos = (100 * (gravity * dist_to_opp)/(110*110));
                target_angle = 45 + arcos[pre_arcos];
=======
                pre_arcos <= $floor(100 * (gravity * dist_to_opp)/(target_power*target_power));
                target_angle <= 45 + arcos[pre_arcos];
>>>>>>> Stashed changes
                if (current_angle <= target_angle) begin
                //move up
                    angle_dir <= 0;
                    angle_travel <= target_angle - current_angle;
                end
                else begin
                //move down
                    angle_dir <= 1;
                    angle_travel <= current_angle - target_angle;
                end
                stage <= 3;
            end
            if (stage == 3) begin
                //move cannon according to calculation
                if (angle_dir) begin
                    down <= 1;
                    angle_travel <= angle_travel - 1;
                end
                //move to right
                else begin
                    up <= 1;
                    angle_travel <= angle_travel - 1;
                end
                
                if (angle_travel <= 0) begin
                    up <= 0;
                    down <= 0;
                    stage <= 4;
                end
            end
            if (stage == 4) begin
<<<<<<< Updated upstream
            //fire
                fire = 1;
                done = 1;
                stage = 0;
=======
                //firing
                if (current_power != target_power) centre = 1;
                else begin
                    centre <= 0;
                    stage <= 0;
                end
>>>>>>> Stashed changes
            end
        end
        
    end
    
    
endmodule
