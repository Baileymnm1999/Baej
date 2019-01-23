`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    21:46:03 01/22/2019 
// Design Name: 
// Module Name:    mux_1_bit 
// Project Name:  
// Description: 
// Additional Comments: 
//////////////////////////////////////////////////////////////////////////////////
module mux_1_bit(
    input [15:0] A,
    input [15:0] B,
    input C,
    output reg [15:0] R
    );
	 
	 always @ * begin
	 if (C==0)
		begin
			R=A;
		end
	 else
		begin
			R=B;
		end
	 end
endmodule
