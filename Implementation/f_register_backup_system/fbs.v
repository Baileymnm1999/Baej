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
  output restoreOut
);

  reg [15:0] FCCreg, add1, sub1;
  wire [255:0] fcache_R; // Result of fcache read

  wire [15:0] IorD_R, fccAdder_R, fcacheSrc_R;
  adder_16_bit fccAdder(
    .A(IorD_R),
    .B(FCCreg),
    .R(fccAdder_R)
    );

  // Controls FCC inc or dec
  mux_1_bit IorD(
    .A(sub1),
    .B(add1),
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
    .rData(fcache_R)    
  );

  assign dataOut = fcache_R;
  assign restoreOut = restore;

  initial begin
    FCCreg = 0;
    add1 = 1;
    sub1 = -1;
	end

  always @(posedge clk) begin
		if (backup | restore) FCCreg = fccAdder_R;	
	end
endmodule
