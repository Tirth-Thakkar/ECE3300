`timescale 1ns / 1ps

module BCDDigitIncrement (
    input [3:0] digit_in,
    input carry_in,
    output [3:0] digit_out,
    output carry_out
);
    wire increment_lsb;
    wire increment_mid0;
    wire increment_mid1;
    wire increment_msb;

    // The surrounding BCD counter resets to zero and only advances through
    // valid decimal states, so 4'hA-4'hF are treated as don't-cares here.
    assign carry_out = carry_in & digit_in[3] & digit_in[0]; // Carry only when on 1001 (9)

    assign increment_lsb = carry_in;
    assign increment_mid0 = carry_in & digit_in[0] & ~digit_in[3];
    assign increment_mid1 = carry_in & digit_in[1] & digit_in[0];
    assign increment_msb = carry_in & digit_in[0] & (digit_in[3] | (digit_in[2] & digit_in[1]));

    assign digit_out[0] = digit_in[0] ^ increment_lsb;
    assign digit_out[1] = digit_in[1] ^ increment_mid0;
    assign digit_out[2] = digit_in[2] ^ increment_mid1;
    assign digit_out[3] = digit_in[3] ^ increment_msb;
endmodule
