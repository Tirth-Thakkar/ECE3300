`timescale 1ns / 10ps
// TODO: Add coverage for speed modes, reset and enable functions, and down counting. 
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
    wire anode_tb;

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
        .anode(anode_tb)
    );

    // Clock generation
    initial begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb;
    end

    // Monitor key signals each clock
    always @(posedge clk_tb) begin
        $display("%0t | rst=%b sys_toggle=%b cntr_rst=%b cntr_en=%b up_down=%b speed=%02d usr=%02d | seg=%b anode=%b",
                 $time, rst_tb, sys_toggle_tb, cntr_rst_tb, cntr_enable_tb,
                 up_down_tb, speed_setting_tb, usr_input_tb,
                 seg_tb, anode_tb);
    end

    initial begin
        // Reset
        rst_tb = 1;
        cntr_rst_tb = 1;
        cntr_enable_tb = 1;
        sys_toggle_tb = 0; // 0 = show counter output, 1 = show user input
        up_down_tb = 1;
        speed_setting_tb = 0;
        usr_input_tb = 0;

        #20;
        rst_tb = 0;
        cntr_rst_tb = 0;

        // Quick sanity check: show each user input value within 1000ns
        sys_toggle_tb = 1;    // show user input on display
        cntr_enable_tb = 0;  // disable counter during user-input test
        up_down_tb = 1;
        speed_setting_tb = 0;

        for (integer u = 0; u < 16; u = u + 1) begin
            usr_input_tb = u;
            // Give the display a few clocks to settle for each user value.
            repeat (5) @(posedge clk_tb);
        end

        // Then run the counter briefly to confirm it still works.
        sys_toggle_tb = 0;
        cntr_enable_tb = 1;
        up_down_tb = 1;
        speed_setting_tb = 0;
        repeat (50) @(posedge clk_tb);

        $finish;
    end

endmodule