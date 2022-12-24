`include "ch01.v"

module DMux4Way_test;
reg in;
reg[0:1] sel;
wire a,b,c,d;

DMux4Way g(in,sel,a,b,c,d);

initial
begin
    in=1;
    sel=00;
    $monitor("%4dns in=%d sel=%b a=%b b=%b c=%b d=%b",$stime,in,sel,a,b,c,d);
end

always #50 begin
    sel=sel+1;
end

initial #150 $finish;
endmodule