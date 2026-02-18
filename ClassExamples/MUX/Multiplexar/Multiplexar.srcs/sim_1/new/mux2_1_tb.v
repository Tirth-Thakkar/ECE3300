`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2026 12:30:49 PM
// Design Name: 
// Module Name: mux2_1_tb
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


module mux2_1_tb();
    
    reg [0:2] in_tb;
    wire out_tb;

    mux2_1 uut (
        .in(in_tb),
        .out(out_tb)
    );
    
    initial begin
        in_tb = 0;
        #50
        in_tb = 1;
        #50
        in_tb = 2;
        #50
        in_tb = 3;
        #50
        in_tb = 4;
        #50
        in_tb = 5;
        #50
        in_tb = 6;
        #50
        in_tb = 7;
        #50
        in_tb = 3'bzzz;
        #50
        in_tb = 3'bxxx;
        #50
        in_tb = 3'b000;
        
        #100
        
        $finish;
    end

endmodule
