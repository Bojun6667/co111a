`include "ch01.v"

module FullAdder (input a, b, c, output sum, carry);
    wire aXorb, d, aAndb;
    Xor g1(a, b, aXorb);
    Xor g2(a=aXorb,b=c,out=sum);
    And g3(a=aXorb,b=c,out=d);
    And g4(a=a,b=b,out=aAndb);
    Or g5(a=d,b=aAndb,out=carry);
endmodule

module Add16 (input[0:15] a, b, output[0:15] out);
    
    FullAdder g0(a[0], b[0], false, carry=carry0,sum=out[0]);
    FullAdder g1(a[1], b[1], carry0, carry=carry1,sum=out[1]);
    FullAdder g2(a[2], b[2], carry1, carry=carry2,sum=out[2]);
    FullAdder g3(a[3], b[3], carry2, carry=carry3,sum=out[3]);
    FullAdder g4(a[4], b[4], carry3, carry=carry4,sum=out[4]);
    FullAdder g5(a[5], b[5], carry4, carry=carry5,sum=out[5]);
    FullAdder g6(a[6], b[6], carry5, carry=carry6,sum=out[6]);
    FullAdder g7(a[7], b[7], carry6, carry=carry7,sum=out[7]);
    FullAdder g8(a[8], b[8], carry7, carry=carry8,sum=out[8]);
    FullAdder g9(a[9], b[9], carry8, carry=carry9,sum=out[9]);
    FullAdder g10(a[10], b[10], carry9, carry=carry10,sum=out[10]);
    FullAdder g11(a[11], b[11], carry10, carry=carry11,sum=out[11]);
    FullAdder g12(a[12], b[12], carry11, carry=carry12,sum=out[12]);
    FullAdder g13(a[13], b[13], carry12, carry=carry13,sum=out[13]);
    FullAdder g14(a[14], b[14], carry13, carry=carry14,sum=out[14]);
    FullAdder g15(a[15], b[15], carry14, carry=carry15,sum=out[15]);
endmodule