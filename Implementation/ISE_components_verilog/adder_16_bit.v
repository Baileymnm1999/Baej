`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:10:01 01/22/2019 
// Design Name: 
// Module Name:    adder_16_bit 
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
module adder_16_bit(
    input [15:0] A,
    input [15:0] B,
    output [15:0] R
    );
	 
	 assign R=A+B;


endmodule
