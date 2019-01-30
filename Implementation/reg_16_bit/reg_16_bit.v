`timescale 1ns / 1ps

module reg_16_bit(
    input [15:0] A,
    output reg [15:0] B,
    input write,
    input read
    );
	 
	 reg [15:0] value;
	 
	 always begin
	 
		 if (read) B = value;
		 if (write) value = A;
	 
	 end
	 
endmodule
