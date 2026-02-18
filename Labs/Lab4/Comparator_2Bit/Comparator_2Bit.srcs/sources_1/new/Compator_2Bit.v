//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2026 01:06:34 PM
// Design Name: 
// Module Name: Comparator_2Bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Comparator_2Bit(

    input [1:0] A,
    output [1:0] Out_A,
    input [1:0] B,
    output [1:0] Out_B,
    output A_gt_B,
    output A_eq_B,
    output A_lt_B
    );

    wire inter[4:0];

    // https://www.researchgate.net/profile/Dimitris-Bogas-2/publication/283575650/figure/fig1/AS:476234573455361@1490554578816/A-2-bit-comparator-with-eight-gates-after-a-De-Morgan-simplification-performed-on-the.png
    xnor(inter[0], A[1], B[1]); // inter[0] xnor of A[1] and B[1]
    xor(inter[1], A[0], B[0]); // inter[1] xnor of A[0] and B[0]
    nand(inter[2], inter[1], B[0]); // output of xor and B[0]
    nand(inter[3], inter[2], inter[0]); // nand + xnor
    nor(inter[4], inter[0], B[1]); // xnor + b[0]
    xor(A_lt_B, inter[4], inter[3]);
    nor(A_eq_B, inter[1], inter[3]); 
    nor(A_gt_B, A_eq_B, A_lt_B);


endmodule
