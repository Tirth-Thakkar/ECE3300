`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2026 11:23:19 PM
// Design Name: 
// Module Name: Mux4_1
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


module Mux4_1(
    input [3:0] data,
    input [1:0] sel,
    output [3:0] data_out,
    output [1:0] sel_out,
    output out
    );
    
    assign out = data[sel];
    assign data_out = data;
    assign sel_out = sel;
endmodule
