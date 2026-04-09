`timescale 1ns / 1ps

module UpDownCounter #(
    parameter COUNT_WIDTH = 16
    )(
        input clk,
        input rst,
        input up_down, // 1 for up, 0 for down
        input enable,
        output [COUNT_WIDTH-1:0] count
    );

        reg [COUNT_WIDTH-1:0] count_tmp;
        wire [COUNT_WIDTH-1:0] next_count;

        assign next_count = up_down ? (count_tmp + 1'b1) : (count_tmp - 1'b1);

        always @(posedge clk or posedge rst) begin
            if (rst) begin
                count_tmp <= {COUNT_WIDTH{1'b0}};
            end else if (enable) begin
                count_tmp <= next_count;
            end
        end

        assign count = count_tmp;

endmodule
