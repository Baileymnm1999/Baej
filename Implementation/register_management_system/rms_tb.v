`timescale 1ns / 1ps

module rms_tb;

	// Inputs
	reg clk;
	reg [15:0] IR;
	reg [15:0] ImR;
	reg [15:0] w2_1;
	reg [15:0] w2_2;
	reg AltB;
	reg writeCR;
	reg [1:0] Regsrc;
	reg RegR1;
	reg RegR2;
	reg RegW1;
	reg RegW2;
	reg restore;
	reg [239:0] fcIn;
	reg [15:0] ioIn;
	reg cmpne;
	reg cmpeq;

	// Outputs
	wire [15:0] ioOut;
	wire [3:0] op;
	wire [239:0] fcOut;
	wire [15:0] A;
	wire [15:0] B;
	wire [15:0] immediate;
	wire cmp_result;

	// Instantiate the Unit Under Test (UUT)
	rms uut (
		.clk(clk), 
		.IR(IR), 
		.ImR(ImR), 
		.w2_1(w2_1), 
		.w2_2(w2_2), 
		.AltB(AltB), 
		.writeCR(writeCR), 
		.Regsrc(Regsrc),  
		.RegR1(RegR1), 
		.RegR2(RegR2), 
		.RegW1(RegW1), 
		.RegW2(RegW2), 
		.restore(restore), 
		.fcIn(fcIn), 
		.ioIn(ioIn), 
		.cmpne(cmpne), 
		.cmpeq(cmpeq),
		.ioOut(ioOut), 
		.op(op), 
		.fcOut(fcOut), 
		.A(A), 
		.B(B), 
		.immediate(immediate), 
		.cmp_result(cmp_result)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		IR = 0;
		ImR = 0;
		w2_1 = 0;
		w2_2 = 0;
		AltB = 0;
		writeCR = 0;
		Regsrc = 0;
		RegR1 = 0;
		RegR2 = 0;
		RegW1 = 0;
		RegW2 = 0;
		restore = 0;
		fcIn = 0;
		ioIn = 0;
		cmpne = 0;
		cmpeq = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		//fill register file with values
		RegW2 = 1;
		repeat(64) begin
			IR = IR + 1;
			ImR = ImR + 1;
			#1;
		end
		
		//test CR mux
		
		//test Regsrc mux
		
		//test w1->r1
		
		//test w2->r2
		
		//test restore
		
		//test comparator
		
		//test io regs

	end
	
	always clk = #0.5 ~clk;
      
endmodule

