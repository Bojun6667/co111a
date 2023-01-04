`include "ch02.v"

module HalfAdder_test;
reg a,b;
wire sum,carry;

HalfAdder g(a,b,sum,carry);

initial
begin
    a=0;
    b=0;
    $monitor("%4dns a=%d b=%d sum=%d carry=%d",$stime, a,b,sum,carry);
end

always #50 begin
    b=b+1;
end

always #100 begin
    a=a+1;
end

initial #150 $finish;
endmodule