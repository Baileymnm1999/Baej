`timescale 1ns / 1ps

module arithmetic_logic_system_tb;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg [15:0] Imm;
	reg ALUsrc;
	reg [2:0] ALUop;
	reg clk;

	// Outputs
	wire AltB;
	wire [15:0] ALUout;

	// Instantiate the Unit Under Test (UUT)
	arithmetic_logic_system uut (
		.A(A), 
		.B(B), 
		.Imm(Imm), 
		.ALUsrc(ALUsrc), 
		.ALUop(ALUop), 
		.clk(clk), 
		.AltB(AltB), 
		.ALUout(ALUout) 
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		Imm = 0;
		ALUsrc = 0;
		ALUop = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		// And
		$display("AND:");
		ALUop = 0;
		ALUsrc = 1;
		A = -10;
		B = -10;
		Imm = 10;
		#1;
		repeat (20) begin
			repeat (20) begin
				A = A + 1;
				Imm = Imm - 1;
				#5;
				if ((A & B) == ALUout) begin
					$display("PASS AND");
				end
				else begin
					$display("FAIL: %b & %b = %b",A,B,ALUout);
				end
			end
			A = -10;
			B = B + 1;
			#5;
		end

	end
	
	always clk = #1 ~clk;
      
endmodule

