`include "ch03.v"

module DFF_test;
reg in, clock;
wire out;

DFF g(in, clock, out);

initial
begin
	clock=0;
	in=0;
	$monitor("%4dns in=%d clock=%d out=%d", $stime, in, clock, out);
end

always #1 begin
	clock=~clock;
end

always #2 begin
	in=in+1;
end

initial #10 $finish;

endmodule