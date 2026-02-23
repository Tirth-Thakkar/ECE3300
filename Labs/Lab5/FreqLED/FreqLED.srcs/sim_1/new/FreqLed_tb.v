`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2026 08:16:58 PM
// Design Name: 
// Module Name: FreqLed_tb
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


module FreqLed_tb #(
    parameter WIDTH_TB = 32,
    parameter SELECT_TB = $clog2(WIDTH_TB)*3
    );
    
    reg CLK100MHZ_tb;
    reg reset_tb;
    reg [SELECT_TB-1:0] select_tb;
    wire red_tb;
    wire green_tb;
    wire blue_tb;

    TopModule #(.WIDTH(WIDTH_TB), .SELECT(SELECT_TB)) uut (
        .CLK100MHZ(CLK100MHZ_tb),
        .reset(reset_tb),
        .select(select_tb),
        .red(red_tb),
        .green(green_tb),
        .blue(blue_tb)
    );

    always #5 CLK100MHZ_tb = ~CLK100MHZ_tb; // 100 MHz clock

    initial begin
        CLK100MHZ_tb = 0; // known starting state
        // rst_n on DUT is active‑low, so start asserted then release
        reset_tb = 0;          // assert reset
        select_tb = 0;        // initialize select field
        #10;
        reset_tb = 1;          // deassert reset, counter can run

        // step through selects over time
        for (integer i = 0; i < WIDTH_TB; i = i + 1) begin
            #50;
            for (integer sel = 0; sel < SELECT_TB; sel = sel + 1) begin
                select_tb = sel;
                #50;
            end
        end
        $finish;
    end

    
endmodule
