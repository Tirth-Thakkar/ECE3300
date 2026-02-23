`timescale 1ps / 1ps

module Counter #(
    parameter WIDTH = 32
    ) (
        input clk,
        input rst_n,
        output [WIDTH-1:0] count
    );

    reg [WIDTH-1:0] tmp;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tmp <= 0;
        end else begin
            tmp <= tmp + 1;
        end
    end

    assign count = tmp; 

endmodule