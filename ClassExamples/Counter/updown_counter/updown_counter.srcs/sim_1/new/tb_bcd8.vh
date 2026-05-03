task run_tb_bcd8;
    integer k;
begin
    $display("\n========================================");
    $display("TEST 3 : 8-DIGIT BCD COUNTER");
    $display("========================================");

    // -------------------------
    // Reset in UP mode
    // -------------------------
    b8_en_in   = 1'b0;
    b8_tick    = 1'b0;
    b8_up_down = 1'b1;
    b8_rst     = 1'b1;
    repeat (2) @(posedge clk);
    b8_rst     = 1'b0;

    $display("Reset UP   -> %0d%0d%0d%0d%0d%0d%0d%0d (expect 00000000)",
             b8_bcd[31:28], b8_bcd[27:24], b8_bcd[23:20], b8_bcd[19:16],
             b8_bcd[15:12], b8_bcd[11:8],  b8_bcd[7:4],   b8_bcd[3:0]);

    // -------------------------
    // Count UP for 12 ticks
    // Should cross 00000009 -> 00000010
    // -------------------------
    b8_en_in   = 1'b1;
    b8_up_down = 1'b1;

    $display("Count UP");
    for (k = 0; k < 12; k = k + 1) begin
        b8_tick = 1'b1;
        @(posedge clk);
        #1;
        $display("T=%0t  %0d%0d%0d%0d%0d%0d%0d%0d  en_out=%b",
                 $time,
                 b8_bcd[31:28], b8_bcd[27:24], b8_bcd[23:20], b8_bcd[19:16],
                 b8_bcd[15:12], b8_bcd[11:8],  b8_bcd[7:4],   b8_bcd[3:0],
                 b8_en_out);
        b8_tick = 1'b0;
        @(posedge clk);
    end

    // -------------------------
    // Reset in DOWN mode
    // -------------------------
    b8_en_in   = 1'b0;
    b8_tick    = 1'b0;
    b8_up_down = 1'b0;
    b8_rst     = 1'b1;
    repeat (2) @(posedge clk);
    b8_rst     = 1'b0;

    $display("Reset DOWN -> %0d%0d%0d%0d%0d%0d%0d%0d (expect 99999999)",
             b8_bcd[31:28], b8_bcd[27:24], b8_bcd[23:20], b8_bcd[19:16],
             b8_bcd[15:12], b8_bcd[11:8],  b8_bcd[7:4],   b8_bcd[3:0]);

    // -------------------------
    // Count DOWN for 12 ticks
    // Should cross 99999990 -> 99999989
    // -------------------------
    b8_en_in   = 1'b1;
    b8_up_down = 1'b0;

    $display("Count DOWN");
    for (k = 0; k < 12; k = k + 1) begin
        b8_tick = 1'b1;
        @(posedge clk);
        #1;
        $display("T=%0t  %0d%0d%0d%0d%0d%0d%0d%0d  en_out=%b",
                 $time,
                 b8_bcd[31:28], b8_bcd[27:24], b8_bcd[23:20], b8_bcd[19:16],
                 b8_bcd[15:12], b8_bcd[11:8],  b8_bcd[7:4],   b8_bcd[3:0],
                 b8_en_out);
        b8_tick = 1'b0;
        @(posedge clk);
    end

    // -------------------------
    // Disable test
    // -------------------------
    $display("Disable test");
    b8_en_in = 1'b0;
    b8_tick  = 1'b1;
    @(posedge clk);
    #1;
    $display("T=%0t  disabled -> %0d%0d%0d%0d%0d%0d%0d%0d  en_out=%b",
             $time,
             b8_bcd[31:28], b8_bcd[27:24], b8_bcd[23:20], b8_bcd[19:16],
             b8_bcd[15:12], b8_bcd[11:8],  b8_bcd[7:4],   b8_bcd[3:0],
             b8_en_out);
    b8_tick = 1'b0;

    $display("Finished TEST 3");
end
endtask