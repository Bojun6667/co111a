`include "ch03.v"

module RAM4K_test;
reg[15:0] in;
reg[11:0] address;
reg clock,load;
wire[15:0] out;

RAM4K g(in, address, clock, load, out);

initial begin
    clock=0;
    load=0;
    in=15;
    $monitor("%4dns in=%d clock=%d load=%d address=%d out=%d", $stime, in, clock, load, address, out);
    #4;
    load=1;
    address=1024;
    #2;
    load=0;
    address=0;
    #2 address=address+1;
    #2 address=address*2;
    #2 address=address*2;
    #2 address=address*2;
    #2 address=address*2;
    #2 address=address*2;
    #2 address=address*2;
    #2 address=address*2;
    #2 address=address*2;
    #2 address=address*2;
    #2 address=address*2;
    #2 address=address*2;
    #2 address=address*2-1;
end

always #1 begin
    clock=~clock;
end

initial #33 $finish;
endmodule