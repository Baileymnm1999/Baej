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
module amemory16x1k(DataIn_1,
						  DataIn_2,
						  DataOut_1,
                    DataOut_2,
                    Address_1,
						  Address_2,
						  WriteEna_1,
						  WriteEna_2,
						  ReadEna_1,
						  ReadEna_2,
                    CLK);
   
   // Definitions
`define MEM_DEPTH 65535
`define MEM_WIDTH 16
`define ADDR_SIZE 16

   // Inputs
   
   input [`MEM_WIDTH-1:0] DataIn_1;
	input [`MEM_WIDTH-1:0] DataIn_2;
	input [`ADDR_SIZE-1:0] Address_1;
	input [`MEM_WIDTH-1:0] Address_2;
	
   input                  CLK;

   // Outputs
   output reg [`MEM_WIDTH-1:0] DataOut_1;
	output reg [`MEM_WIDTH-1:0] DataOut_2;

   // Signals
	input						  WriteEna_1;
	input						  WriteEna_2;
   input						  ReadEna_1;
	input						  ReadEna_2;

   // The memory
   reg [`MEM_WIDTH-1:0] mem [`MEM_DEPTH-1:0];


   // Operations
   always @ (posedge CLK)
     begin
	    if (WriteEna_1)
          mem[Address_1] <= DataIn_1;
		
		 if (WriteEna_2)
			 mem[Address_2] <= DataIn_2;
			 
		 if (ReadEna_1)
			 DataOut_1 <= mem[Address_1];
     
		 if (ReadEna_2)
			 DataOut_2 <= mem[Address_2];
	  end
   
endmodule