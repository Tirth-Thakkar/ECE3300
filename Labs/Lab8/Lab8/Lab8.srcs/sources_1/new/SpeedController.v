`timescale 1ns / 1ps
module SpeedController #(
    parameter CNTRL_WIDTH = 32,
    parameter SEL_WIDTH = $clog2(CNTRL_WIDTH)
    )(
        input clk,
        input rst,
        input [SEL_WIDTH-1:0] speed_setting, // 5-bit input for speed setting (0-31)
        output cntrl_speed // Derived clock output (one selected bit of a 32-bit counter)
    );

        // 32-bit up-counter (runs continuously) used to generate a variable-rate clock
        wire [CNTRL_WIDTH-1:0] counter_out;
        UpDownCounter #(.COUNT_WIDTH(CNTRL_WIDTH)) counter (
            .clk(clk),
            .rst(rst),
            .up_down(1'b1), // Always count up
            .enable(1'b1), // Always enabled
            .count(counter_out)
        );

        // 32x1 mux selects one bit of the counter according to speed_setting
        Mux #(.WIDTH(CNTRL_WIDTH), .BIT_WIDTH(1)) mux32x1_1 (
            .vals(counter_out),
            .sel(speed_setting),
            .out(cntrl_speed)
        );

endmodule
