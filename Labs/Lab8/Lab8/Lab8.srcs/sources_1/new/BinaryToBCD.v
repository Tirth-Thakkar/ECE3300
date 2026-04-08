`timescale 1ns / 1ps

module BinaryToBCD #(
    parameter BIN_WIDTH = 16,
    parameter BCD_DIGITS = 5
    )(
        input [BIN_WIDTH-1:0] bin,
        output [BCD_DIGITS*4-1:0] bcd
    );

    integer i, j;
    reg [BIN_WIDTH + (BCD_DIGITS*4) - 1:0] shift_reg;

    always @(*) begin
        shift_reg = { {(BCD_DIGITS*4){1'b0}}, bin };

        for (i = 0; i < BIN_WIDTH; i = i + 1) begin
            for (j = 0; j < BCD_DIGITS; j = j + 1) begin
                if (shift_reg[BIN_WIDTH + j*4 +: 4] >= 4'd5) begin
                    shift_reg[BIN_WIDTH + j*4 +: 4] = shift_reg[BIN_WIDTH + j*4 +: 4] + 4'd3;
                end
            end
            shift_reg = shift_reg << 1;
        end
    end

    assign bcd = shift_reg[BIN_WIDTH + (BCD_DIGITS*4) - 1 : BIN_WIDTH];

endmodule