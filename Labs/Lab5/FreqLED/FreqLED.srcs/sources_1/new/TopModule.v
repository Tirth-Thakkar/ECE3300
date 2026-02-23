`timescale 1ns / 1ps

module TopModule #(
    parameter WIDTH = 32,
    parameter SELECT = $clog2(WIDTH)*3,
    parameter CHANNEL = WIDTH/3
    ) (
        input sys_clk_pin,
        input reset, 
        input [SELECT-1:0] select,
        output [CHANNEL-1:0] red,
        output [CHANNEL-1:0] green,
        output [CHANNEL-1:0] blue
    );

    wire counter_out;
    Counter #(.WIDTH(WIDTH)) counter_inst (
        .clk(sys_clk_pin),
        .rst_n(reset),
        .count(counter_out)
    );

    MUX #(.width(WIDTH), .sel_width(SELECT/3)) mux1 (
        .in(counter_out),
        .sel(select[(SELECT/3)-1:0]),
        .out(red)
    );

    MUX #(.width(WIDTH), .sel_width(SELECT/3)) mux2 (
        .in(counter_out),
        .sel(select[2*(SELECT/3)-1:(SELECT/3)]),
        .out(green)
    );

    MUX #(.width(WIDTH), .sel_width(SELECT/3)) mux3 (
        .in(counter_out),
        .sel(select[SELECT-1:2*(SELECT/3)]),
        .out(blue)
    );

endmodule
