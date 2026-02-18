`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2026 09:43:34 PM
// Design Name: 
// Module Name: Decoder4_16_tb
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


module Decoder4_16_tb();
    reg [3:0] in_tb;
    wire [15:0] out_tb;

    Decoder4_16 dut(
        .in4x16(in_tb),
        .out4x16(out_tb)
    );

    initial begin
        // Test all input combinations from 0 to 15
        for (in_tb = 0; in_tb < 16; in_tb = in_tb + 1) begin
            #10; // Wait for 10 time units for output to stabilize
            $display("Input: %b, Output: %b", in_tb, out_tb);
        end
        $finish; // End simulation
    end

endmodule

