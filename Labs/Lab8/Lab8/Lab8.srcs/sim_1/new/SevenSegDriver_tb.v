`timescale 1ns / 1ps

module tb_SevenSegDriver;

    reg clk, rst;
    reg [31:0] vals;
    wire [6:0] seg;
    wire [7:0] anodes;

    SevenSegDriver uut (
        .clk(clk),
        .rst(rst),
        .vals(vals),
        .seg(seg),
        .anodes(anodes)
    );

    always #1 clk = ~clk; // fast for scan visibility

    integer i;

    initial begin
        clk = 0; rst = 1;
        vals = 32'h1234_ABCD;

        #10 rst = 0;

        $display("SevenSeg scan (observe anodes + seg):");
        for (i = 0; i < 50; i = i + 1) begin
            #2;
            $display("t=%0t anodes=%b seg=%b", $time, anodes, seg);
        end

        $finish;
    end

endmodule