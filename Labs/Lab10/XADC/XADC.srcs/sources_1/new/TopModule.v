module TopModule #(
        parameter integer NUM_DIGITS = 4,
        parameter integer REFRESH_LSB = 13,
        parameter integer TIMEBASE_WIDTH = 32
    ) (
        input wire clk,
        input wire reset_in,

        input wire vp_in,
        input wire vn_in,

        output wire eoc_out,
        output wire eos_out,
        output wire alarm_out,
        output wire busy_out,
        output wire [4:0] channel_out,

        output reg [11:0] adc_value,
        output reg [15:0] milivolt_value,

        output wire [6:0] seg,
        output wire [7:0] anodes
    );

    wire dready_out;
    wire [15:0] do_out;
    reg [6:0] daddr_in = 7'h03;

    xadc_wiz_0 XADC (
        .di_in(),                  // input wire [15 : 0] di_in
        .daddr_in(daddr_in),       // input wire [6 : 0] daddr_in
        .den_in(eoc_out),          // input wire den_in
        .dwe_in(),                 // input wire dwe_in
        .drdy_out(dready_out),     // output wire drdy_out
        .do_out(do_out),           // output wire [15 : 0] do_out
        .dclk_in(clk),             // input wire dclk_in
        .reset_in(reset_in),       // input wire reset_in
        .vp_in(vp_in),             // input wire vp_in
        .vn_in(vn_in),             // input wire vn_in
        .user_temp_alarm_out(),    // output wire user_temp_alarm_out
        .vccint_alarm_out(),       // output wire vccint_alarm_out
        .vccaux_alarm_out(),       // output wire vccaux_alarm_out
        .ot_out(),                 // output wire ot_out
        .channel_out(channel_out), // output wire [4 : 0] channel_out
        .eoc_out(eoc_out),         // output wire eoc_out
        .alarm_out(alarm_out),     // output wire alarm_out
        .eos_out(eos_out),         // output wire eos_out
        .busy_out(busy_out)        // output wire busy_out
    );

    localparam integer ScaleFactor = 16'd3300; // 3.3V in millivolts
    localparam integer ADCResolution = 16'd4095; // 1V ADC Input
    always @(posedge clk) begin: proc_voltage_scaling
        if (reset_in) begin
            adc_value <= 12'b0;
            milivolt_value <= 16'b0;
        end else if (dready_out) begin
            adc_value <= do_out[15:4]; // Overflow projection for 12 bit val
            milivolt_value <= ((do_out[15:4] * ScaleFactor) / ADCResolution);
        end
    end

    reg [15:0] voltage_dig;
    BinaryDecimalConv #(.WIDTH(16)) bin_dec_conv (
        .binary_in(milivolt_value),
        .decimal_out(voltage_dig)
    );

    wire [3:0] selected_digit;
    wire [3:0] selected_anodes;

    TimeMux #(
        .NUM_DIGITS(NUM_DIGITS),
        .DIGIT_WIDTH(4),
        .REFRESH_LSB(REFRESH_LSB),
        .REFRESH_WIDTH(TIMEBASE_WIDTH)
    ) time_mux (
        .clk(clk),
        .reset(reset_in),
        .vals(voltage_dig),
        .seg(selected_digit),
        .anodes(selected_anodes)
    );

    SevenSegDecoder #(
        .WIDTH(4),
        .USE_BLANKING(1'b1)
    ) seg_decoder (
        .reset(reset_in),
        .val(selected_digit),
        .anodes(selected_anodes),
        .seg(seg)
    );

    assign anodes = selected_anodes;
    assign dp = 1'b1; // Decimal point always off

endmodule
