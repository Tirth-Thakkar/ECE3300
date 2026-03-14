#(parameter COUNT_WIDTH = 32;)
module UpDownCounter(
    input clk,
    input rst,
    input up_down, // 1 for up, 0 for down
    input enable,
    output [COUNT_WIDTH-1:0] count,
);
    reg [COUNT_WIDTH-1:0] count_tmp;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count_tmp <= {COUNT_WIDTH{1'b0}}; // Reset count to 0
        end else if (enable) begin
            if (up_down) begin
                count_tmp <= count_tmp + 1; // Increment count
            end else begin
                count_tmp <= count_tmp - 1; // Decrement count
            end
        end
    end

    assign count = count_tmp;

endmodule