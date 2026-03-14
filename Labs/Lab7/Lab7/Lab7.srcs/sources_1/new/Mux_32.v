#(parameter WIDTH = 32)
module Mux_32(
    input [WIDTH-1:0] vals,
    input [$clog2(WIDTH)-1:0] sel,
    output out,
)

    assign out = vals[sel];

endmodule