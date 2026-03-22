`timescale 1ns / 1ps

module TopModule_tb();

    reg clk_tb;
    reg rst_tb;
    reg sys_toggle_tb;
    reg cntr_rst_tb;
    reg cntr_enable_tb;
    reg up_down_tb;
    reg [4:0] speed_setting_tb;
    reg [3:0] usr_input_tb;
    wire [6:0] seg_tb;
    wire [7:0] anodes_tb;

    TopModule uut (
        .clk(clk_tb),
        .sys_rst(rst_tb),
        .sys_toggle(sys_toggle_tb),
        .cntr_rst(cntr_rst_tb),
        .cntr_enable(cntr_enable_tb),
        .cntr_up_down(up_down_tb),
        .speed_setting(speed_setting_tb),
        .usr_input(usr_input_tb),
        .seg(seg_tb),
        .anodes(anodes_tb)
    );

    // Clock generation
    initial begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb;
    end

    // Monitor key signals each clock
    always @(posedge clk_tb) begin
        $display(
            "%0t | r=%b t=%b c_rst=%b c_en=%b u_d=%b spd=%02d usr=%02d | seg=%b an=%b",
            $time,
                rst_tb,
                sys_toggle_tb,
                cntr_rst_tb,
                cntr_enable_tb,
                up_down_tb,
                speed_setting_tb,
                usr_input_tb,
                seg_tb,
                anodes_tb
        );
    end

    initial begin
        // Initial values
        rst_tb = 1;
        cntr_rst_tb = 1;
        cntr_enable_tb = 0; // start disabled to test enable behavior
        sys_toggle_tb = 0; // 0 = show counter output, 1 = show user input
        up_down_tb = 1;
        speed_setting_tb = 0;
        usr_input_tb = 0;

        // Hold reset for a few clock cycles
        repeat (10) @(posedge clk_tb);
        rst_tb = 0;
        cntr_rst_tb = 0;

        // Enable counter and run in up mode at multiple speeds
        cntr_enable_tb = 1;
        $display("=== TEST: Counter counting UP at different speeds ===");
        for (integer s = 0; s < 4; s = s + 1) begin
            speed_setting_tb = s;
            $display("  speed_setting=%0d", speed_setting_tb);
            // Give more cycles for slower speed settings (longer divide-by).
            repeat (100 * (s + 1)) @(posedge clk_tb);
        end

        // Test counter reset behavior
        $display("=== TEST: Counter reset assertion ===");
        cntr_rst_tb = 1;
        repeat (5) @(posedge clk_tb);
        cntr_rst_tb = 0;
        repeat (20) @(posedge clk_tb);

        // Verify user input display works
        sys_toggle_tb = 1;    // show user input on display
        cntr_enable_tb = 0;  // disable counter during user-input test
        $display("=== TEST: User input display ===");
        for (integer u = 0; u < 16; u = u + 1) begin
            usr_input_tb = u;
            repeat (5) @(posedge clk_tb);
        end

        // Count down
        sys_toggle_tb = 0;
        cntr_enable_tb = 1;
        up_down_tb = 0;
        speed_setting_tb = 2;
        $display("=== TEST: Counter counting DOWN ===");
        // Run longer to let down count cycle through several values
        repeat (500) @(posedge clk_tb);
        $finish;
    end

endmodule
