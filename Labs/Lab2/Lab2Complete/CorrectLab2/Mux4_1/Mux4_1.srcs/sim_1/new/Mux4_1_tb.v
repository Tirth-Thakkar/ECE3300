`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2026 11:25:03 PM
// Design Name: 
// Module Name: Mux4_1_tb
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


module Mux4_1_tb();
    reg [3:0] data_tb;
    reg [1:0] sel_tb;
    wire out_tb;

    Mux4_1 uut (
        .data(data_tb),
        .sel(sel_tb),
        .out(out_tb)
    );

    integer i, j;
    initial begin
        // Initialize
        data_tb = 4'b0000;
        sel_tb = 2'b00;
        #10;
        
        // Cycle through possible data patterns
        for (i = 0; i < 16; i = i + 1) begin
            data_tb = i;
            
            // For each data pattern, test all 4 selector values
            for (j = 0; j < 4; j = j + 1) begin
                sel_tb = j;
                #50;  
            end
            
            #50;
        end
        #50;
        $finish;
    end
endmodule
