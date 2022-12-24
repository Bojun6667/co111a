`include "ch01.v"


module Mux_test;
reg a,b,sel;
wire out;

Mux g(a,b,sel,out);

initial
begin
    a=0;
    b=0;
    sel=0;
    $monitor("%4dns Mux: a=%d b=%d sel=%d out=%d",$stime,a,b,sel,out);
end

always #50 begin
    sel=sel+1;
end

always #100 begin
    b=b+1;
end

always #200 begin
    a=a+1;
end

initial #350 $finish;
endmodule

