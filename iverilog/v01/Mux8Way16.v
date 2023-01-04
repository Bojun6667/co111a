`include "ch01.v"

module Mux8Way16_test;
reg[0:15] a,b,c,d,e,f,g,h;
reg[0:2] sel;
wire[0:15] out;

Mux8Way16 g0(a,b,c,d,e,f,g,h,sel,out);

initial
begin
    a=16'b0000;
    b=16'b0001;
    c=16'b0010;
    d=16'b0011;
    e=16'b0100;
    f=16'b0101;
    g=16'b0110;
    h=16'b0111;
    sel=000;
    $monitor("%4dns a=%x b=%x c=%x d=%x e=%x f=%x g=%x h=%x sel=%b out=%x",$stime,a,b,c,d,e,f,g,h,sel,out);
end

always #50 begin
    sel=sel+1;
end

initial #350 $finish;
endmodule