`include "ch01.v"

module main;
reg a, b;
wire abAnd;

And  g3(a, b, abAnd);

initial
begin
  $monitor("%4dns b=%d a=%d abAnd=%d", $stime, b, a, abAnd);
  a  = 0;
  b  = 0;
end

always #50 begin
  a = a+1;
end

always #100 begin
  b = b+1;
end

initial #150 $finish;

endmodule