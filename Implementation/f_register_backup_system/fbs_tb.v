`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:52:03 02/05/2019
// Design Name:   fbs
// Module Name:   C:/Users/tuey/Desktop/CSSE232/project/3B-dripchar-eckelsjd-morganbm-tuey/Implementation/f_register_backup_system/fbs_tb.v
// Project Name:  f_register_backup_system
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fbs
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fbs_tb;

	// Inputs
	reg clk;
	reg backup;
	reg restore;
	reg [255:0] dataIn;

	// Outputs
	wire [255:0] dataOut;
	wire restoreOut;

  // Counters (for the test)
  reg [255:0] expectedRestoreValue;
	// Instantiate the Unit Under Test (UUT)
	fbs uut (
		.clk(clk), 
		.backup(backup), 
		.restore(restore), 
		.dataIn(dataIn), 
		.dataOut(dataOut), 
		.restoreOut(restoreOut)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		backup = 0;
		restore = 0;
		dataIn = 0;

    expectedRestoreValue = 1;
		// Wait 100 ns for global reset to finish
		#100;
        
		$display("TEST START ----------------");
    dataIn = 15;
    repeat (15) begin
      // let some data in
      #1;
      backup = 1;
      #1;
      backup = 0;
      dataIn = dataIn - 1;
    end
    repeat (15) begin
      // let some data out
      restore = 1;
      if (expectedRestoreValue == dataOut)
        $display("Expected = %d dataOut = %d PASSED \n", expectedRestoreValue, dataOut);
      else
        $display("Expected = %d dataOut = %d FAILED \n", expectedRestoreValue, dataOut);
      #1;
      restore = 0;
      #1;
      
      expectedRestoreValue = expectedRestoreValue + 1;
    end

	end
  always clk = #0.5 ~clk;
endmodule

