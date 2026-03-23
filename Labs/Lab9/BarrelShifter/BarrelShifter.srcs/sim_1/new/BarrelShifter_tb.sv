`timescale 1ns/1ps

module BarrelShifter_tb;
    localparam int BitWidth = 8;
    localparam int BitCtl = 3;

    logic [BitWidth-1:0] data_in_tb;
    logic [BitCtl-1:0] bit_control_tb;
    logic [BitWidth-1:0] data_out_tb;
    logic [BitWidth-1:0] expected;
    logic [(2*BitWidth)-1:0] doubled_input;

    int error_count;
    int test_count;

    BarrelShifter #(.BIT_WIDTH(BitWidth), .BIT_CTL(BitCtl)) uut (
        .data_in(data_in_tb),
        .bit_control(bit_control_tb),
        .data_out(data_out_tb)
    );

    assign doubled_input = {data_in_tb, data_in_tb};

    initial begin
        error_count = 0;
        test_count = 0;

        // Exhaustive: all 256 inputs x all 8 rotate amounts.
        for (int din = 0; din < (1 << BitWidth); din++) begin
            for (int sh = 0; sh < BitWidth; sh++) begin
                data_in_tb = din[BitWidth-1:0];
                bit_control_tb = sh[BitCtl-1:0];
                #1;

                expected = doubled_input[bit_control_tb +: BitWidth];
                test_count++;

                if (data_out_tb !== expected) begin
                    error_count++;
                    $display(
                        "ERROR: data_in=%b shift=%0d expected=%b got=%b",
                        data_in_tb,
                        bit_control_tb,
                        expected,
                        data_out_tb
                    );
                end
            end
        end

        if (error_count == 0) begin
            $display("PASS: %0d/%0d cases matched.", test_count, test_count);
        end else begin
            $display("FAIL: %0d mismatches out of %0d cases.", error_count, test_count);
        end

        $finish;
    end

endmodule
