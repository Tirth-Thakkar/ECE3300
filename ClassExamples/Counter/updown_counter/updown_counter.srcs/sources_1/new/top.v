module top (
    input         clk,
    input         rst,
    input         enable,
    input         up_down,
    input  [4:0]  sel,
    output [31:0] bcd,
    output        clk_speed,
    output        en_out
);

wire clk_speed_int;
wire tick;
reg  clk_speed_d;

speed_controller u_speed_controller (
    .clk       (clk),
    .rst       (rst),
    .en        (enable),
    .sel       (sel),
    .clk_speed (clk_speed_int)
);

always @(posedge clk) begin
    if (rst)
        clk_speed_d <= 1'b0;
    else
        clk_speed_d <= clk_speed_int;
end

assign tick      = clk_speed_int & ~clk_speed_d;
assign clk_speed = clk_speed_int;

bcd_counter_8digit u_bcd_counter_8digit (
    .clk     (clk),
    .rst     (rst),
    .en_in   (enable),
    .tick    (tick),
    .up_down (up_down),
    .bcd     (bcd),
    .en_out  (en_out)
);

endmodule