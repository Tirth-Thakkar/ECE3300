`timescale 1ns / 1ps
module UpDownCounter_tb #(
        parameter COUNT_WIDTH_TB = 4
    )();

    reg clk_tb;
    reg rst_tb;
    reg up_down_tb; // 1 for up, 0 for down
    reg enable_tb;
    wire [COUNT_WIDTH_TB-1:0] count_tb; // COUNT_WIDTH_TB-bit output for count

    UpDownCounter #(.COUNT_WIDTH(COUNT_WIDTH_TB)) uut (
        .clk(clk_tb),
        .rst(rst_tb),
        .up_down(up_down_tb),
        .enable(enable_tb),
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
        enable_tb = 1; // Enable counting

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