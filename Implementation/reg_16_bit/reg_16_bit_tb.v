`timescale 1ns / 1ps

module reg_16_bit_tb;

	// Inputs
	reg [15:0] A;
	reg write;
	reg read;

	// Outputs
	wire [15:0] B;

	// Instantiate the Unit Under Test (UUT)
	reg_16_bit uut (
		.A(A), 
		.B(B), 
		.write(write), 
		.read(read)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		write = 0;
		read = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		A = -10;
		repeat(20) begin // write = 0, read = 0
			if (B === 16'bxxxxxxxxxxxxxxxx) begin
				$display("PASS: write = 0, read = 0");
			end
			else begin
				$display("FAIL: write = 0, read = 0");
			end
			A = A + 1;
			#1;
		end
		
		// write = 0, read = 1
		A = -10;
		write = 1;
		#1;
		write = 0;
		read = 1;
		#1;
		repeat(20) begin
			if ( $signed(B) == -10 ) begin
				$display("PASS: write = 0, read = 1");
			end
			else begin
				$display("FAIL: write = 0, read = 1");
			end
			A = A + 1;
			#1;
		end
		
		A = -10;
		write = 1;
		read = 0;
		#1;
		repeat(20) begin // write = 1, read = 0
			if ( B != A ) begin
				$display("PASS: write = 1, read = 0");
			end
			else begin
				$display("FAIL: write = 1, read = 0");
			end
			A = A + 1;
			#1;
		end
		
		A = -10;
		#1
		write = 1;
		#1;
		read = 1;
		#1	;
		repeat(20) begin // write = 1, read = 1
			if ( B == A ) begin
				$display("PASS: write = 1, read = 1");
			end
			else begin
				$display("FAIL: write = 1, read = 1");
			end
			A = A + 1;
			#2;
		end
		
	end
      
endmodule

