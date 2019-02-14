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
		
		// 4 sets of tests stored in memory. Go to mem_unit.v file and uncomment the code block for the desired test.
		
		// Test 1 - Individual instruction test
			//(not completed yet)
			
		// Test 2 - Add 10 program
		
		// Test 3 - RelPrime program
		reset = 1;
		ioIn = 5040;
		#0.2;
		reset = 0;
		
		// Test 4 - Recursive function program
		
	end
	
	//always if(ioOut == 11) $finish;
      
endmodule

