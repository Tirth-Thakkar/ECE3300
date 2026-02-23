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
    parameter SELECT_TB = $clog2(WIDTH_TB)*3,
    parameter CHANNEL_TB = WIDTH_TB/3
    );
    
    reg sys_clk_pin_tb;
    reg reset_tb;
    reg [SELECT_TB-1:0] select_tb;
    wire [CHANNEL_TB-1:0] red_tb;
    wire [CHANNEL_TB-1:0] green_tb;
    wire [CHANNEL_TB-1:0] blue_tb;

    TopModule #(.WIDTH(WIDTH_TB), .SELECT(SELECT_TB), .CHANNEL(CHANNEL_TB)) uut (
        .sys_clk_pin(sys_clk_pin_tb),
        .reset(reset_tb),
        .select(select_tb),
        .red(red_tb),
        .green(green_tb),
        .blue(blue_tb)
    );

    always #5 sys_clk_pin_tb = ~sys_clk_pin_tb; // 100 MHz clock

    initial begin
        sys_clk_pin_tb = 0; // Initialize clock to a known state
        reset_tb = 1;
        select_tb = 0; // Initialize select to a known state
        #100;
        reset_tb = 0;

        // Drive testbench values
        for (integer i = 0; i < (1 << WIDTH_TB); i = i + 1) begin
            #100;
            for (select_tb = 0; select_tb < (1 << SELECT_TB); select_tb = select_tb + 1) begin
                #100; 
            end
        end
    end

    
endmodule
