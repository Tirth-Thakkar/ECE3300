`timescale 1ns / 1ps

module UpCounter #(
    parameter COUNT_WIDTH = 32,
    parameter [COUNT_WIDTH-1:0] MAX_COUNT = {COUNT_WIDTH{1'b1}},
) (
    input clk,
    input rst,
    input enable,
    input BCD_MODE = 1'b0,  // Off by default set to 1'b1 for BCD
    output [COUNT_WIDTH-1:0] count
);
    reg [COUNT_WIDTH-1:0] count_q;
    localparam BCD_DIGITS = COUNT_WIDTH / 4;
    localparam BCD_REMAINDER = COUNT_WIDTH % 4;
    wire [COUNT_WIDTH-1:0] bcd_next_count;
    wire [BCD_DIGITS:0] bcd_carry_chain;

    assign bcd_carry_chain[0] = 1'b1;

    genvar digit_idx;
    generate
        if (BCD_MODE) begin : gen_bcd_counter
            for (digit_idx = 0; digit_idx < BCD_DIGITS; digit_idx = digit_idx + 1) begin : gen_bcd_digits
                BCDDigitIncrement digit_incrementer (
                    .digit_in (count_q[digit_idx*4+:4]),
                    .carry_in (bcd_carry_chain[digit_idx]),
                    .digit_out(bcd_next_count[digit_idx*4+:4]),
                    .carry_out(bcd_carry_chain[digit_idx+1])
                );
            end

            if (BCD_REMAINDER > 0) begin : gen_bcd_remainder
                assign bcd_next_count[COUNT_WIDTH-1:BCD_DIGITS*4] =
                    count_q[COUNT_WIDTH-1:BCD_DIGITS*4];
            end

            always @(posedge clk or posedge rst) begin
                if (rst) begin
                    count_q <= {COUNT_WIDTH{1'b0}};
                end else if (enable) begin
                    if (bcd_carry_chain[BCD_DIGITS]) begin
                        count_q <= {COUNT_WIDTH{1'b0}};
                    end else begin
                        count_q <= bcd_next_count;
                    end
                end
            end
        end
        
        else begin : gen_binary_counter
            always @(posedge clk or posedge rst) begin
                if (rst) begin
                    count_q <= {COUNT_WIDTH{1'b0}};
                end else if (enable) begin
                    if (count_q == MAX_COUNT) begin
                        count_q <= {COUNT_WIDTH{1'b0}};
                    end else begin
                        count_q <= count_q + 1'b1;
                    end
                end
            end
        end
    endgenerate

    assign count = count_q;
endmodule
