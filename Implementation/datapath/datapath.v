`timescale 1ns / 1ps

module datapath(
    input [15:0] ioIn,
    output [15:0] ioOut,
	 output [4:0] current,
	 output [4:0] next
    );
	 
	 reg clk = 1;
	 reg Reset = 1;
	 
	 // Control wires
	 wire PCsrc, writePC, writeRA, ImRPC, backup, restore, ALUsrc, cmpeq, cmpne, cmp_result;
	 wire [3:0] op;
	 wire [2:0] ALUop;	 
	 
	 // Memory control wires
	 wire Memsrc, MemW1, MemW2, MemR1, MemR2;
	 
	 // Register control wires
	 wire writeCR, RegW1, RegW2, RegR1, RegR2;
	 wire [1:0] Regsrc;
	 
	 // Moar wiress
	 wire [15:0] IR, ImR, Memout, B, ALUout, RArestore, RAbackup;
	 
	 
control_unit ctrl (
    .op(op),
	 .clk(clk),
	 .Reset(Reset),
    .PCsrc(PCsrc),
    .writePC(writePC),
    .writeRA(writeRA),
    .ImRPC(ImRPC),
    .Memsrc(Memsrc),
    .MemW1(MemW1),
    .MemW2(MemW2),
    .MemR1(MemR1),
    .MemR2(MemR2),
    .writeCR(writeCR),
    .Regsrc(Regsrc),
    .backup(backup),
    .restore(restore),
    .RegW1(RegW1),
    .RegW2(RegW2),
    .RegR1(RegR1),
    .RegR2(RegR2),
    .ALUsrc(ALUsrc),
    .ALUop(ALUop),
    .cmpeq(cmpeq),
	 .cmpne(cmpne),
	 .current_state(current),
	 .next_state(next)
	);
	 
pms prog_mgmt_sys (
	 .clk(clk),
	 .restore(restore),
    .writePC(writePC),
    .writeRA(writeRA),
    .PCsrc(PCsrc),
    .ImRPC(ImRPC),
    .Memsrc(Memsrc),
    .MemW1(MemW1),
    .MemW2(MemW2),
    .MemR1(MemR1),
    .MemR2(MemR2),
    .conditionalBop(cmp_result),
	 .RArestore(RArestore),
    .a2_1(ALUout),
    .write2(B),
    .IR(IR),
    .ImR(ImR),
    .Memout(Memout),
	 .RA(RAbackup)
	);
	
ies inst_exec_sys (
    .clk(clk),
    .backup(backup),
    .restore(restore),
    .writeCR(writeCR),
    .Regsrc(Regsrc),
    .cmpeq(cmpeq),
    .cmpne(cmpne),
    .RegR1(RegR1),
    .RegR2(RegR2),
    .RegW1(RegW1),
    .RegW2(RegW2),
    .ALUsrc(ALUsrc),
    .ALUop(ALUop),
    .RAIn(RAbackup),
    .IR(IR),
    .ImR(ImR),
    .w2_1(Memout),
    .ioIn(ioIn),
	 .op(op),
    .ioOut(ioOut),
    .B(B),
    .ALUout(ALUout),
    .cmp_result(cmp_result),
    .RAOut(RArestore)
	);

	initial begin
	#0.1;
	Reset = 0;	
	end
	 
	always clk = #0.1 ~clk;

endmodule
