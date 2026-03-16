
module TopModule #(
    parameter SYS_WIDTH = 32, 
    parameter CNT_WIDTH = 4,
    parameter SYS_CTRL_WIDTH = $clog2(SYS_WIDTH)
    )(
        input clk,
        input sys_rst,
        input sys_toggle, // Down for User Input, Up for Counter Output
        input cntr_rst,
        input cntr_enable,
        input cntr_up_down, // 1 for up, 0 for down
        input [SYS_CTRL_WIDTH-1:0] speed_setting, // 5-bit input for speed setting (0-31)
        input [3:0] usr_input,

        output [6:0] seg, // Output for 7-segment display
        output anode
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
    Mux #(.WIDTH(2), .BIT_WIDTH(4)) mux2x1_4 (
        .vals({counter_output, usr_input}), // Connect the counter output to the mux inputs
        .sel(sys_toggle), // Use the user input as the select signal
        .out(dsp_out) // Connect the mux output to wherever it needs to go (e.g., an output port or another module)
    );
    
    SevenSegDecoder seven_seg_decoder (
        .val(dsp_out), // Connect the mux output to the decoder input
        .anode(anode), 
        .seg(seg) 
    );

endmodule