`include "ch03.v"

module Bit_test;
reg in, clock, load;
wire out;

Bit g(in, clock, load, out);

initial
begin
    clock=0;
    load=0;
    in=0;
    $monitor("%4dns in=%d clock=%d load=%d out=%d", $stime, in, clock, load, out);
end

always #2 begin
    clock=~clock;
end

always #4 begin
    in = in+1;
end

always #8 begin
    load=~load;
end

initial #40 $finish;
endmodule