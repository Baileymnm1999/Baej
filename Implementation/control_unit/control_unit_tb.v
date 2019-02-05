`timescale 1ns / 1ps

module control_unit_tb;

	// Inputs
	reg [3:0] A;
	reg clk;
	
	// Outputs
	wire PCsrc;
	wire writePC;
	wire writeRA;
	wire ImRPC;
	wire MemSrc;
	wire MemW1;
	wire MemW2;
	wire MemR1;
	wire MemR2;
	wire writeCR;
	wire [1:0] RegSrc;
	wire writeImR;
	wire backup;
	wire restore;
	wire RegW1;
	wire RegW2;
	wire RegR1;
	wire RegR2;
	wire ALUsrc;
	wire [3:0] ALUop;
	wire cmpeq;
	wire cmpne;

	// Instantiate the Unit Under Test (UUT)
	control_unit uut (
		.A(A), 
		.clk(clk),
		.PCsrc(PCsrc), 
		.writePC(writePC), 
		.writeRA(writeRA), 
		.ImRPC(ImRPC), 
		.MemSrc(MemSrc), 
		.MemW1(MemW1), 
		.MemW2(MemW2), 
		.MemR1(MemR1), 
		.MemR2(MemR2), 
		.writeCR(writeCR), 
		.RegSrc(RegSrc), 
		.writeImR(writeImR), 
		.backup(backup), 
		.restore(restore), 
		.RegW1(RegW1), 
		.RegW2(RegW2), 
		.RegR1(RegR1), 
		.RegR2(RegR2), 
		.ALUsrc(ALUsrc), 
		.ALUop(ALUop), 
		.cmpeq(cmpeq), 
		.cmpne(cmpne)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
		A = 0;
        
		repeat (15) begin
			A = A + 1;
			#5;
		end

	end
	
	always clk = #1 ~clk;
      
endmodule

