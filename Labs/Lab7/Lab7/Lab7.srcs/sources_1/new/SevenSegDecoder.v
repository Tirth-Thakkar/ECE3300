`timescale 1ns/1ps
module SevenSegDecoder (
    input [3:0] val,
    input anode,  
    output [6:0] seg // active-LOW {a,b,c,d,e,f,g}
);
    
    reg [6:0] seg_tmp;
    always @* begin
        case (val)
            4'h0: seg_tmp=7'b1000000; 
            4'h1: seg_tmp=7'b1111001; 
            4'h2: seg_tmp=7'b0100100; 
            4'h3: seg_tmp=7'b0110000;
            4'h4: seg_tmp=7'b0011001; 
            4'h5: seg_tmp=7'b0010010; 
            4'h6: seg_tmp=7'b0000010; 
            4'h7: seg_tmp=7'b1111000;
            4'h8: seg_tmp=7'b0000000; 
            4'h9: seg_tmp=7'b0011000; 
            4'hA: seg_tmp=7'b0001000; 
            4'hB: seg_tmp=7'b0000011;
            4'hC: seg_tmp=7'b1000110; 
            4'hD: seg_tmp=7'b0100001; 
            4'hE: seg_tmp=7'b0000110; 
            4'hF: seg_tmp=7'b0001110;
            default: seg_tmp=7'b1111111; // blank
        endcase
    end
    
    assign seg = anode ? 7'b1111111 : seg_tmp; // If anode is high, turn off all segments

endmodule //Test
