`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:18:46 01/30/2019
// Design Name:   comparator
// Module Name:   C:/Users/dripchar/Documents/Classes/CSSE232/3B-dripchar-eckelsjd-morganbm-tuey/Implementation/comparator/comparator_tb.v
// Project Name:  comparator
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: comparator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module comparator_tb;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg cmpEq;
	reg cmpNq;
	reg clk;

	// Outputs
	wire [15:0] R;

	// Instantiate the Unit Under Test (UUT)
	comparator uut (
		.A(A), 
		.B(B), 
		.cmpEq(cmpEq), 
		.cmpNq(cmpNq), 
		.clk(clk),
		.R(R)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		cmpEq = 0;
		cmpNq = 0;
		clk = 1; 

		// Wait 100 ns for global reset to finish
		#100;
		
		
		repeat (32) begin 
        cmpEq = 1;
		  cmpNq = 0;
		  #2;
		  
		  	if(R == 1) begin
				$display("PASS");
			end else begin
				$display("FAIL");
			end
			
			A = A + 1; 
			#1;
			
			if(R == 0) begin
				$display("PASS");
			end else begin
				$display("FAIL");
			end
			
			cmpNq = 1;
			cmpEq = 0;
			#2;
			
			if(R == 1) begin
				$display("PASS");
			end else begin
				$display("FAIL");
			end
			
			B = B + 1; 
			#1; 
			
			if(R == 0) begin
				$display("PASS");
			end else begin
				$display("FAIL");
			end		
	
		end
	end
	
	always clk = #0.5 ~clk;
      
endmodule
