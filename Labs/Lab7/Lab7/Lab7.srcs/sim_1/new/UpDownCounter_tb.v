`timescale 1ns / 1ps
module UpDownCounter_tb();

    reg clk_tb;
    reg rst_tb;
    reg up_down_tb; // 1 for up, 0 for down
    wire [3:0] count_tb; // 4-bit output for count

    UpDownCounter uut (
        .clk(clk_tb),
        .rst(rst_tb),
        .up_down(up_down_tb),
        .count(count_tb)
    );

    // Clock generation
    initial begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb; // Toggle clock every 5 time units
    end

    initial begin
        // Initialize inputs
        rst_tb = 1; // Assert reset
        up_down_tb = 1; // Start counting up

        #10; // Wait for 10 time units
        rst_tb = 0; // Deassert reset

        // Test counting up
        repeat (16) begin
            #10; // Wait for 10 time units between changes
        end

        up_down_tb = 0; // Switch to counting down

        // Test counting down
        repeat (16) begin
            #10; // Wait for 10 time units between changes
        end

        $finish; // End the simulation after testing both counting directions
    end
endmodule