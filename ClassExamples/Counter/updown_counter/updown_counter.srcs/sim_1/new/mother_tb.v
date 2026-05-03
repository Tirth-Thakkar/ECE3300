`timescale 1ns/1ps

module mother_tb;

    // ----------------------------------------
    // Common clock
    // ----------------------------------------
    reg clk;

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // ----------------------------------------
    // DUT #1 : speed_controller
    // ----------------------------------------
    reg        sc_rst;
    reg        sc_en;
    reg  [4:0] sc_sel;
    wire       sc_clk_speed;

    speed_controller u_speed_controller (
        .clk       (clk),
        .rst       (sc_rst),
        .en        (sc_en),
        .sel       (sc_sel),
        .clk_speed (sc_clk_speed)
    );

    // ----------------------------------------
    // DUT #2 : single bcd_counter
    // ----------------------------------------
    reg        b1_rst;
    reg        b1_en_in;
    reg        b1_tick;
    reg        b1_up_down;
    wire [3:0] b1_bcd;
    wire       b1_en_out;

    bcd_counter u_bcd_counter (
        .clk     (clk),
        .rst     (b1_rst),
        .en_in   (b1_en_in),
        .tick    (b1_tick),
        .up_down (b1_up_down),
        .bcd     (b1_bcd),
        .en_out  (b1_en_out)
    );

    // ----------------------------------------
    // DUT #3 : 8-digit bcd_counter
    // ----------------------------------------
    reg         b8_rst;
    reg         b8_en_in;
    reg         b8_tick;
    reg         b8_up_down;
    wire [31:0] b8_bcd;
    wire        b8_en_out;

    bcd_counter_8digit u_bcd_counter_8digit (
        .clk     (clk),
        .rst     (b8_rst),
        .en_in   (b8_en_in),
        .tick    (b8_tick),
        .up_down (b8_up_down),
        .bcd     (b8_bcd),
        .en_out  (b8_en_out)
    );

    // ----------------------------------------
    // DUT #4 : top
    // ----------------------------------------
    reg         top_rst;
    reg         top_enable;
    reg         top_up_down;
    reg  [4:0]  top_sel;
    wire [31:0] top_bcd;
    wire        top_clk_speed;
    wire        top_en_out;

    top u_top (
        .clk       (clk),
        .rst       (top_rst),
        .enable    (top_enable),
        .up_down   (top_up_down),
        .sel       (top_sel),
        .bcd       (top_bcd),
        .clk_speed (top_clk_speed),
        .en_out    (top_en_out)
    );

    // ----------------------------------------
    // Include subtests
    // ----------------------------------------
    `include "tb_speed.vh"
    `include "tb_bcd1.vh"
    `include "tb_bcd8.vh"
    `include "tb_top.vh"

    // ----------------------------------------
    // Optional waveform dump
    // ----------------------------------------
    initial begin
        $dumpfile("mother_tb.vcd");
        $dumpvars(0, mother_tb);
    end

    // ----------------------------------------
    // Initialization
    // ----------------------------------------
    initial begin
        sc_rst      = 1'b0;
        sc_en       = 1'b0;
        sc_sel      = 5'd0;

        b1_rst      = 1'b0;
        b1_en_in    = 1'b0;
        b1_tick     = 1'b0;
        b1_up_down  = 1'b1;

        b8_rst      = 1'b0;
        b8_en_in    = 1'b0;
        b8_tick     = 1'b0;
        b8_up_down  = 1'b1;

        top_rst     = 1'b0;
        top_enable  = 1'b0;
        top_up_down = 1'b1;
        top_sel     = 5'd0;
    end

    // ----------------------------------------
    // Run all tests
    // ----------------------------------------
    initial begin
        repeat (2) @(posedge clk);

        run_tb_speed;
        repeat (4) @(posedge clk);

        run_tb_bcd1;
        repeat (4) @(posedge clk);

        run_tb_bcd8;
        repeat (4) @(posedge clk);

        run_tb_top;
        repeat (10) @(posedge clk);

        $display("\n========================================");
        $display("ALL TESTS FINISHED");
        $display("========================================");
        $finish;
    end

endmodule