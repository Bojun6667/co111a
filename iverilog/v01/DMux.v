`include "ch01.v"

module DMux_test;
reg in,sel;
wire a,b;

DMux g0(in,sel,a,b);

initial
begin
    in=1;
    sel=0;
    $monitor("%4dns in=%d sel=%d a=%d b=%d",$stime,in,sel,a,b);
end

always #50 begin
    sel=sel+1;
end

initial #50 $finish;
endmodule
