`include "..\02\ch02.v"

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
    Bit g0(in=in[0], clock, load, out[0]);
	Bit g1(in=in[1], clock, load, out[1]);
	Bit g2(in=in[2], clock, load, out[2]);
	Bit g3(in=in[3], clock, load, out[3]);
	Bit g4(in=in[4], clock, load, out[4]);
	Bit g5(in=in[5], clock, load, out[5]);
	Bit g6(in=in[6], clock, load, out[6]);
	Bit g7(in=in[7], clock, load, out[7]);
	Bit g8(in=in[8], clock, load, out[8]);
	Bit g9(in=in[9], clock, load, out[9]);
	Bit g10(in=in[10], clock, load, out[10]);
	Bit g11(in=in[11], clock, load, out[11]);
	Bit g12(in=in[12], clock, load, out[12]);
	Bit g13(in=in[13], clock, load, out[13]);
	Bit g14(in=in[14], clock, load, out[14]);
	Bit g15(in=in[15], clock, load, out[15]);
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
    wire r0, r1, r2, r3, r4, r5, r6, r7, s0, s1, s2, s3, s4, s5, s6, s7;
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
    wire r0, r1, r2, r3, r4, r5, r6, r7, s0, s1, s2, s3, s4, s5, s6, s7;
    DMux8Way g0(load, address[3:5], r0, r1, r2, r3, r4, r5, r6, r7);
    RAM8 g1(in, clock, r0, address[0..2], out=s0);
    RAM8 g2(in, clock, r1, address[0..2], out=s1);
    RAM8 g3(in, clock, r2, address[0..2], out=s2);
    RAM8 g4(in, clock, r3, address[0..2], out=s3);
    RAM8 g5(in, clock, r4, address[0..2], out=s4);
    RAM8 g6(in, clock, r5, address[0..2], out=s5);
    RAM8 g7(in, clock, r6, address[0..2], out=s6);
    RAM8 g8(in, clock, r7, address[0..2], out=s7);
    Mux8Way16 g9(s0, s1, s2, s3, s4, s5, s6, s7, address[3..5], out=out);
endmodule

module RAM512(input[0:15] in, input clock, load, input[0:8] address, output[0:15] out);
    wire r0, r1, r2, r3, r4, r5, r6, r7, s0, s1, s2, s3, s4, s5, s6, s7;
    DMux8Way g0(in=load, sel=address[6..8], a=r0, b=r1, c=r2, d=r3, e=r4, f=r5, g=r6, h=r7);
    RAM64 g1(in=in, load=r0, address=address[0..5], out=s0);
    RAM64 g2(in=in, load=r1, address=address[0..5], out=s1);
    RAM64 g3(in=in, load=r2, address=address[0..5], out=s2);
    RAM64 g4(in=in, load=r3, address=address[0..5], out=s3);
    RAM64 g5(in=in, load=r4, address=address[0..5], out=s4);
    RAM64 g6(in=in, load=r5, address=address[0..5], out=s5);
    RAM64 g7(in=in, load=r6, address=address[0..5], out=s6);
    RAM64 g8(in=in, load=r7, address=address[0..5], out=s7);
    Mux8Way16 g9(a=s0, b=s1, c=s2, d=s3, e=s4, f=s5, g=s6, h=s7, sel=address[6..8], out=out);
endmodule

module RAM4K(input[0:15] in, input clock, load, input[0:11] address, input[0:15] out);
    wire r0, r1, r2, r3, r4, r5, r6, r7, s0, s1, s2, s3, s4, s5, s6, s7;
    DMux8Way g0(in=load, sel=address[9..11], a=r0, b=r1, c=r2, d=r3, e=r4, f=r5, g=r6, h=r7);
    RAM512 g1(in=in, load=r0, address=address[0..8], out=s0);
    RAM512 g2(in=in, load=r1, address=address[0..8], out=s1);
    RAM512 g3(in=in, load=r2, address=address[0..8], out=s2);
    RAM512 g4(in=in, load=r3, address=address[0..8], out=s3);
    RAM512 g5(in=in, load=r4, address=address[0..8], out=s4);
    RAM512 g6(in=in, load=r5, address=address[0..8], out=s5);
    RAM512 g7(in=in, load=r6, address=address[0..8], out=s6);
    RAM512 g8(in=in, load=r7, address=address[0..8], out=s7);
    Mux8Way16 g9(a=s0, b=s1, c=s2, d=s3, e=s4, f=s5, g=s6, h=s7, sel=address[9..11], out=out);
endmodule

module RAM16K(input[0:15] in, input clock, load, input[0:13]address, output[0:15]out);
    wire r0, r1, r2, r3, s0, s1, s2, s3
    DMux4Way g0(in=load, sel=address[12..13], a=r0, b=r1, c=r2, d=r3);
    RAM4K g1(in=in, load=r0, address=address[0..11], out=s0);
    RAM4K g2(in=in, load=r1, address=address[0..11], out=s1);
    RAM4K g3(in=in, load=r2, address=address[0..11], out=s2);
    RAM4K g4(in=in, load=r3, address=address[0..11], out=s3);
    Mux4Way16 g5(a=s0, b=s1, c=s2, d=s3, sel=address[12..13], out=out);
endmodule