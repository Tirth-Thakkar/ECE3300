
module Decoder3_8(
    input enable,
    input [2:0] in,
    output [7:0] out
);

// Gate Level Modeling of 3 to 8 Decoder with Enable
// Use for creating final 4 to 16 Decoder

// To force look up table generation to model gate level design (* dont_touch = "true" *) 
wire not_out[2:0];

not (not_out[0], in[0]);
not (not_out[1], in[1]);
not (not_out[2], in[2]);

and (out[0], not_out[2], not_out[1], not_out[0], enable); // m0
and (out[1], not_out[2], not_out[1], in[0], enable); // m1
and (out[2], not_out[2], in[1], not_out[0], enable); // m2
and (out[3], not_out[2], in[1], in[0], enable); // m3
and (out[4], in[2], not_out[1], not_out[0], enable); // m4
and (out[5], in[0], not_out[1], in[2], enable); // m5
and (out[6], in[2], in[1], not_out[0], enable); // m6
and (out[7], in[0], in[1], in[2], enable); // m7

endmodule