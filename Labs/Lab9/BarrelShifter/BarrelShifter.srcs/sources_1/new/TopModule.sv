`timescale 1ns / 1ps

module TopModule #(
    parameter int SECTIONS = 8,
    parameter int WIDTH = 4,
    parameter int CTL_WIDTH = $clog2(WIDTH)
    )(
        input clk,
        input cntr_rst,
        input cntr_enable,
        input up_down, // 1 for up, 0 for down
        input [(SECTIONS*CTL_WIDTH)-1:0] bit_control,
        output [7:0] anodes,
        output [6:0] seg

    );

    localparam int ActiveDigits = (SECTIONS > 8) ? 8 : SECTIONS;
    wire [(SECTIONS*7)-1:0] seg_per_section;

    // Active-low anodes: used digits are enabled, remaining digits are off.
    assign anodes = 8'hFF << ActiveDigits;
    assign seg = seg_per_section[6:0];

    generate
        for (genvar i = 0; i < SECTIONS; i = i + 1) begin : gen_section
            // Create instances of Barrel Shifter, UpDownCounter, and SevenSegDecoder for each section

            wire [WIDTH-1:0] count_val;
            wire [WIDTH-1:0] shifted_val;

            UpDownCounter #(.COUNT_WIDTH(WIDTH)) counter (
                .clk(clk),
                .rst(cntr_rst),
                .up_down(up_down),
                .enable(cntr_enable),
                .count(count_val)
            );

            BarrelShifter #(.BIT_WIDTH(WIDTH), .BIT_CTL(CTL_WIDTH)) shifter (
                .data_in(count_val), // Counter output drives the shifter input
                .bit_control(bit_control[i*CTL_WIDTH +: CTL_WIDTH]),
                .data_out(shifted_val)
            );

            SevenSegDecoder #(.WIDTH(WIDTH)) decoder (
                .val(shifted_val),
                .anodes((i < 8) ? ~(8'b00000001 << i) : 8'hFF),
                .seg(seg_per_section[i*7 +: 7])
            );
        end
    endgenerate

endmodule
