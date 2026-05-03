module bcd_counter (
    input        clk,
    input        rst,
    input        en_in,
    input        tick,
    input        up_down,   // 1 = up, 0 = down
    output reg [3:0] bcd,
    output       en_out
);

assign en_out = tick && en_in &&
                ( ( up_down && (bcd == 4'd9) ) ||
                  (!up_down && (bcd == 4'd0) ) );

always @(posedge clk) begin
    if (rst) begin
        bcd <= (up_down) ? 4'd0 : 4'd9;
    end
    else if (en_in && tick) begin
        if (up_down)
            bcd <= (bcd == 4'd9) ? 4'd0 : (bcd + 4'd1);
        else
            bcd <= (bcd == 4'd0) ? 4'd9 : (bcd - 4'd1);
    end
end

endmodule