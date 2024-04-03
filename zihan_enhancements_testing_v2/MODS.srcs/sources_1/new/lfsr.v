`timescale 1ns / 1ps

module lfsr(
    input wire clk1k,       // Clock input
    input wire reset,
    output reg [2:0] out  // 3-bit output, 1-7
);

// Intermediate signal for feedback bit
wire feedback;

assign feedback = out[2] ^ out[1]; // XOR the tap bits for feedback

always @(posedge clk1k or posedge reset) begin
    if (reset) begin
        out <= 3'b000; // Non-zero initial value
    end else begin
        out <= {out[1:0], feedback}; // Shift left and insert feedback
    end
end

endmodule
