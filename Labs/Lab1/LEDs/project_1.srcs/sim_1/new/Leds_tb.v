`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: #
// 
// Create Date: 02/02/2026 01:43:20 PM
// Design Name: 
// Module Name: Leds_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for Leds module - tests switch to LED mapping
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Leds_tb();
    // Testbench signals
    reg [0:15] SW_tb;      // Switch inputs
    wire [0:15] LED_tb;    // LED outputs
    
    // Instantiate the Unit Under Test (UUT) 
    Leds uut (
        .SW(SW_tb),
        .LED(LED_tb)
    );
    
    // Test sequence
    integer i;
    initial begin
        #20;
        // Test 1: All switches OFF
        SW_tb = 16'h0000;
        #20;
        
        // Test 2: All switches ON
        SW_tb = 16'hFFFF;
        #20;
        
        // Test 3: Alternating patterns
        SW_tb = 16'hAAAA;
        #20;
        SW_tb = 16'h5555;
        #20;
        
        // Test 4: Walking 1's pattern 
        for (i = 0; i < 16; i = i + 1) begin
            SW_tb = 16'h0001 << i;
            #20;
        end
        
        $display("Simulation complete");
        $finish;
    end
    
endmodule
