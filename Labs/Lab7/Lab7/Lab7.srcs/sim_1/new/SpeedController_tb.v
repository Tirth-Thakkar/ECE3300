`timescale 1ns / 1ps
module SpeedController_tb();

    reg clk_tb;
    reg rst_tb;
    reg [4:0] speed_setting_tb; // 5-bit input for speed setting (0-31)
    wire cntrl_speed_tb; // derived slower clock output

    SpeedController uut (
        .clk(clk_tb),
        .rst(rst_tb),
        .speed_setting(speed_setting_tb),
        .cntrl_speed(cntrl_speed_tb)
    );

    // Clock generation
    initial begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb; // Toggle clock every 5 time units
    end

    integer hold_cycles;
    initial begin
        // Initialize inputs
        rst_tb = 1; // Assert reset
        speed_setting_tb = 0; // Start with speed setting 0

        #10; // Wait for 10 time units
        rst_tb = 0; // Deassert reset

        // Test different speed settings, holding each one for a variable number of clock cycles
        for (integer s = 0; s < 32; s = s + 1) begin
            speed_setting_tb = s;

            // Hold longer as the selected bit becomes slower (but cap so simulation ends)
            if (s < 10)
                hold_cycles = 1 << (s + 1);
            else
                hold_cycles = 1024;

            repeat (hold_cycles) @(posedge clk_tb);
        end

        $finish; // End the simulation after testing all speed settings
    end
endmodule