task run_tb_speed;
    integer k;
begin
    $display("\n========================================");
    $display("TEST 1 : SPEED CONTROLLER");
    $display("========================================");

    sc_rst = 1'b1;
    sc_en  = 1'b0;
    sc_sel = 5'd0;
    repeat (4) @(posedge clk);

    sc_rst = 1'b0;
    sc_en  = 1'b1;

    $display("Speed test A: sel=0 (fastest visible toggle)");
    sc_sel = 5'd0;
    for (k = 0; k < 16; k = k + 1) begin
        @(posedge clk);
        $display("T=%0t  sel=%0d  clk_speed=%b", $time, sc_sel, sc_clk_speed);
    end

    $display("Speed test B: sel=3");
    sc_sel = 5'd3;
    for (k = 0; k < 24; k = k + 1) begin
        @(posedge clk);
        $display("T=%0t  sel=%0d  clk_speed=%b", $time, sc_sel, sc_clk_speed);
    end

    $display("Speed test C: sel=5");
    sc_sel = 5'd5;
    for (k = 0; k < 40; k = k + 1) begin
        @(posedge clk);
        $display("T=%0t  sel=%0d  clk_speed=%b", $time, sc_sel, sc_clk_speed);
    end

    $display("Speed test D: disable counter");
    sc_en = 1'b0;
    for (k = 0; k < 8; k = k + 1) begin
        @(posedge clk);
        $display("T=%0t  sel=%0d  clk_speed=%b", $time, sc_sel, sc_clk_speed);
    end

    sc_en = 1'b1;
    $display("Finished TEST 1");
end
endtask