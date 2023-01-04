`include "ch05.v"

module Computer_test;
reg reset, clock;

Computer computer(clock, reset);

integer i;

initial
begin
    $readmemb("sum.hack", computer.rom.m);
    for (i=0; i<32; i=i+1) begin
        $display("%4x: %b", i, computer.rom.m[i]);
    end
    $monitor("%4dns clock=%d reset=%d pc=%d I=%d A=%d D=%d M=%d", $stime, clock, reset, computer.pc, computer.I, computer.addressM, computer.cpu.AluX, computer.outM);
    clock = 0;
    #4 reset=1;
    #10 reset=0;
end

always #1 begin
    clock=~clock;
end

initial #330 $finish;
endmodule