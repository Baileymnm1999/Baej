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
		
		// 3 sets of tests stored in memory. Go to mem_unit.v file and uncomment the $readmemb line for the desired test.
			
		// Test 1 - Add 10 program
		
		/*
		reset = 1;
		ioIn = 20;
		#0.2;
		reset = 0;
		#35000;
		if (ioOut == ioIn + 10) $display("PASS: add_10");
		else $display("FAIL: add_10");
		*/

		// Test 2 - RelPrime program
		
		
		reset = 1;
		ioIn = 5040;
		#0.2;
		reset = 0;
		#35000;  // 35 microseconds for full program execution
		if (ioOut == 11) $display("PASS: relPrime of %d",ioIn);
		else $display("FAIL: relPrime of %d", ioIn);
		
		
		// Test 3 - summation program
		
		/*
		reset = 1;
		ioIn = 350;
		#0.2;
		reset = 0;
		#35000;
		if (ioOut == (ioIn * (ioIn + 1)) / 2) $display("PASS: relPrime of %d",ioIn);
		else $display("FAIL: relPrime of %d", ioIn);
		*/
		
	end
      
endmodule

