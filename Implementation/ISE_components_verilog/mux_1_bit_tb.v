`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:26:38 01/22/2019
// Design Name:   mux_1_bit
// Module Name:   C:/Users/eckelsjd/Documents/RHIT/sophomore/winter/CSSE232/ISE_components_verilog/mux_1_bit_tb.v
// Project Name:  ISE_components_verilog
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux_1_bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mux_1_bit_tb;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg S;

	// Outputs
	wire [15:0] R;

	// Instantiate the Unit Under Test (UUT)
	mux_1_bit uut (
		.A(A), 
		.B(B), 
		.S(S), 
		.R(R)
	);

	initial begin
		// Initialize Inputs
		A = 0; 
		B = 0;
		S = 0;
		
		#10 A = 0;
		#10 B = 1;
		
		#10 A = 1;
		#10 B = 0;
		
		#10 S = 1;
		
		#10 A = 0;
		#10 B = 1;
		
		#10 A = 1;
		#10 B = 0;
		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

