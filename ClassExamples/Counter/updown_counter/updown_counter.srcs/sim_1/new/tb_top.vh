task run_tb_top;
    integer k;
begin
    $display("\n========================================");
    $display("TEST 4 : TOP INTEGRATION");
    $display("========================================");

    // -------------------------
    // Reset in UP mode
    // -------------------------
    top_enable  = 1'b0;
    top_up_down = 1'b1;
    top_sel     = 5'd0;   // fastest visible speed
    top_rst     = 1'b1;
    repeat (2) @(posedge clk);
    top_rst     = 1'b0;

    $display("TOP Reset UP   -> %0d%0d%0d%0d%0d%0d%0d%0d (expect 00000000)",
             top_bcd[31:28], top_bcd[27:24], top_bcd[23:20], top_bcd[19:16],
             top_bcd[15:12], top_bcd[11:8],  top_bcd[7:4],   top_bcd[3:0]);

    // -------------------------
    // Count UP using integrated speed controller
    // -------------------------
    top_enable  = 1'b1;
    top_up_down = 1'b1;
    top_sel     = 5'd0;

    $display("TOP Count UP, sel=0");
    for (k = 0; k < 40; k = k + 1) begin
        @(posedge clk);
        #1;
        $display("T=%0t  sel=%0d  clk_speed=%b  bcd=%0d%0d%0d%0d%0d%0d%0d%0d  en_out=%b",
                 $time, top_sel, top_clk_speed,
                 top_bcd[31:28], top_bcd[27:24], top_bcd[23:20], top_bcd[19:16],
                 top_bcd[15:12], top_bcd[11:8],  top_bcd[7:4],   top_bcd[3:0],
                 top_en_out);
    end

    // -------------------------
    // Change speed
    // -------------------------
    top_sel = 5'd3;
    $display("TOP Count UP, sel=3");
    for (k = 0; k < 40; k = k + 1) begin
        @(posedge clk);
        #1;
        $display("T=%0t  sel=%0d  clk_speed=%b  bcd=%0d%0d%0d%0d%0d%0d%0d%0d  en_out=%b",
                 $time, top_sel, top_clk_speed,
                 top_bcd[31:28], top_bcd[27:24], top_bcd[23:20], top_bcd[19:16],
                 top_bcd[15:12], top_bcd[11:8],  top_bcd[7:4],   top_bcd[3:0],
                 top_en_out);
    end

    // -------------------------
    // Reset in DOWN mode
    // -------------------------
    top_enable  = 1'b0;
    top_up_down = 1'b0;
    top_sel     = 5'd0;
    top_rst     = 1'b1;
    repeat (2) @(posedge clk);
    top_rst     = 1'b0;

    $display("TOP Reset DOWN -> %0d%0d%0d%0d%0d%0d%0d%0d (expect 99999999)",
             top_bcd[31:28], top_bcd[27:24], top_bcd[23:20], top_bcd[19:16],
             top_bcd[15:12], top_bcd[11:8],  top_bcd[7:4],   top_bcd[3:0]);

    // -------------------------
    // Count DOWN using integrated speed controller
    // -------------------------
    top_enable  = 1'b1;
    top_up_down = 1'b0;
    top_sel     = 5'd0;

    $display("TOP Count DOWN, sel=0");
    for (k = 0; k < 40; k = k + 1) begin
        @(posedge clk);
        #1;
        $display("T=%0t  sel=%0d  clk_speed=%b  bcd=%0d%0d%0d%0d%0d%0d%0d%0d  en_out=%b",
                 $time, top_sel, top_clk_speed,
                 top_bcd[31:28], top_bcd[27:24], top_bcd[23:20], top_bcd[19:16],
                 top_bcd[15:12], top_bcd[11:8],  top_bcd[7:4],   top_bcd[3:0],
                 top_en_out);
    end

    // -------------------------
    // Disable test
    // -------------------------
    top_enable = 1'b0;
    $display("TOP Disable");
    for (k = 0; k < 10; k = k + 1) begin
        @(posedge clk);
        #1;
        $display("T=%0t  disabled  bcd=%0d%0d%0d%0d%0d%0d%0d%0d",
                 $time,
                 top_bcd[31:28], top_bcd[27:24], top_bcd[23:20], top_bcd[19:16],
                 top_bcd[15:12], top_bcd[11:8],  top_bcd[7:4],   top_bcd[3:0]);
    end

    $display("Finished TEST 4");
end
endtask