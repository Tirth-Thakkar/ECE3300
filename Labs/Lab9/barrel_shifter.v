lab 8:

module barrel_shifter#(
    parameter WIDTH = 8
)(
    input  wire [WIDTH-1:0] data_in,
    input  wire [2:0]       shift_amt, // rotate amount 0..7
    output wire [WIDTH-1:0] data_out
);
    assign data_out = (data_in << shift_amt) | (data_in >> (WIDTH - shift_amt));
endmodule


