`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2026 06:37:10 PM
// Design Name: 
// Module Name: Mux4_1
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


(* keep_heirarchy = "yes" *) 
module Mux4_1(
    input [3:0] data,
    input [1:0] sel,
    output [3:0] data_out,
    output [1:0] sel_out,
    output out
    );

    // Creating a 4 to 1 Multiplexer using gates

    // Internal wires for AND gate outputs
    (* dont_touch = "true" *) wire and0_out, and1_out, and2_out, and3_out, sel1_not, sel0_not;
    
    // NOT gates for select inputs
    not(sel0_not, sel[0]);
    not(sel1_not, sel[1]);
    
    // 3-input AND gates for each data input with  select line 
    and(and0_out, data[0], sel0_not, sel1_not);  // data[0] when sel = 00
    and(and1_out, data[1], sel1_not, sel[0]);      // data[1] when sel = 01
    and(and2_out, data[2], sel[1], sel0_not);      // data[2] when sel = 10
    and(and3_out, data[3], sel[1], sel[0]);          // data[3] when sel = 11
    
    // OR gate to combine all AND outputs
    or(out, and0_out, and1_out, and2_out, and3_out);
    
    assign data_out = data;
    assign sel_out = sel;
    
endmodule
