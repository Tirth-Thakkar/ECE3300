`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2026 06:17:28 PM
// Design Name: 
// Module Name: SpeedController
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

#(parameter CNTRL_WIDTH = 32;)
#(parameter COUNT_WIDTH = $clog2(CNTRL_WIDTH);)
module SpeedController(
    input clk,
    input [COUNT_WIDTH-1:0] speed_setting, // 5-bit input for speed setting (0-31)
    output [CNTRL_WIDTH-1:0] cntrl_speed,
    );

    
    UpDownCounter #(.COUNT_WIDTH(COUNT_WIDTH)) counter (
        .clk(clk),
        .rst(1'b0), // No reset
        .up_down(1'b1), // Always count up
        .enable(1'b1), // Always enabled
        .count(cntrl_speed[COUNT_WIDTH-1:0]) // Connect the lower COUNT_WIDTH bits to the counter output
    );
endmodule
