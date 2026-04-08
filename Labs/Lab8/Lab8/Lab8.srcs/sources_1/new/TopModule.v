`timescale 1ns / 1ps

module TopModule #(
    parameter SYS_WIDTH = 32,
    parameter DATA_WIDTH = 16,
    parameter SYS_CTRL_WIDTH = $clog2(SYS_WIDTH)
    )(
        input clk,
        input sys_rst,

        input cntr_rst,
        input cntr_enable,
        input cntr_up_down,

        input hex_decimal_sel,   // 0 = hex, 1 = decimal
        input hex_decimal_mode,  // 0 = counter, 1 = lfsr

        input lfsr_load,

        input [SYS_CTRL_WIDTH-1:0] speed_setting,

        output [6:0] seg,
        output [7:0] anodes
    );

    wire ctrl_clk;
    wire [DATA_WIDTH-1:0] counter_out;
    wire [DATA_WIDTH-1:0] lfsr_out;
    wire speed_tick;

    wire [31:0] hex_vals;
    wire [15:0] dec_src;
    wire [19:0] dec_bcd;
    wire [31:0] dec_vals;
    wire [31:0] display_vals;
    
    SpeedController #(.CNTRL_WIDTH(SYS_WIDTH)) speed_controller (
        .clk(clk),
        .rst(sys_rst),
        .speed_setting(speed_setting),
        .tick(speed_tick)
    );
    
    UpDownCounter #(.COUNT_WIDTH(DATA_WIDTH)) counter (
        .clk(clk),
        .rst(cntr_rst || sys_rst),
        .up_down(cntr_up_down),
        .enable(cntr_enable && speed_tick),
        .count(counter_out)
    );

    LFSR #(.WIDTH(DATA_WIDTH)) lfsr (
        .clk(clk),
        .rst(sys_rst),
        .enable(cntr_enable && speed_tick),
        .load(lfsr_load),
        .seed(16'hACE1),
        .state(lfsr_out)
    );

    assign hex_vals = {counter_out, lfsr_out};
    assign dec_src  = hex_decimal_mode ? lfsr_out : counter_out;
    assign dec_vals = {12'd0, dec_bcd};

    assign display_vals = hex_decimal_sel ? dec_vals : hex_vals;

    BinaryToBCD #(.BIN_WIDTH(16), .BCD_DIGITS(5)) b2b (
        .bin(dec_src),
        .bcd(dec_bcd)
    );

    SevenSegDriver #(
        .DIGITS(8),
        .DIGIT_WIDTH(4),
        .REFRESH_WIDTH(32),
        .REFRESH_SEL(15)
    ) seven_seg_driver (
        .clk(clk),
        .rst(sys_rst),
        .vals(display_vals),
        .seg(seg),
        .anodes(anodes)
    );

endmodule