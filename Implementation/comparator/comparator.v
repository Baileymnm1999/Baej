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
	 input ControlSignal,
    output [15:0] R
    ); 

		assign R = (A == B) && ControlSignal;
				
endmodule
