`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:14:24 01/22/2019
// Design Name:   adder_16_bit
// Module Name:   C:/Users/eckelsjd/Documents/RHIT/sophomore/winter/CSSE232/ISE_components_verilog/adder_16_bit_tb.v
// Project Name:  ISE_components_verilog
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: adder_16_bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module adder_16_bit_tb;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;

	// Outputs
	wire [15:0] R;

	// Instantiate the Unit Under Test (UUT)
	adder_16_bit uut (
		.A(A), 
		.B(B), 
		.R(R)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		
		#10 A = 5;
			 B = 5;
		
		#10 A = 100;
		    B = 200;
		
		#10 A = 1;
		    B = 1; 
		
		#10 A = 10;
		    B = 17;
		
		#10 A = 69;
		    B = 69;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

