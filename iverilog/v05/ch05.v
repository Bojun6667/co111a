`include "..\03\ch03.v"

module RAM8K(input[15:0] in, input[12:0] address, input clock, load, output[15:0] out);
    reg[15:0] m[0:2**13-1];

    assign out = m[address];

    always @(posedge clock) begin
        if (load) m[address] = in;
    end
endmodule

module Keyboard(output[15:0] out);
    reg[15:0] o=16'h0F0F;
    assign out = o;
endmodule

module Memory(input[15:0] in, input[14:0] address, input clock, load, output[15:0] out);
    wire[15:0] o0, o1, o2;

    DMux4Way g0(load, address[14:13], r0, r1, r2, r3);
    Or g1(r0, r1, rload);
    RAM16K ram16k(in, address[13:0], clock, rload, o0);
    RAM8K screen(in, address[12:0], clock, r2, o1);
    Keyboard keyboard(o2);
    Mux4Way16 g2(o0, o0, o1, o2, address[14:13], out);
endmodule

module ROM32K(input[14:0] address, output[15:0] out);
    reg[15:0] m[0:2**15-1];
    assign out = m[address];
endmodule

module CPU(input[15:0] inM, I, input clock, reset, output[15:0] outM, output writeM, output[14:0] addressM, pc);
    wire[15:0] ALUback, ArIN, MUXtwoIN, AluY, AluX, pcout;
//指令預處理
    Mux16 g0(I, ALUback, I[15], ArIN);
    And g1(I[15], I[5], ALUtoAr);
    Not g2(I[15], isA);
    Or g3(ALUtoAr, isA, Arload);

    Register A(ArIN, clock, Arload, MUXtwoIN);
    assign addressM = MUXtwoIN[14:0];
    Mux16 g4(MUXtwoIN, inM, I[12], AluY);
    And g5(I[15], I[4], Dload);
    Register D(ALUback, clock, Dload, AluX);
//I[11:6]=zx,nx,zy,ny,f,no
    ALU alu(AluX, AluY, I[11], I[10], I[9], I[8], I[7], I[6], ALUback, zrout, ngout);

//I[2]=j2,I[1]=j1,I[0]=j0
    And g6(I[2], I[1], jmp0);
    And g7(jmp0, I[0], JMP);
    And g8(I[1], zrout, EQ);
    And g9(I[2], ngout, LT);
    Not g10(ngout, nngout);
    And g11(nngout, I[0], GT0);
    Not g12(zrout, nzrout);
    And g13(nzrout, GT0, GT);
    Or g14(JMP, EQ, jmpeq);
    Or g15(LT, GT, ltgt);
    Or g16(jmpeq, ltgt, pcload0);
    And g17(I[15], pcload0, pcload);
    And g18(I[3], I[15], writeM);

    assign outM = ALUback;
    PC pc0(MUXtwoIN, clock, pcload, 1, reset, pcout);
    assign pc = pcout[14:0];
endmodule

module Computer(input clock, reset);
    wire[15:0] inM, outM, I;
    wire[14:0] addressM, pc;

    Memory ram(inM, addressM, !clock, loadM, outM);
    ROM32K rom(pc, I);
    CPU cpu(outM, I, clock, reset, inM, loadM, addressM, pc);
endmodule