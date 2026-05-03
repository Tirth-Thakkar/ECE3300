module speed_controller (
    input        clk,
    input        rst,
    input        en,
    input  [4:0] sel,
    output    reg   clk_speed
);

reg [31:0] tmp;
wire clock_speed_tmp;

always @(posedge clk or posedge rst) begin
    if (rst)
        tmp <= 32'd0;
    else if (en)
        tmp <= tmp + 32'd1;
end

assign clk_speed_tmp = tmp[sel];

always @(posedge clk or posedge rst) begin
    if (rst)
        clk_speed <= 0;
    else if (en)
        clk_speed <= clk_speed_tmp;
end

endmodule