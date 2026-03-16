`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2026 06:29:19 PM
// Design Name: 
// Module Name: SevenSegDecoder_tb
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


module SevenSegDecoder_tb();

    reg [3:0] val_tb;
    wire [6:0] seg_tb;
    reg [7:0] anodes_tb;

    SevenSegDecoder uut (
        .val(val_tb),
        .seg(seg_tb),
        .anodes(anodes_tb)
    );

    initial begin
        // Keep the display enabled (active-low anode)
        anodes_tb[0] = 1'b0;
        anodes_tb[7:1] = 7'b1111111; // Disable other digits if present

        // Test all values from 0 to 15
        for (val_tb = 0; val_tb < 16; val_tb = val_tb + 1) begin
            #10; // Wait for 10 time units between changes
        end
        $finish; // End the simulation after testing all values
    end

endmodule
