`include "..\01\ch01.v"

module FullAdder (input a, b, c, output sum, carry);
    wire aXorb, d, aAndb;
    Xor g0(a, b, aXorb);
    Xor g1(a=aXorb,b=c,out=sum);
    And g2(a=aXorb,b=c,out=d);
    And g3(a=a,b=b,out=aAndb);
    Or g4(a=d,b=aAndb,out=carry);
endmodule

module HalfAdder (input a, b, output sum, carry);
    Xor g0(a, b, sum);
    And g1(a, b, carry);
endmodule

module Add16 (input[0:15] a, b, output[0:15] out);
    wire carry0, carry1, carry2, carry3, carry4, carry5, carry6, carry7, carry8, carry9, carry10, carry11, carry12, carry13, carry14, carry15;
    FullAdder g0(a[0], b[0], carry0, out[0]);
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
    wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15;
    HalfAdder g0(in[0],b=true,sum=out[0],carry=c1);
    HalfAdder g1(in[1],b=c1,sum=out[1],carry=c2);
    HalfAdder g2(in[2],b=c2,sum=out[2],carry=c3);
    HalfAdder g3(in[3],b=c3,sum=out[3],carry=c4);
    HalfAdder g4(in[4],b=c4,sum=out[4],carry=c5);
    HalfAdder g5(in[5],b=c5,sum=out[5],carry=c6);
    HalfAdder g6(in[6],b=c6,sum=out[6],carry=c7);
    HalfAdder g7(in[7],b=c7,sum=out[7],carry=c8);
    HalfAdder g8(in[8],b=c8,sum=out[8],carry=c9);
    HalfAdder g9(in[9],b=c9,sum=out[9],carry=c10);
    HalfAdder g10(in[10],b=c10,sum=out[10],carry=c11);
    HalfAdder g11(in[11],b=c11,sum=out[11],carry=c12);
    HalfAdder g12(in[12],b=c12,sum=out[12],carry=c13);
    HalfAdder g13(in[13],b=c13,sum=out[13],carry=c14);
    HalfAdder g14(in[14],b=c14,sum=out[14],carry=c15);
    HalfAdder g15(in[15],b=c15,sum=out[15]);
endmodule

module ALU(input[0:15] x, y, input zx, nx, zy, ny ,f, no, output[0:15] out, output zr, ng);
    wire[0:15] 
    // if (zx == 1) set x = 0        // 16-bit constant
    Mux16 g0(a = x, b[0..15] = false, sel = zx, out = ozx);

    // if (nx == 1) set x = !x       // bitwise not
    Not16 g1(in = ozx, out = nnx);
    Mux16 g2(a = ozx, b = nnx, sel = nx, out = exx);

    // if (zy == 1) set y = 0        // 16-bit constant
    Mux16 g3(a = y, b[0..15] = false, sel = zy, out = ozy);

    // if (ny == 1) set y = !y       // bitwise not
    Not16 g4(in = ozy, out = nny);
    Mux16 g5(a = ozy, b = nny, sel = ny, out = exy);

    // if (f == 1)  set out = x + y  // integer 2's complement addition
    // if (f == 0)  set out = x & y  // bitwise and
    Add16 g6(a = exx, b = exy, out = xplusy);
    And16 g7(a = exx, b = exy, out = xandy);
    Mux16 g8(a = xandy, b = xplusy, sel = f, out = fxy);

    // if (no == 1) set out = !out   // bitwise not
    Not16 g9(in = fxy, out = nfxy);
    Mux16 g10(a = fxy, b = nfxy, sel = no, out[0..7] = ret0, out[8..14] = ret1, out[15] = retsign, out = out);

    // if (out == 0) set zr = 1
    Or8Way g11(in[0..7] = ret0, out = ret0is0);
    Or8Way g12(in[0..6] = ret1, in[7] = retsign, out = ret1is0);

    Or g13(a = ret0is0, b = ret1is0, out = yzr);
    Not g14(in = yzr, out = zr);
    
    // if (out < 0) set ng = 1
    //And(a = retsign, b = true, out = ng);
    Mux g15(a = false , b = true , sel = retsign , out = ng);
endmodule