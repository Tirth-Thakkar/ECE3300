`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2026 09:43:01 PM
// Design Name: 
// Module Name: Decoder4_16
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


module Decoder4_16(
    input [3:0] in4x16,
    output [15:0] out4x16
    );
    
    wire not_in3;    
    
    // Generate inverse of MSB
    not (not_in3, in4x16[3]);
    
    // First decoder outputs to out4x16[7:0] (for input combinations 0-7)
    Decoder3_8 d1(
        .enable(not_in3),
        .in(in4x16[2:0]),
        .out(out4x16[7:0])
    );

    // Second decoder outputs to out4x16[15:8] (for input combinations 8-15)
    Decoder3_8 d2(
        .enable(in4x16[3]),
        .in(in4x16[2:0]),
        .out(out4x16[15:8])
    );
endmodule
