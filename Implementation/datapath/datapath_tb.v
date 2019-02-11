`timescale 1ns / 1ps

module datapath_tb;

	// Inputs
	reg [15:0] ioIn;

	// Outputs
	wire [15:0] ioOut;

	// Instantiate the Unit Under Test (UUT)
	datapath uut (
		.ioIn(60), 
		.ioOut(ioOut)
	);

	initial begin
		// Initialize Inputs

		// Wait 100 ns for global reset to finish
		#100;
      

	end
      
endmodule

