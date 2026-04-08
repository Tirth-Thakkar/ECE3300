module SpeedController #(
    parameter CNTRL_WIDTH = 16,
    parameter SEL_WIDTH = $clog2(CNTRL_WIDTH)
)(
    input clk,
    input rst,
    input [SEL_WIDTH-1:0] speed_setting,
    output tick
);

    reg [CNTRL_WIDTH-1:0] counter;
    reg sel_bit_d;

    wire sel_bit;
    assign sel_bit = counter[speed_setting];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter   <= 0;
            sel_bit_d <= 0;
        end else begin
            counter   <= counter + 1'b1;
            sel_bit_d <= sel_bit;
        end
    end

    assign tick = sel_bit & ~sel_bit_d;   // rising-edge pulse
endmodule