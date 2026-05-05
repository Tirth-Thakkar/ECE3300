module TopModule #(
        parameter integer NUM_DIGITS = 4,
        parameter integer REFRESH_LSB = 13,
        parameter integer TIMEBASE_WIDTH = 32
    ) (
        input wire clk,
        input wire reset_in, // J15 SW[0]

        input wire vauxp3, // A13, JXADC xa_p[1]
        input wire vauxn3, // A14, JXADC xa_n[1]

        output wire dp,
        output wire [6:0] seg,
        output wire [7:0] anodes
    );

    wire eoc_out;
    wire eos_out;
    wire alarm_out;
    wire busy_out;
    wire dready_out;
    wire [4:0] channel_out;
    wire [15:0] do_out;

    wire [6:0] daddr_in = 7'h13;
    reg [11:0] adc_value;
    reg [15:0] milivolt_value;

    xadc_wiz_0 XADC (
        .di_in(16'h0000),          // input wire [15 : 0] di_in
        .daddr_in(daddr_in),       // input wire [6 : 0] daddr_in
        .den_in(eoc_out),          // input wire den_in
        .dwe_in(1'b0),             // input wire dwe_in
        .drdy_out(dready_out),     // output wire drdy_out
        .do_out(do_out),           // output wire [15 : 0] do_out
        .dclk_in(clk),             // input wire dclk_in
        .reset_in(reset_in),       // input wire reset_in
        .vp_in(1'b0),              // unused dedicated analog input
        .vn_in(1'b0),              // unused dedicated analog input
        .vauxp3(vauxp3),           // input wire vauxp3
        .vauxn3(vauxn3),           // input wire vauxn3
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
    wire [15:0] voltage_dig_temp;
    BinaryDecimalConv #(.WIDTH(16)) bin_dec_conv (
        .binary_in(milivolt_value),
        .decimal_out(voltage_dig_temp)
    );

    always @(posedge clk) begin : proc_voltage_dig
        if (reset_in) begin
            voltage_dig <= 16'b0;
        end else begin
            voltage_dig <= voltage_dig_temp;
        end
    end

    wire [3:0] selected_digit;
    wire [3:0] selected_anodes;
    wire [7:0] display_anodes;

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
        .anodes(display_anodes),
        .seg(seg)
    );

    assign display_anodes = {{(8-NUM_DIGITS){1'b1}}, selected_anodes};
    assign anodes = display_anodes;
    assign dp = 1'b1; // Decimal point always off

endmodule
