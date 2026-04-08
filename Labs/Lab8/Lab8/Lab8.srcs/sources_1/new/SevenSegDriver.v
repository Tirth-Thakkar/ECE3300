`timescale 1ns / 1ps

module SevenSegDriver #(
    parameter DIGITS = 8,
    parameter DIGIT_WIDTH = 4,
    parameter REFRESH_WIDTH = 32,
    parameter REFRESH_SEL = 15,
    parameter SCAN_WIDTH = (DIGITS > 1) ? $clog2(DIGITS) : 1
    )(
        input clk,
        input rst,
        input [DIGITS*DIGIT_WIDTH-1:0] vals,
        output [6:0] seg,
        output [DIGITS-1:0] anodes
    );

        wire [REFRESH_WIDTH-1:0] refresh_count;
        wire [SCAN_WIDTH-1:0] scan_sel;
        wire [DIGIT_WIDTH-1:0] digit_val;
        wire [6:0] seg_raw;

        UpDownCounter #(.COUNT_WIDTH(REFRESH_WIDTH)) refresh_counter (
            .clk(clk),
            .rst(rst),
            .up_down(1'b1),
            .enable(1'b1),
            .count(refresh_count)
        );

        assign scan_sel = refresh_count[REFRESH_SEL +: SCAN_WIDTH];

        Mux #(.WIDTH(DIGITS), .BIT_WIDTH(DIGIT_WIDTH)) digit_mux (
            .vals(vals),
            .sel(scan_sel),
            .out(digit_val)
        );

        HexTable hex_table (
            .val(digit_val),
            .seg(seg_raw)
        );

        assign seg = seg_raw;
        assign anodes = ~( {{(DIGITS-1){1'b0}}, 1'b1} << scan_sel );

endmodule