`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Team 3B
// 
// Create Date:    17:42:22 01/21/2019 
// Design Name: 
// Module Name:    comparator 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module comparator(
    input [15:0] A,
    input [15:0] B,
	 input cmpEq,
	 input cmpNq,
    output reg R
    ); 

	 always begin	
		if(cmpEq) begin
			assign R = (A == B);
		end
		if(cmpNq) begin
			assign R = (A != B);
		end
		
	end
		
		
		
				
endmodule
