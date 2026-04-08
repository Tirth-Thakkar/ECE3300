`timescale 1ns / 1ps

module LFSR_tb;

    reg clk, rst, enable, load;
    reg [15:0] seed;
    wire [15:0] state;

    LFSR uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .load(load),
        .seed(seed),
        .state(state)
    );

    // clock
    always #5 clk = ~clk;

    integer i;

    initial begin
        clk = 0; rst = 1; enable = 0; load = 0;
        seed = 16'hACE1;

        #10 rst = 0;

        // load seed
        load = 1;
        #10 load = 0;
        enable = 1;

        $display("LFSR sequence:");
        for (i = 0; i < 20; i = i + 1) begin
            #10;
            $display("Cycle %0d : %h", i, state);
        end

        $finish;
    end

endmodule