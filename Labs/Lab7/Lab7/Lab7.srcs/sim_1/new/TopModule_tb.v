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

        // Iterate over user control modes & inputs
        for (integer toggle = 0; toggle < 2; toggle = toggle + 1) begin
            sys_toggle_tb = toggle;

            for (integer u = 0; u < 16; u = u + 1) begin
                usr_input_tb = u;

                // Iterate over both directions (up/down)
                for (integer dir = 0; dir < 2; dir = dir + 1) begin
                    up_down_tb = dir; // 0 = down, 1 = up

                    // Iterate over all speed settings (0..31)
                    for (integer s = 0; s < 32; s = s + 1) begin
                        speed_setting_tb = s;

                        // Let the counter run for a few cycles so you can see it change
                        // (adjust the repeat value to observe more cycles per speed setting)
                        repeat (10) @(posedge clk_tb);
                    end
                end
            end
        end
        $finish;
    end

endmodule