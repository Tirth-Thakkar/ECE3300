`timescale 1ns / 1ps

module LFSR #(
    parameter WIDTH = 16,
    parameter TAP0 = 0,
    parameter TAP1 = 3,
    parameter TAP2 = 9,
    parameter TAP3 = 14
    )(
        input clk,
        input rst,
        input enable,
        input load,
        input [WIDTH-1:0] seed,
        output [WIDTH-1:0] state
    );

        reg [WIDTH-1:0] state_tmp;
        wire feedback;
        wire [WIDTH-1:0] next_state;

        assign feedback = state_tmp[TAP0] ^ state_tmp[TAP1] ^ state_tmp[TAP2] ^ state_tmp[TAP3];
        assign next_state = {feedback, state_tmp[WIDTH-1:1]};

        always @(posedge clk or posedge rst) begin
            if (rst) begin
                state_tmp <= {WIDTH{1'b0}};
            end else if (load) begin
                state_tmp <= seed;
            end else if (enable) begin
                state_tmp <= next_state;
            end
        end

        assign state = state_tmp;

endmodule