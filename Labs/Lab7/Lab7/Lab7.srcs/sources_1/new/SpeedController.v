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


module SpeedController #(
        parameter CNTRL_WIDTH = 32,
        parameter COUNT_WIDTH = $clog2(CNTRL_WIDTH) 
    )(
        input clk,
        input rst,
        input [COUNT_WIDTH-1:0] speed_setting, // 5-bit input for speed setting (0-31)
        output [CNTRL_WIDTH-1:0] cntrl_speed
    );


        UpDownCounter #(.COUNT_WIDTH(COUNT_WIDTH)) counter (
            .clk(clk),
            .rst(rst),
            .up_down(1'b1), // Always count up
            .enable(1'b1), // Always enabled
            .count(cntrl_speed[COUNT_WIDTH-1:0]) // Connect the lower COUNT_WIDTH bits to the counter output
        );

        Mux #(.WIDTH(CNTRL_WIDTH)) mux32x1_1 (
            .vals(cntrl_speed), // Connect the counter output to the mux inputs
            .sel(speed_setting), // Use the speed setting as the select signal
            .out(cntrl_speed) // Connect the mux output to the control speed output
        );

endmodule