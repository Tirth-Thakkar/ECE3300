module UpDownCounter_tb ();
    reg clk_tb;
    reg rst_tb;
    reg up_down_tb;
    reg enable_tb;
    wire [3:0] count_tb;

    UpDownCounter #(.COUNT_WIDTH(4)) uut (
        .clk(clk_tb),
        .rst(rst),
        .up_down(up_down_tb),
        .enable(enable_tb),
        .count(count_tb)
    );

    // Clock generation
    initial begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb; // 10ns period
    end

    initial begin
        // Test sequence
        rst_tb = 1; up_down_tb = 1; enable_tb = 0; #10; // Reset the counter
        rst_tb = 0; enable_tb = 1; #50; // Count up for 5 clock cycles
        up_down_tb = 0; #50; // Count down for 5 clock cycles
        enable_tb = 0; #10; // Disable counting
        $finish;
    end
endmodule
