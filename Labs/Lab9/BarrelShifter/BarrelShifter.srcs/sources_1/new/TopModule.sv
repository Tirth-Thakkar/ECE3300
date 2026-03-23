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
        input [(SECTIONS*CTL_WIDTH)-1:0] bit_control
    );

    generate
        for (genvar i = 0; i < SECTIONS; i = i + 1) begin : gen_section
            // Create instances of Barrel Shifter, UpDownCounter, and SevenSegDecoder for each section

            UpDownCounter #(.COUNT_WIDTH(WIDTH-1)) counter (
                .clk(clk), // Connect to clock
                .rst(cntr_rst), // Connect to reset
                .up_down(up_down), // Connect to control signal for counting direction
                .enable(cntr_enable), // Connect to enable signal
                .count()
            );

            BarrelShifter #(.BIT_WIDTH(WIDTH-1), .BIT_CTL(CTL_WIDTH-1)) shifter (
                .data_in(), // Example input, can be connected to a counter or other source
                .bit_control(bit_control[i+2:i]), // Two bits for control each section
                .data_out()
            );

            SevenSegDecoder #(.WIDTH(WIDTH-1)) decoder (
                .val(), // Connect to the output of the counter or other source
                .anodes(), // Connect to anode control for 7-segment display
                .seg() // Connect to segment outputs for 7-segment display
            );
        end
    endgenerate
endmodule
