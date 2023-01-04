`include "ch05.v"

module CPU_test;
reg[15:0] inM, I;
reg clock, reset;
wire[15:0] outM;
wire writeM;
wire[14:0] addressM, pc;

CPU cpu(inM, I, clock, reset, outM, writeM, addressM, pc);

initial
begin
    inM=0;I=0;clock=0;reset=0;
    $monitor("%4dns inM=%d I=%b clock=%b reset=%b outM=%d addressM=%d pc=%d", $stime, inM, I, clock, reset, outM, addressM, pc);
    #2 I=16'B0011000000111001;//@12345
    #2 I=16'B1110110000010000;//D=A
    #2 I=16'B0101101110100000;//@23456
    #2 I=16'B1110000111010000;//D=A-D

    #2 $finish;
end

initial 
begin
    reset=1;
    #2 reset=0;
end

always #1 begin
    clock=~clock;
end
endmodule