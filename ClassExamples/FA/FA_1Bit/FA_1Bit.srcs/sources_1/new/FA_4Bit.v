module FA_4Bit (
    input [3:0] a,
    input [3:0] b,
    input cin,
    output cout,
    output [3:0] sum
    );

    wire carry[2:0];

    FA_1Bit FA0 (
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .cout(carry[0]),
        .sum(sum[0])
    );

    FA_1Bit FA1 (
        .a(a[1]),
        .b(b[1]),
        .cin(carry[0]),
        .cout(carry[1]),
        .sum(sum[1])
    );

    FA_1Bit FA2 (
        .a(a[2]),
        .b(b[2]),
        .cin(carry[1]),
        .cout(carry[2]),
        .sum(sum[2])
    );

    FA_1Bit FA3 (
        .a(a[3]),
        .b(b[3]),
        .cin(carry[2]),
        .cout(cout),
        .sum(sum[3])
);

    assign cout = carry[2];

endmodule