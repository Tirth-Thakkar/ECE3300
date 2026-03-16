`timescale 1ns / 1ps
module Mux #(
    parameter WIDTH = 32,
    parameter BIT_WIDTH = 1, 
    parameter SEL_WIDTH = (WIDTH > 1) ? $clog2(WIDTH) : 1 // Width of the select signal (handles WIDTH == 1)
)(
    input  [WIDTH*BIT_WIDTH-1:0] vals, // Packed input words: [WIDTH*BIT_WIDTH-1:0]
    input  [SEL_WIDTH-1:0] sel, // Selects which word to pass through
    output [BIT_WIDTH-1:0] out // Selected word output
);

    // Use a variable part-select to choose the correct word.
    // `sel*BIT_WIDTH` selects the starting bit of the chosen word.
    assign out = vals[sel*BIT_WIDTH +: BIT_WIDTH];

endmodule