`include "..\v02\ch02.v"

module DFF (input in, clock, output out);
  reg q;
  assign out = q;
  always @(posedge clock) begin
    q = in;
  end
endmodule

module Bit(input in, clock, load, output out);
    wire md;
    Mux g0(out, in, load, md);
    DFF g1(md, clock, out);
endmodule

module Register(input[0:15] in, input clock, load, output[0:15]out);
    Bit g0(in[0], clock, load, out[0]);
	Bit g1(in[1], clock, load, out[1]);
	Bit g2(in[2], clock, load, out[2]);
	Bit g3(in[3], clock, load, out[3]);
	Bit g4(in[4], clock, load, out[4]);
	Bit g5(in[5], clock, load, out[5]);
	Bit g6(in[6], clock, load, out[6]);
	Bit g7(in[7], clock, load, out[7]);
	Bit g8(in[8], clock, load, out[8]);
	Bit g9(in[9], clock, load, out[9]);
	Bit g10(in[10], clock, load, out[10]);
	Bit g11(in[11], clock, load, out[11]);
	Bit g12(in[12], clock, load, out[12]);
	Bit g13(in[13], clock, load, out[13]);
	Bit g14(in[14], clock, load, out[14]);
	Bit g15(in[15], clock, load, out[15]);
endmodule

module PC(input[15:0] in, input clock, load, inc, reset, output[15:0] out);
  wire[15:0] if1, if2, if3, oInc, o;
  
  Or g1(load, inc, loadInc);
  Or g2(loadInc, reset, loadIncReset);

  Inc16 inc1(o, oInc);
  And16 g3(o, o, out);
  
  Mux16 g4(o,   oInc,  inc,   if1);
  Mux16 g5(if1, in,    load,  if2);
  Mux16 g6(if2, 16'b0, reset, if3);

  Register reg1(if3, clock, loadIncReset, o);
endmodule


module RAM8(input[0:15]in, input clock, load, input[0:2] address, output[0:15] out);
    wire [0:15] s0, s1, s2, s3, s4, s5, s6, s7;
    DMux8Way g0(load, address, r0, r1, r2, r3, r4, r5, r6, r7);
    Register g1(in, clock, r0, s0);
    Register g2(in, clock, r1, s1);
    Register g3(in, clock, r2, s2);
    Register g4(in, clock, r3, s3);
    Register g5(in, clock, r4, s4);
    Register g6(in, clock, r5, s5);
    Register g7(in, clock, r6, s6);
    Register g8(in, clock, r7, s7);
    Mux8Way16 g9(s0, s1, s2, s3, s4, s5, s6, s7, address, out);
endmodule

module RAM64(input[0:15] in, input clock, load, input[0:5]address, output[0:15] out);
    wire [0:15] s0, s1, s2, s3, s4, s5, s6, s7;
    DMux8Way g0(load, address[3:5], r0, r1, r2, r3, r4, r5, r6, r7);
    RAM8 g1(in, clock, r0, address[0:2], s0);
    RAM8 g2(in, clock, r1, address[0:2], s1);
    RAM8 g3(in, clock, r2, address[0:2], s2);
    RAM8 g4(in, clock, r3, address[0:2], s3);
    RAM8 g5(in, clock, r4, address[0:2], s4);
    RAM8 g6(in, clock, r5, address[0:2], s5);
    RAM8 g7(in, clock, r6, address[0:2], s6);
    RAM8 g8(in, clock, r7, address[0:2], s7);
    Mux8Way16 g9(s0, s1, s2, s3, s4, s5, s6, s7, address[3:5], out);
endmodule

module RAM512(input[0:15] in, input clock, load, input[0:8] address, output[0:15] out);
    wire [0:15] s0, s1, s2, s3, s4, s5, s6, s7;
    DMux8Way g0(load, address[6:8], r0, r1, r2, r3, r4, r5, r6, r7);
    RAM64 g1(in, clock, r0, address[0:5], s0);
    RAM64 g2(in, clock, r1, address[0:5], s1);
    RAM64 g3(in, clock, r2, address[0:5], s2);
    RAM64 g4(in, clock, r3, address[0:5], s3);
    RAM64 g5(in, clock, r4, address[0:5], s4);
    RAM64 g6(in, clock, r5, address[0:5], s5);
    RAM64 g7(in, clock, r6, address[0:5], s6);
    RAM64 g8(in, clock,  r7, address[0:5], s7);
    Mux8Way16 g9(s0, s1, s2, s3, s4, s5, s6, s7, address[6:8], out);
endmodule

module RAM4K(input[15:0] in, input[11:0] address, input clock, load, output[15:0] out);
    reg[15:0] m[0:2**12-1];

    assign out = m[address];

    always @(posedge clock) begin
        if (load) m[address] = in;
    end
endmodule

module RAM16K(input[15:0] in, input[13:0] address, input clock, load, output[15:0] out);
    reg[15:0] m[0:2**14-1];

    assign out = m[address];

    always @(posedge clock) begin
        if (load) m[address] = in;
    end
endmodule