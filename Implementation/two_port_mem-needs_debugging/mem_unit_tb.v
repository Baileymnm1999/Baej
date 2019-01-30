`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:10:45 01/28/2019
// Design Name:   amemory16x1k
// Module Name:   C:/Users/tuey/Documents/f/mem/mem_unit_tb.v
// Project Name:  mem
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: amemory16x1k
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mem_unit_tb;
	// Inputs
	reg [15:0] DataIn_1;
	reg [15:0] DataIn_2;
	reg [15:0] Address_1;
	reg [15:0] Address_2;
	reg WriteEna_1;
	reg WriteEna_2;
	reg ReadEna_1;
	reg ReadEna_2;
	reg CLK;
	
	reg testVal;

	// Outputs
	wire [15:0] DataOut_1;
	wire [15:0] DataOut_2;

	// Instantiate the Unit Under Test (UUT)
	amemory16x1k uut (
		.DataIn_1(DataIn_1), 
		.DataIn_2(DataIn_2), 
		.DataOut_1(DataOut_1), 
		.DataOut_2(DataOut_2), 
		.Address_1(Address_1), 
		.Address_2(Address_2), 
		.WriteEna_1(WriteEna_1), 
		.WriteEna_2(WriteEna_2), 
		.ReadEna_1(ReadEna_1), 
		.ReadEna_2(ReadEna_2), 
		.CLK(CLK)
	);

	initial begin
		// Initialize Inputs
		DataIn_1 = 0;
		DataIn_2 = 0;
		Address_1 = 0;
		Address_2 = 0;
		WriteEna_1 = 1;
		WriteEna_2 = 1;
		ReadEna_1 = 1;
		ReadEna_2 = 1;
		CLK = 0;
		testVal = 100;

		// Wait 100 ns for global reset to finish
		#100;
      
		// Write address_1 into all 2^16 addresses
		$display("Port1");
		repeat (16) begin // Should be 2 ^ 16
			testVal = 100;
			repeat (16) begin
				DataIn_1 <= testVal;
		   
				#5;
				CLK = ~CLK; 
				#5;
				CLK = ~CLK; 
				
				if (DataOut_1 == testVal)
					$display("address = %h; actual = %h; expected = %h PASSED \n", Address_1, DataOut_1, testVal);
				else
					$display("address = %h; actual = %h; expected = %h FAILED \n", Address_1, DataOut_1, testVal);
					
				testVal = testVal - 1;
			end
			Address_1 = Address_1 + 1;
		end
		
		// TODO: Do the exact same thing, but for Address 2
   end
endmodule

