`timescale 1ns / 1ps

// Rotates Data In
module BarrelShifter #(parameter int BIT_WIDTH = 8, parameter int BIT_CTL = $clog2(BIT_WIDTH)) (
        input [BIT_WIDTH-1:0] data_in,
        input [BIT_CTL-1:0] bit_control, // Number of positions to shift
        output [BIT_WIDTH-1:0] data_out
    );

    wire [(2*BIT_WIDTH)-1:0] doubled_data;

    assign doubled_data = {data_in, data_in};
    assign data_out = doubled_data[bit_control +: BIT_WIDTH];

endmodule
