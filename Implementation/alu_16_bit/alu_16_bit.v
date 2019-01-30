`timescale 1ns / 1ps

module alu_16_bit(
	 input clk,
    input [15:0] A,
    input [15:0] B,
    input [2:0] op,
    output reg [15:0] R,
    output reg AltB
    );
	 
	 always @(posedge clk) begin
	 
		 case (op)
			0: R = A & B; 	// And
			1: R = A | B; 	// Or
			2: R = A + B;	// Add
			3: R = A - B;	// Sub
			4: if ($signed(B) < 0) begin // shift
					R = (A >>(~B)) >> 1;
				end
				else if (B == 0) begin
					R = A;
				end
				else begin
					R = A << B;
				end
			5: AltB = (A < B); // slt
		 endcase
			
	 end
	 
endmodule
