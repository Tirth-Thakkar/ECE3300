`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2026 12:25:14 PM
// Design Name: 
// Module Name: mux2-1
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


module mux2_1(
    input [0:2] in,
    output out
    );

    wire [2:0] t;
    
    // in[0] --> is the first choice
    // in[1] --> is the second choice
    // in[2] --> is the select line/traffic controller
    not(t[0], in[2]);
    and(t[1], in[0], t[0]);
    and(t[2], in[1], in[2]);
    or(out, t[1], t[2]);
    
endmodule
