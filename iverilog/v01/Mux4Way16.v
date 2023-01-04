`include "ch01.v"

module Mux4Way16_test;
reg[0:15] a,b,c,d;
reg[0:1] sel;
wire[0:15] out;

Mux4Way16 g(a,b,c,d,sel,out);

initial
begin
    a=16'b0000;
    b=16'b0101;
    c=16'b1010;
    d=16'b1111;
    sel=00;
    $monitor("%4dns a=%x b=%x c=%x d=%x sel=%b out=%x",$stime,a,b,c,d,sel,out);
end

always #50 begin
    sel=sel+1;

end

initial #150 $finish;
endmodule
