`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2026 12:26:51 AM
// Design Name: 
// Module Name: TopModule
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TopModule #(
    parameter SECTIONS = 8,
    parameter WIDTH = 4,
    parameter CTL_WIDTH = $clog2(WIDTH)
    )(
        input clk,
        input cntr_rst,
        input cntr_enable,
        input up_down // 1 for up, 0 for down
    );

    generate
        for (genvar i = 0; i < SECTIONS; i = i + 1) begin : gen_section
            // Create instances of Barrel Shifter, UpDownCounter, and SevenSegDecoder for each section

            UpDownCounter #(.COUNT_WIDTH(WIDTH-1)) counter (
                .clk(clk), // Connect to clock
                .rst(cntr_rst), // Connect to reset
                .up_down(up_down), // Connect to control signal for counting direction
                .enable(cntr_enable), // Connect to enable signal
                .count() // Connect to something if needed
            );

            BarrelShifter #(.BIT_WIDTH(WIDTH-1), .BIT_CTL(CTL_WIDTH-1)) shifter (
                .data_in(), // Example input, can be connected to a counter or other source
                .bit_control(), // Example control, can be connected to a counter or other source
                .data_out() // Connect to something if needed
            );

            SevenSegDecoder #(.WIDTH(WIDTH-1)) decoder (
                .val(), // Connect to the output of the counter or other source
                .anodes(), // Connect to anode control for 7-segment display
                .seg() // Connect to segment outputs for 7-segment display
            );
        end
    endgenerate
endmodule
