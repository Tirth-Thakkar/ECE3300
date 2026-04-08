`timescale 1ns / 1ps

module tb_TopModule;

    reg clk, sys_rst;
    reg cntr_rst, cntr_enable, cntr_up_down;
    reg lfsr_load;
    reg [15:0] lfsr_seed;
    reg [4:0] speed_setting;

    wire [6:0] seg;
    wire [7:0] anodes;

    TopModule uut (
        .clk(clk),
        .sys_rst(sys_rst),
        .cntr_rst(cntr_rst),
        .cntr_enable(cntr_enable),
        .cntr_up_down(cntr_up_down),
        .lfsr_load(lfsr_load),
        .lfsr_seed(lfsr_seed),
        .speed_setting(speed_setting),
        .seg(seg),
        .anodes(anodes)
    );

    always #5 clk = ~clk;

    integer i;

    initial begin
        clk = 0;
        sys_rst = 1;
        cntr_rst = 0;
        cntr_enable = 0;
        cntr_up_down = 1;
        lfsr_load = 0;
        lfsr_seed = 16'hBEEF;
        speed_setting = 5'd5;

        #20 sys_rst = 0;

        // load LFSR
        lfsr_load = 1;
        #10 lfsr_load = 0;

        cntr_enable = 1;

        $display("TopModule integration:");

        for (i = 0; i < 40; i = i + 1) begin
            #20;
            $display("t=%0t anodes=%b seg=%b", $time, anodes, seg);
        end

        // change direction
        cntr_up_down = 0;

        for (i = 0; i < 20; i = i + 1) begin
            #20;
            $display("DOWN t=%0t anodes=%b seg=%b", $time, anodes, seg);
        end

        $finish;
    end

endmodule