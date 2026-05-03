module carry_lookahead_adder #(
    parameter N = 8
)(
    input  wire [N-1:0] a,
    input  wire [N-1:0] b,
    input  wire         cin,
    output wire [N-1:0] sum,
    output wire         cout
);

    wire [N-1:0] p, g;
    wire [N:0]   c;

    assign p    = a ^ b;
    assign g    = a & b;
    assign c[0] = cin;
    assign cout = c[N];

    genvar i, j;
    generate
        for (i = 0; i < N; i = i + 1) begin : CLA_CARRY
            wire [i+1:0] carry_terms;

            // First term: g[i]
            assign carry_terms[0] = g[i];

            // Middle terms:
            // p[i]g[i-1], p[i]p[i-1]g[i-2], ...
            for (j = 1; j <= i; j = j + 1) begin : CLA_TERM
                assign carry_terms[j] =
                    (&p[i:i-j+1]) & g[i-j];
            end

            // Last term: p[i]p[i-1]...p[0]cin
            assign carry_terms[i+1] = (&p[i:0]) & cin;

            assign c[i+1] = |carry_terms;
            assign sum[i] = p[i] ^ c[i];
        end
    endgenerate

endmodule
