`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2026 01:02:52 PM
// Design Name: 
// Module Name: dsp_driver
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


module dsp_driver #(parameter DIGIT_NUM = 4, parameter IND = $clog2(DIGIT_NUM))(
    input  wire                 dsp_clk,
    input  wire                 dsp_reset,
    input  wire [DIGIT_NUM*4-1:0] dsp_inp,

    output reg  [DIGIT_NUM-1:0] dsp_an,
    output reg  [6:0]           dsp_cc,
    output       dsp_dot
    );

    // internal signals for multiplexing
    reg [19:0]       dsp_tmp;
    reg [6:0]        dsp_temp_cc;
    wire [IND-1:0]   dsp_sel;
    wire [3:0]       dsp_digit;

    // generate the digit select from the upper bits of the free-running counter
    assign dsp_sel = dsp_tmp[19:19-IND+1];

    // pick the appropriate nibble from the input bus
    assign dsp_digit = dsp_inp[dsp_sel*4 +: 4];

    always @* begin
        case (dsp_digit)
            0: dsp_temp_cc = 7'b1000000;
            1: dsp_temp_cc = 7'b1111001;
            2: dsp_temp_cc = 7'b0100100;
            3: dsp_temp_cc = 7'b0110000;
            4: dsp_temp_cc = 7'b0011001;
            5: dsp_temp_cc = 7'b0010010;
            6: dsp_temp_cc = 7'b0000010;
            7: dsp_temp_cc = 7'b1111000;
            8: dsp_temp_cc = 7'b0000000;
            9: dsp_temp_cc = 7'b0010000;
            'hA: dsp_temp_cc = 7'b0001000;
            'hB: dsp_temp_cc = 7'b0000011;
            'hC: dsp_temp_cc = 7'b1000110;
            'hD: dsp_temp_cc = 7'b0100001;
            'hE: dsp_temp_cc = 7'b0000110;
            'hF: dsp_temp_cc = 7'b0001110;
            default: dsp_temp_cc = 7'b1111111;
        endcase 
    end

    always@(posedge dsp_clk or posedge dsp_reset) begin
        if (dsp_reset) begin
            dsp_tmp <= 0;
        end else begin
            dsp_tmp <= dsp_tmp + 1;
        end
    end

    // combinational outputs for anode and segment code
    always @* begin
        dsp_an = ~( { {DIGIT_NUM-1{1'b0}}, 1'b1 } << dsp_sel );
        dsp_cc = dsp_temp_cc;
    end

    assign dsp_dot = 1'b1;
endmodule
