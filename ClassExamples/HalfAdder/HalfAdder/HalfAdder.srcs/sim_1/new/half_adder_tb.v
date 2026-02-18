`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2026 12:43:10 PM
// Design Name: 
// Module Name: half_adder_tb
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


module half_adder_tb(

    );
    
    wire sum_tb, cout_tb;
    reg a_tb, b_tb;
    
    half_adder HA1 (
        .A(a_tb),
        .B(b_tb),
        .Sum(sum_tb),
        .Carry(count_tb)
     );
     
     initial 
        begin:TST
            a_tb = 0;
            b_tb = 0;
         #50
            a_tb = 1;
            b_tb = 0;
         #50
            a_tb = 1;
            b_tb = 1;
         #50 
            a_tb = 0;
            b_tb = 0;
         #100 
            $finish;
      end

endmodule
