`timescale 1ps/ 1ps

module MUX #(
	parameter width = 32,
	parameter sel_width = $clog2(width)
    ) (
        input [width-1:0] in,
        input [sel_width-1:0] sel,
        output [width-1:0] out
    );

    assign out = in[sel];
	
endmodule