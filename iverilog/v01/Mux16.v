`include "ch01.v"

module main;
reg[0:15] a, b;
reg sel;
wire[0:15] mux2;

Mux16 g1(a, b, sel, mux2);

initial
begin
  $monitor("%4dns a=%x b=%x sel=%d mux2=%x", $stime, a, b, sel, mux2);
  a  = 16'h0;
  b  = 16'h1;
  sel = 0;
end

always #50 begin
  sel=sel+1;
end

initial #50 $finish;

endmodule
