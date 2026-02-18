`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2026 12:42:45 PM
// Design Name: 
// Module Name: UCH
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


module UCH
    #(parameter WIDTH = 8)
    (
        input clk, 
        input rst, 
        input en, 
        output [WIDTH-1:0] out
    );

    reg [WIDTH-1:0] counter;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
        end else if (en) begin
            counter <= counter + 1;
        end
    end
    assign out = counter;
endmodule
