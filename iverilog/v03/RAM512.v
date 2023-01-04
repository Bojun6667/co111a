`include "ch03.v"

module RAM512_test;
reg[15:0] in;
reg[8:0] address;
reg clock, load;
wire[15:0] out;

RAM512 g(in, address, clock, load, out);

initial begin
    clock=0;
    load=0;
    in=15;
    $monitor("%4dns in=%d clock=%d load=%d address=%d out=%d", $stime, in, clock, load, address, out);
    #4;
    load=1;
    address=128;
    #2;
    load=0;
    address=0;
    #2 address=address+16;
    #2 address=address+16;
    #2 address=address+16;
    #2 address=address+16;
    #2 address=address+16;
    #2 address=address+16;
    #2 address=address+16;
    #2 address=address+16;
    #2 address=address+16;
    #2 address=address+16;
    #2 address=address+16;
    #2 address=address+16;
    #2 address=address+16;
    #2 address=address+16;
    #2 address=address+16;
    #2 address=address+16;
end

always #1 begin
    clock=~clock;
end

initial #30 $finish;
endmodule