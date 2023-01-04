`include "..\v01\ch01.v"

module FullAdder (input a, b, c, output sum, carry);
    wire aXorb, d, aAndb;
    Xor g0(a, b, aXorb);
    Xor g1(aXorb,c,sum);
    And g2(aXorb,c,d);
    And g3(a,b,aAndb);
    Or g4(d,aAndb,carry);
endmodule

module HalfAdder (input a, b, output sum, carry);
    Xor g0(a, b, sum);
    And g1(a, b, carry);
endmodule

module Add16 (input[0:15] a, b, output[0:15] out);
    wire carry0, carry1, carry2, carry3, carry4, carry5, carry6, carry7, carry8, carry9, carry10, carry11, carry12, carry13, carry14, carry15;
    FullAdder g0(a[0], b[0], 0, carry0, out[0]);
    FullAdder g1(a[1], b[1], carry0, carry1, out[1]);
    FullAdder g2(a[2], b[2], carry1, carry2, out[2]);
    FullAdder g3(a[3], b[3], carry2, carry3, out[3]);
    FullAdder g4(a[4], b[4], carry3, carry4, out[4]);
    FullAdder g5(a[5], b[5], carry4, carry5, out[5]);
    FullAdder g6(a[6], b[6], carry5, carry6, out[6]);
    FullAdder g7(a[7], b[7], carry6, carry7, out[7]);
    FullAdder g8(a[8], b[8], carry7, carry8, out[8]);
    FullAdder g9(a[9], b[9], carry8, carry9, out[9]);
    FullAdder g10(a[10], b[10], carry9, carry10, out[10]);
    FullAdder g11(a[11], b[11], carry10, carry11, out[11]);
    FullAdder g12(a[12], b[12], carry11, carry12, out[12]);
    FullAdder g13(a[13], b[13], carry12, carry13, out[13]);
    FullAdder g14(a[14], b[14], carry13, carry14, out[14]);
    FullAdder g15(a[15], b[15], carry14, carry15, out[15]);
endmodule

module Inc16(input[0:15] in, output[0:15] out);
    wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16;
    HalfAdder g0(in[0],1,out[0],c1);
    HalfAdder g1(in[1],c1,out[1],c2);
    HalfAdder g2(in[2],c2,out[2],c3);
    HalfAdder g3(in[3],c3,out[3],c4);
    HalfAdder g4(in[4],c4,out[4],c5);
    HalfAdder g5(in[5],c5,out[5],c6);
    HalfAdder g6(in[6],c6,out[6],c7);
    HalfAdder g7(in[7],c7,out[7],c8);
    HalfAdder g8(in[8],c8,out[8],c9);
    HalfAdder g9(in[9],c9,out[9],c10);
    HalfAdder g10(in[10],c10,out[10],c11);
    HalfAdder g11(in[11],c11,out[11],c12);
    HalfAdder g12(in[12],c12,out[12],c13);
    HalfAdder g13(in[13],c13,out[13],c14);
    HalfAdder g14(in[14],c14,out[14],c15);
    HalfAdder g15(in[15],c15,out[15],c16);
endmodule

module ALU(input[15:0]x,y, input zx,nx,zy,ny,f,no, output[15:0] out, output zr,ng);
    wire[15:0] xzx,nxzx,xnx,yzy,nyzy,yny,xplusy,xandy,afterf,nafterf,nof;
    wire nzr8,nzr16,nzr;

    Mux16 g0(x,16'b0,zx,xzx);
    Not16 g1(xzx,nxzx);
    Mux16 g2(xzx,nxzx,nx,xnx);

    Mux16 g3(y,16'b0,zy,yzy);
    Not16 g4(yzy,nyzy);
    Mux16 g5(yzy,nyzy,ny,yny);

    Add16 g6(xnx,yny,xplusy);
    And16 g7(xnx,yny,xandy);
    Mux16 g8(xandy,xplusy,f,afterf);

    Not16 g9(afterf,nafterf);
    Mux16 g10(afterf,nafterf,no,nof);
    And16 g11(nof,nof,out);

    Or8Way g12(nof[7:0],nzr8);
    Or8Way g13(nof[15:8],nzr16);
    Or g14(nzr8,nzr16,nzr);
    Not g15(nzr,zr);

    Mux g16(0,1,nof[15],ng);
endmodule