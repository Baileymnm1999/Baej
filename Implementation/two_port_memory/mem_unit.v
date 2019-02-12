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
`define MEM_DEPTH 1024//65535
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
	  
	//integer i;
	initial begin
	
	//for (i=0;i<`MEM_DEPTH;i=i+1)
   // mem[i] = 0;
	 
	//$readmemb("relPrime.mem", mem);
	 
	 /*
	  		//Test 1 - Individual instruction test (not completed yet)
	mem[0] = 16'b0000000000000001; // lda .f0[23] .f1
	mem[1] = 16'b0000000000010111;   
	mem[2] = 16'b0001000000000001; // ldi .f1 100
	mem[3] = 16'b0000000001100100;  
	mem[4] = 16'b0010000000000001; // str .f0[23] .f1
	mem[5] = 16'b0000000000010111;  
	mem[6] = 16'b0011000000000000; // bop 
	//mem[7] = 16'b0000000000000000;  
	//mem[8] = 16'b0000111100001111; // cal 
	mem[9] = 16'b0000111100001111;  
	mem[10] = 16'b0000111100001111; // beq 
	mem[11] = 16'b0000111100001111;  
	mem[12] = 16'b0000111100001111; // bne
	mem[13] = 16'b0000111100001111; 
	mem[14] = 16'b0000111100001111; // sft
	mem[15] = 16'b0000111100001111; 
	mem[16] = 16'b0000111100001111; // cop
	mem[17] = 16'b0000111100001111; // slt
	mem[18] = 16'b0000111100001111; // ret 
	mem[19] = 16'b0000111100001111; // add 
	mem[20] = 16'b0000111100001111; // sub
	mem[21] = 16'b0000111100001111; // and
	mem[22] = 16'b0000111100001111; // orr 

	mem[23] = 16'b0000000001000000; // 64
	
				//Test 2 - Add 10 program 
	mem[0] = 16'b0001000000010000; // ldi .op 10
	mem[1] = 16'b0000000000001010;
	mem[2] = 16'b1100001111010000; // add .io .op
	*/
	end
   
endmodule
