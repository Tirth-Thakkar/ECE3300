task run_tb_bcd1;
    integer k;
begin
    $display("\n========================================");
    $display("TEST 2 : SINGLE BCD COUNTER");
    $display("========================================");

    // -------------------------
    // Reset in UP mode
    // -------------------------
    b1_en_in   = 1'b0;
    b1_tick    = 1'b0;
    b1_up_down = 1'b1;
    b1_rst     = 1'b1;
    repeat (2) @(posedge clk);
    b1_rst     = 1'b0;

    $display("Reset UP  -> bcd=%0d (expect 0)", b1_bcd);

    // -------------------------
    // Count UP for 12 ticks
    // -------------------------
    b1_en_in   = 1'b1;
    b1_up_down = 1'b1;

    $display("Count UP");
    for (k = 0; k < 12; k = k + 1) begin
        b1_tick = 1'b1;
        @(posedge clk);
        #1;
        $display("T=%0t  up_down=%b  bcd=%0d  en_out=%b", $time, b1_up_down, b1_bcd, b1_en_out);

        b1_tick = 1'b0;
        @(posedge clk);
    end

    // -------------------------
    // Reset in DOWN mode
    // -------------------------
    b1_en_in   = 1'b0;
    b1_tick    = 1'b0;
    b1_up_down = 1'b0;
    b1_rst     = 1'b1;
    repeat (2) @(posedge clk);
    b1_rst     = 1'b0;

    $display("Reset DOWN -> bcd=%0d (expect 9)", b1_bcd);

    // -------------------------
    // Count DOWN for 12 ticks
    // -------------------------
    b1_en_in   = 1'b1;
    b1_up_down = 1'b0;

    $display("Count DOWN");
    for (k = 0; k < 12; k = k + 1) begin
        b1_tick = 1'b1;
        @(posedge clk);
        #1;
        $display("T=%0t  up_down=%b  bcd=%0d  en_out=%b", $time, b1_up_down, b1_bcd, b1_en_out);

        b1_tick = 1'b0;
        @(posedge clk);
    end

    // -------------------------
    // Disable test
    // -------------------------
    $display("Disable test");
    b1_en_in   = 1'b0;
    b1_tick    = 1'b1;
    @(posedge clk);
    #1;
    $display("T=%0t  disabled  bcd=%0d  en_out=%b", $time, b1_bcd, b1_en_out);
    b1_tick    = 1'b0;

    $display("Finished TEST 2");
end
endtask