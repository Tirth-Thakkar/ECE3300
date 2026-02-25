`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2026 01:14:51 PM
// Design Name: 
// Module Name: dsp_driver_tb
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


module dsp_driver_tb #(parameter DIGIT_NUM_tb = 4, parameter IND = $clog2(DIGIT_NUM_tb)) ();

    reg dsp_clk_tb;
    reg  dsp_reset_tb;
    reg  [DIGIT_NUM_tb*4-1:0] dsp_inp_tb;

    wire [DIGIT_NUM_tb-1:0] dsp_an_tb;
    wire [6:0]           dsp_cc_tb;
    wire                  dsp_dot_tb;

    // instantiate the device under test
    dsp_driver #(.DIGIT_NUM(DIGIT_NUM_tb)) dut (
        .dsp_clk(dsp_clk_tb),
        .dsp_reset(dsp_reset_tb),
        .dsp_inp(dsp_inp_tb),
        .dsp_an(dsp_an_tb),
        .dsp_cc(dsp_cc_tb),
        .dsp_dot(dsp_dot_tb)
     );

     // clock generation
     initial begin
         dsp_clk_tb = 0;
         forever #5 dsp_clk_tb = ~dsp_clk_tb; // 100 MHz clock
     end

     // test stimulus
     initial begin
         // initialize inputs
         dsp_reset_tb = 1;
         dsp_inp_tb = 0;

         // release reset after some time
         #20;
         dsp_reset_tb = 0;

         // apply some test patterns to the input
         #10; dsp_inp_tb = 16'h1234; // Display "1234"
         #100; dsp_inp_tb = 16'h5678; // Display "5678"
         #100; dsp_inp_tb = 16'h9ABC; // Display "9ABC"
         #100; dsp_inp_tb = 16'hDEF0; // Display "DEF0"

         // finish simulation after some time
         #100;
         $finish; 
     end
endmodule
