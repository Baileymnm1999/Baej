`timescale 1ns / 1ps

module control_unit(
    input [3:0] A,
	 input clk,
    output reg PCsrc,
    output reg writePC,
    output reg writeRA,
    output reg ImRPC,
    output reg MemSrc,
    output reg MemW1,
    output reg MemW2,
    output reg MemR1,
    output reg MemR2,
    output reg writeCR,
    output reg [1:0] RegSrc,
    output reg writeImR,
    output reg backup,
    output reg restore,
    output reg RegW1,
    output reg RegW2,
    output reg RegR1,
    output reg RegR2,
    output reg ALUsrc,
    output reg [3:0] ALUop,
    output reg cmpeq,
	 output reg cmpne
    );

	always @ (posedge clk) begin
	 
	// reset
	assign PCsrc = 0;
   assign writePC = 0;
   assign writeRA = 0;
   assign ImRPC = 0;
   assign MemSrc = 0;
   assign MemW1 = 0;
   assign MemW2 = 0;
   assign MemR1 = 0;
   assign MemR2 = 0;
   assign writeCR = 0;
   assign RegSrc = 0;
   assign writeImR = 0;
   assign backup = 0;
   assign restore = 0;
   assign RegW1 = 0;
   assign RegW2 = 0;
   assign RegR1 = 0;
   assign RegR2 = 0;
   assign ALUsrc = 0;
   assign ALUop = 0;
   assign cmpeq = 0;
	assign cmpne = 0;
	
	// initialize
	assign PCsrc = 0;
	assign writePC = 1;
	assign MemSrc = 0;
	assign MemR1 = 1;
	assign MemR2 = 1;
	assign writeImR = 1;
	
	case (A)
		// lda
		0: begin
			assign writeCR = 0;
		   assign RegR1 = 1;
			assign RegR2 = 1;
			assign ALUsrc = 0;
			assign ALUop = 2;
			assign MemR2 = 1;
			assign MemSrc = 1;
			assign RegSrc = 1;
			assign RegW2 = 1;
			end
			
		// ldi
		1: begin
			assign writeCR = 0;
			assign RegR1 = 1;
			assign RegR2 = 1;
			assign RegSrc = 0;
			assign RegW2 = 1;
			end
			
		// str
		2: begin
			assign writeCR = 0;
			assign RegR1 = 1;
			assign RegR2 = 1;
			assign ALUsrc = 0;
			assign ALUop = 2;
			assign MemSrc = 1;
			assign MemW2 = 1;
			end
		
		// bop
		3: begin 
			assign writePC = 1;
			assign PCsrc = 0;
			assign ImRPC = 1;
			// delay = 1;
			end
		
		// cal
		4: begin
			assign writePC = 1;
		   assign writeRA = 1;
			assign ImRPC = 0;
			assign PCsrc = 0;
			assign backup = 1;
			end
		
		// beq
		5: begin
			assign writeCR = 0;
			assign RegR1 = 1;
			assign RegR2 = 1;
			assign cmpeq = 1;
			assign PCsrc = 0;
			end
			
		// bne
		6: begin 
			assign writeCR = 0;
			assign RegR1 = 1;
			assign RegR2 = 1;
			assign cmpne = 1;
			assign PCsrc = 0;
			end
		
		// sft
		7: begin
			assign writeCR = 0;
			assign RegR1 = 1;
			assign RegR2 = 1;
			assign ALUsrc = 0;
			assign ALUop = 4;
			assign RegSrc = 2;
			assign RegW2 = 1;
			end
		
		// cop
		8: begin
			assign writeCR = 0;
		   assign RegR1 = 1;
			assign RegR2 = 1;
			assign RegSrc = 3;
			assign RegW2 = 1;
			end
		
		// empty
		9: begin
			end
		
		// slt
		10: begin
			 assign ALUsrc = 1;
		    assign ALUop = 5;
			 assign writeCR = 1;
			 assign RegW1 = 1;
			 end
		
		// ret
		11: begin
			 assign writePC = 1;
			 assign PCsrc = 1;
			 assign restore = 1;
			 end
		
		// add
		12: begin
			 assign ALUsrc = 1;
		    assign ALUop = 2;
			 assign RegSrc = 2;
			 assign RegW2 = 1;
			 end
			 
		// sub
		13: begin
			 assign ALUsrc = 1;
		    assign ALUop = 3;
			 assign RegSrc = 2;
			 assign RegW2 = 1;
			 end
		
		// and
		14: begin
			 assign ALUsrc = 1;
		    assign ALUop = 0;
			 assign RegSrc = 2;
			 assign RegW2 = 1;
			 end
		
		// orr
		15: begin
			 assign ALUsrc = 1;
		    assign ALUop = 1;
			 assign RegSrc = 2;
			 assign RegW2 = 1;
			 end
			 
	endcase
	
	end
	
endmodule
