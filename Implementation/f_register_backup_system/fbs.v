`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:39:29 02/05/2019 
// Design Name: 
// Module Name:    fbs 
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
module fbs(
  input clk,
  input backup,
  input restore,
  input [255:0] dataIn,
  
  output [255:0] dataOut,
  output restoreOut,
  output [15:0] fcc
);

  reg [15:0] FCCreg;

  wire [15:0] IorD_R, fccAdder_R, fcacheSrc_R;
  
  adder_16_bit fccAdder(
    .A(IorD_R),
    .B(FCCreg),
    .R(fccAdder_R)
    );

  // Controls FCC inc or dec
  mux_1_bit IorD(
    .A(-1),
    .B(1),
    .S(backup),
    .R(IorD_R)
    );
  
  // Controls FCC + 1 or FCC
  mux_1_bit fcacheSrc (
    .A(fccAdder_R),
    .B(FCCreg),
    .S(backup),
    .R(fcacheSrc_R)
  );

  fcache FCache (
    .clk(clk),
    .write(backup),
    .addr(fcacheSrc_R),
    .wData(dataIn),
    .rData(dataOut)    
  );

	assign restoreOut = restore;
	assign fcc = FCCreg;

	initial begin
    FCCreg = 0;
	end

	always @(posedge clk) begin
		if(backup | restore) FCCreg <= fccAdder_R;
	end
	
endmodule
