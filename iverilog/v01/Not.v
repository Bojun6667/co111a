`include "ch01.v"

module Not_test;
reg a;
wire aNot;

Not  g1(a, aNot);

initial
begin
  $monitor("%4dns a=%d aNot=%d", $stime, a, aNot);
  a  = 0;
end

always #100 begin
  a = a+1;
end

initial #100 $finish;

endmodule