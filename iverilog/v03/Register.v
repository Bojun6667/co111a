`include "ch03.v"

module Register_test;
reg[15:0] in;
reg clock, load;
wire[15:0] out;

Register g(in, clock, load, out);

initial
begin
    clock=0;
    load=0;
    in=0;
    $monitor("%4dns in=%d clock=%d load=%d out=%d", $stime, in, clock, load, out);
    #4 in=10;
    #2 load=1;
    #2 load=0;
    #2 in=100;
    #6 load=1;
    #2 load=0;
    #4 $finish;
end

always #1 begin
    clock=~clock;
end
endmodule