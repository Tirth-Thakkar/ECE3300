module TopModule (
    input [3:0] in,
    output [6:0] seg,
    output [7:0] anodes
);
    SevenSegDecoder decoder (
        .val(in),
        .seg(seg),
        .anodes(anodes)
    );

    assign anodes[0] = 1'b0; // Enable the first digit (active-low)
    assign anodes[7:1] = 7'b1111111; // Disable other digits


endmodule
