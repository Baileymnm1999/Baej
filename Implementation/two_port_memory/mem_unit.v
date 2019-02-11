/*********************************************************/
// MODULE:      memory
//
// FILE NAME:   memory.v
// VERSION:     1.0
// DATE:        Created 21 Nov 2004
// AUTHOR:      J.P. Mellor
//
// DESCRIPTION: This module defines memory similar to ipcore
//              generated distributed memory, but which is easier
//              to load programs and data into.
//
/*********************************************************/
module amemory16x1k(W1,
						  W2,
						  R1,
                    R2,
                    A1,
						  A2,
						  Write1,
						  Write2,
						  Read1,
						  Read2,
                    clk);
   
   // Definitions
`define MEM_DEPTH 65535
`define MEM_WIDTH 16
`define ADDR_SIZE 16

   // Inputs
   
   input [`MEM_WIDTH-1:0] W1;
	input [`MEM_WIDTH-1:0] W2;
	input [`ADDR_SIZE-1:0] A1;
	input [`MEM_WIDTH-1:0] A2;
	
   input                 clk;

   // Outputs
   output reg [`MEM_WIDTH-1:0] R1;
	output reg [`MEM_WIDTH-1:0] R2;

   // Signals
	input						  Write1;
	input						  Write2;
   input						  Read1;
	input						  Read2;

   // The memory
   reg [`MEM_WIDTH-1:0] mem [`MEM_DEPTH-1:0];


   // Operations
   always @ (posedge clk)
     begin
	    if (Write1)
          mem[A1] <= W1;
		
		 if (Write2)
			 mem[A2] <= W2;
			 
		 if (Read1)
			 R1 <= mem[A1];
     
		 if (Read2)
			 R2 <= mem[A2];
	  end
	  
	  
	initial begin
	/*			Add 10 program
	mem[0] = 16'b0001000000010000; // ldi .op 10
	mem[1] = 16'b0000000000001010;
	mem[2] = 16'b1100001111010000; // add .io .op
	*/
	
	mem[0] = 16'b0001000000010000;//	ldi .op 2
	mem[1] = 16'b0000000000000010;
	mem[2] = 16'b0001000000000001;//	ldi .f1 1
	mem[3] = 16'b0000000000000001;
	mem[4] = 16'b1000001111101101;//	cop .ip .a0
	mem[5] = 16'b1000010000101110;//	cop .op .a1
	mem[6] = 16'b0100000000000000;//	cal gcd
	mem[7] = 16'b0000000000001111;	
	mem[8] = 16'b0101111010000001;//	beq .v0 .f1 end
	mem[9] = 16'b0000000000001101;	
	mem[10] = 16'b1100000001010000;//	add .f1 .op
	mem[11] = 16'b0011000000000000;//	bop loop
	mem[12] = 16'b0000000000000100;	
	mem[13] = 16'b0011000000000000;//	bop 32
	mem[14] = 16'b0000000000100000;	
	mem[15] = 16'b0110101101111111;//	bne .a0 .z0 cont
	mem[16] = 16'b0000000000010011;	
	mem[17] = 16'b1000101110111010;//	cop .a1 .v0
	mem[18] = 16'b1011000000000000;//	ret
	mem[19] = 16'b0101101110101101;//	beq .a1 .a0 done
	mem[20] = 16'b0000000000011110;	
	mem[21] = 16'b1010101110101101;//	slt .a1 .a0
	mem[22] = 16'b0101111001111111;//	beq .cr .z0 else
	mem[23] = 16'b0000000000011011;	
	mem[24] = 16'b1101101110101101;//	sub .a1 .a0
	mem[25] = 16'b0011000000000000;//	bop cont
	mem[26] = 16'b0000000000010011;	
	mem[27] = 16'b1101101101101110;//	sub .a0 .a1
	mem[28] = 16'b0011000000000000;//	bop cont
	mem[29] = 16'b0000000000010011;	
	mem[30] = 16'b1000101101111010;//	cop .a0 .v0
	mem[31] = 16'b1011000000000000;//	ret
	
	end
   
endmodule
