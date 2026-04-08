`timescale 1ns / 1ps

module DecimalTable (
    input [3:0] val,
    output [6:0] seg // active-LOW {a,b,c,d,e,f,g}
    );

    reg [6:0] seg_tmp;

    always @(*) begin
        case (val)
            4'd0: seg_tmp = 7'b1000000;
            4'd1: seg_tmp = 7'b1111001;
            4'd2: seg_tmp = 7'b0100100;
            4'd3: seg_tmp = 7'b0110000;
            4'd4: seg_tmp = 7'b0011001;
            4'd5: seg_tmp = 7'b0010010;
            4'd6: seg_tmp = 7'b0000010;
            4'd7: seg_tmp = 7'b1111000;
            4'd8: seg_tmp = 7'b0000000;
            4'd9: seg_tmp = 7'b0011000;
            default: seg_tmp = 7'b1111111; // blank for invalid BCD digit
        endcase
    end

    assign seg = seg_tmp;

endmodule