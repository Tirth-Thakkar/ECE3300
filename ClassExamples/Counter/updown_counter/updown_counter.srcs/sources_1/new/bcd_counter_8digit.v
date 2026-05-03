module bcd_counter_8digit (
    input        clk,
    input        rst,
    input        en_in,      // global enable for the whole 8-digit counter
    input        tick,
    input        up_down,    // 1 = up, 0 = down
    output [31:0] bcd,       // digit0=bcd[3:0], digit1=bcd[7:4], ... digit7=bcd[31:28]
    output       en_out      // overflow/borrow out from the last digit
);

wire [8:0] en_chain;

assign en_chain[0] = en_in;
assign en_out      = en_chain[8];

genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : GEN_BCD
        bcd_counter u_bcd_counter (
            .clk    (clk),
            .rst    (rst),
            .en_in  (en_chain[i]),
            .tick   (tick),
            .up_down(up_down),
            .bcd    (bcd[i*4 +: 4]),
            .en_out (en_chain[i+1])
        );
    end
endgenerate

endmodule