`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2026 07:45:31 PM
// Design Name: 
// Module Name: SevenSegment
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


module SevenSegment(
    input CLK100MHZ,
    input [15:0] in,
    output [6:0] seg,
    output [7:0] an
    );

    reg [15:0] clk_div;
    reg [2:0] digit_select;
    reg [6:0] seg_reg;

    initial begin
        clk_div = 0;
        digit_select = 0;
    end

    // Clock divider for multiplexing
    always @(posedge CLK100MHZ) begin
        clk_div <= clk_div + 1;
        if (clk_div == 0) begin
            digit_select <= digit_select + 1;
        end
    end

     // 7-segment display logic For Values 0 - 9

    always @(*) begin
        case (in[digit_select*4 +: 4])
            4'b0000: seg_reg = 7'b1000000; // 0
            4'b0001: seg_reg = 7'b1111001; // 1
            4'b0010: seg_reg = 7'b0100100; // 2
            4'b0011: seg_reg = 7'b0110000; // 3
            4'b0100: seg_reg = 7'b0011001; // 4
            4'b0101: seg_reg = 7'b0010010; // 5
            4'b0110: seg_reg = 7'b0000010; // 6
            4'b0111: seg_reg = 7'b1111000; // 7
            4'b1000: seg_reg = 7'b0000000; // 8
            4'b1001: seg_reg = 7'b0010000; // 9
            default: seg_reg = 7'b1111111; // Blank for invalid input
        endcase
    end

    assign seg = seg_reg;
    assign an = ~(1 << digit_select); // Active low for digit selection

endmodule
