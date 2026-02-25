`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2026 07:45:57 PM
// Design Name: 
// Module Name: SevenSegment_tb
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


module SevenSegment_tb();

    reg CLK100MHZ_tb;
    reg [15:0] in_tb;
    wire [6:0] seg_tb;
    wire [7:0] an_tb;

    always #5 CLK100MHZ_tb = ~CLK100MHZ_tb; // Generate clock signal

    SevenSegment uut (
        .CLK100MHZ(CLK100MHZ_tb),
        .in(in_tb),
        .seg(seg_tb),
        .an(an_tb)
    );
    
    initial begin
        CLK100MHZ_tb = 0; // known starting state
        #50; // Wait for reset
        for(integer i = 0; i < 2**15; i = i + 1) begin
                in_tb = i; // Test all possible input combinations
                #50; // Wait for the output to stabilize
        end
        $finish; 
    end
endmodule
