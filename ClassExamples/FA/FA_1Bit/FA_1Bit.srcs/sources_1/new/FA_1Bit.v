`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/09/2026 12:29:17 PM
// Design Name: 
// Module Name: FA_1Bit
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

(* keep_heirarchy = "yes" *)
module FA_1Bit(
    input a,
    input b,
    input cin,
    output cout,
    output sum
    );

    // Gate Level Modeling of 1-bit Full Adder
    (* dont_touch = "true" *) wire [4:0] fa1bit_tmp;
    
    xor (fa1bit_tmp[1], a, b); // XOR for sum
    xor (sum, fa1bit_tmp[1], cin); // XOR for final sum
    and (fa1bit_tmp[2], a, b); // AND for carry
    and (fa1bit_tmp[3], fa1bit_tmp[1], cin);
    or (cout, fa1bit_tmp[2], fa1bit_tmp[3]); // OR for final carry


endmodule
