`timescale 1ns / 1ps

module rms(
    input [15:0] IR_in,
    input [15:0] ImR_in,
    input [15:0] memOut_in,
    input writeImR,
    input AltB,
    input writeCR, // controls mux_1_bit
    input RegSrc, // controls mux_2_bit
    input RegR1,
    input RegR2,
    input RegW1,
    input RegW2,
    
    input restore,
    input [239:0] fcIn,
    input [15:0] ALUout_in,
    input cmpne,
    input cmpeq,
	  input [15:0] ioIn,

	  output [15:0] ioOut,
    output [3:0] op,
    output [239:0] fcOut,
    output [15:0] A,
    output [15:0] B,
    output [15:0] immediate,
    output cmp_result
    );
	 
	 reg [15:0] IR, ImR, Memout, A_reg, B_reg;
	 wire [15:0] imm_wire, memout_wire, writeCR_mux_wire, regsrc_mux_wire, r1_wire, r2_wire, A_wire, B_wire;
	 
regfile16b64 regfile(
	.a1(writeCR_mux_wire),
	.a2(IR_in [5:0]),
	.w1(AltB),
	.w2(regsrc_mux_wire),
	.fcIn(fcIn),
	.ioIn(ioIn),
	.w1Control(RegW1),
	.w2Control(RegW2),
	.r1Control(RegR1),
	.r2Control(RegR2),
	.restore(restore),
	.clk(clk),
	.r1(A_wire),
	.r2(B_wire),
	.ioOut(ioOut),
	.fcOut(fcOut)
	);
	
mux_1_bit reg_a1_src (
	.A(IR_in [11:6]),
	.B(57),
	.S(writeCR),
	.R(writeCR_mux_wire)
	);

mux_2_bit reg_w2_src (
  .A(ImR_in),
  .B(memOut_in),
  .C(ALUout_in),
  .D(A_wire),
  .S(RegSrc),
  .R(regsrc_mux_wire)
);

always @(posedge clk) begin 

end

//	 input [15:0] A,
//    input [15:0] B,
//    input [15:0] Imm,
//    input ALUsrc,
//    input [2:0] ALUop,
//	 input clk,
//    output AltB,
//    output [15:0] ALUout
//    );
//
//	 wire [15:0] mux_out, alu_out;
//	 wire a_ltb;
//	 reg [15:0] ALUout_reg;
//	 reg AltB_reg;
//	 
//alu_16_bit alu(
//	.A(A),
//	.B(mux_out),
//	.op(ALUop),
//	.R(alu_out),
//	.AltB(a_ltb)
//	);
//	
//mux_1_bit alu_mux(
//	.A(Imm), 
//	.B(B),
//	.S(ALUsrc),
//	.R(mux_out)
//	);
//	
//	assign ALUout = ALUout_reg;
//	assign AltB = AltB_reg;
//	
//	always @(posedge clk) begin
//		ALUout_reg = alu_out;
//		AltB_reg = a_ltb;
//	end

	 


endmodule
