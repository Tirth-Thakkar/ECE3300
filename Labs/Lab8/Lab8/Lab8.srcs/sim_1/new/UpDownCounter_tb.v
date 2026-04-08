`timescale 1ns / 1ps

module tb_UpDownCounter;

    reg clk, rst, enable, up_down;
    wire [15:0] count;

    UpDownCounter #(.COUNT_WIDTH(16)) uut (
        .clk(clk),
        .rst(rst),
        .up_down(up_down),
        .enable(enable),
        .count(count)
    );

    always #5 clk = ~clk;

    integer i;

    initial begin
        clk = 0; rst = 1; enable = 0; up_down = 1;

        #10 rst = 0;
        enable = 1;

        $display("Counting UP:");
        for (i = 0; i < 10; i = i + 1) begin
            #10;
            $display("Cycle %0d : %d", i, count);
        end

        up_down = 0;

        $display("Counting DOWN:");
        for (i = 0; i < 10; i = i + 1) begin
            #10;
            $display("Cycle %0d : %d", i, count);
        end

        $finish;
    end

endmodule