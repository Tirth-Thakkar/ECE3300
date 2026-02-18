`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2026 01:06:34 PM
// Design Name: 
// Module Name: Comparator_2Bit
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


module Comparator_2Bit_tb();
    reg [1:0] A_tb;
    reg [1:0] B_tb;
    wire A_gt_B_tb;
    wire A_lt_B_tb;
    wire A_eq_B_tb;    

    Comparator_2Bit uut (
        .A(A_tb),
        .B(B_tb),
        .A_gt_B(A_gt_B_tb),
        .A_eq_B(A_eq_B_tb),
        .A_lt_B(A_lt_B_tb)
    );

    integer i, j;
    initial begin:TST
        A_tb = 2'b00;
        B_tb = 2'b00;
        #10; 

        for (i=0; i < 4; i = i + 1) begin
            A_tb = i;
            for (j=0; j < 4; j = j + 1) begin
                #50;
                B_tb = j;
            end    
            #50;
        end
        #50; 
        $finish;
    end:TST

endmodule
