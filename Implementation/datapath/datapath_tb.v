`timescale 1ns / 1ps

module datapath_tb;

	// Inputs
	reg [15:0] ioIn;
	reg reset;

	// Outputs
	wire [15:0] ioOut;

	// Instantiate the Unit Under Test (UUT)
	datapath uut (
		.reset(reset),
		.ioIn(ioIn), 
		.ioOut(ioOut)
	);

	initial begin
		// Initialize Inputs
		reset = 1;
		ioIn = 60;
		#0.2;
		reset = 0;

		// Wait 100 ns for global reset to finish
		/*#500;
		
		reset = 1;
		ioIn = 60;
		#0.2;
		reset = 0;
		*/
      

	end
      
endmodule

