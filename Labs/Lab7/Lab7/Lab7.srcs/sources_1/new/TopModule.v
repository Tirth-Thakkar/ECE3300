
`timescale 1ns / 1ps
module TopModule #(
    parameter SYS_WIDTH = 32, 
    parameter CNT_WIDTH = 4,
    parameter SYS_CTRL_WIDTH = $clog2(SYS_WIDTH)
    )(
        input clk,
        input sys_rst, // BTNC
        input sys_toggle, // 0 = counter output, 1 = user input
        input cntr_rst, // BTNU
        input cntr_enable,
        input cntr_up_down, // 1 for up, 0 for down
        input [SYS_CTRL_WIDTH-1:0] speed_setting, // 5-bit input for speed setting (0-31)
        input [3:0] usr_input,

        output [6:0] seg, // Output for 7-segment display
        output [7:0] anodes
    );

    // Instantiate the SpeedController
    // It outputs a single-bit derived clock (slower/faster based on speed_setting)
    wire adder_clk;
    SpeedController #(.CNTRL_WIDTH(SYS_WIDTH)) speed_controller (
        .clk(clk),
        .rst(sys_rst),
        .speed_setting(speed_setting),
        .cntrl_speed(adder_clk) // Derived clock output
    );

    wire [CNT_WIDTH-1:0] counter_output;
    UpDownCounter #(.COUNT_WIDTH(CNT_WIDTH)) counter (
        .clk(adder_clk), // Use the control speed as the clock input
        .rst(cntr_rst || sys_rst), // Counter Reset or system reset
        .up_down(cntr_up_down),
        .enable(cntr_enable),
        .count(counter_output)
    );

    wire [3:0] dsp_out;
    // sys_toggle: 0 = show counter output, 1 = show user input
    Mux #(.WIDTH(2), .BIT_WIDTH(4)) mux2x1_4 (
        .vals({usr_input, counter_output}),
        .sel(sys_toggle),
        .out(dsp_out) 
    );
    
    SevenSegDecoder seven_seg_decoder (
        .val(dsp_out), // Connect the mux output to the decoder input
        .anodes(anodes), // Pass all anodes so the decoder can blank segments when no digit is enabled
        .seg(seg) 
    );

    // Drive the 7-segment anode for a single-digit display (active-low enable)
    assign anodes[0] = 1'b0;
    assign anodes[7:1] = 7'b1111111; // Disable other digits if present

endmodule