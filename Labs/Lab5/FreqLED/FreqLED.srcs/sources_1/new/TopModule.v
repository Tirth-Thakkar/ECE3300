`timescale 1ns / 1ps

module TopModule #(
    parameter WIDTH = 32,
    parameter SELECT = $clog2(WIDTH)*3
    ) (
        input CLK100MHZ,
        input reset, 
        input [SELECT-1:0] select,
        output red,
        output green,
        output blue
    );

    wire [WIDTH-1:0] counter_out;
    Counter #(.WIDTH(WIDTH)) counter_inst (
        .clk(CLK100MHZ),
        .rst_n(reset),
        .count(counter_out)
    );

    // divide the select bus into three equal chunks (one per colour)
    localparam SEL_CHUNK = SELECT/3;

    MUX #(.width(WIDTH), .sel_width(SEL_CHUNK)) mux1 (
        .in(counter_out),
        .sel(select[SEL_CHUNK-1:0]),
        .out(red)
    );

    MUX #(.width(WIDTH), .sel_width(SEL_CHUNK)) mux2 (
        .in(counter_out),
        .sel(select[2*SEL_CHUNK-1:SEL_CHUNK]),
        .out(green)
    );

    MUX #(.width(WIDTH), .sel_width(SEL_CHUNK)) mux3 (
        .in(counter_out),
        .sel(select[SELECT-1:2*SEL_CHUNK]),
        .out(blue)

    );

endmodule
