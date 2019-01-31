`timescale 1ns / 1ps


module pcs(
	 input clk,
    input writePC,
    input writeRA,
    input PCsrc,
    input ImRPC,
    input conditionalBop,
    input [15:0] ImR,
    output [15:0] PC,
    output [15:0] PC_1
    );
	 
	 wire[15:0] PC_1wire, PCsrcWire, PCsrcOpt0, PCsrcOpt1;
	 reg[15:0] PCreg, RAreg, add1;
	 
adder_16_bit pcAdder(
	.A(PCreg),
	.B(add1),
	.R(PC_1wire)
	);

mux_1_bit PCsrcMux(
	.A(PCsrcOpt0),
	.B(RAreg),
	.S(PCsrc),
	.R(PCsrcWire)
	);
	
mux_1_bit ImRMux(
	.A(PC_1wire),
	.B(ImR),
	.S(ImRPC | conditionalBop),
	.R(PCsrcOpt0)
	);
	
	assign PC = PCreg;
	assign PC_1 = PC_1wire;
	
	initial begin
		PCreg = 0;
		RAreg = 0;
		add1 = 1;
	end
	
	always @(posedge clk) begin
		if (writePC) PCreg = PCsrcWire;
		if (writeRA) RAreg = PC_1wire;
		
	end
		


endmodule
