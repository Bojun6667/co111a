`include "ch02.v"

module FullAdder_test;
reg a,b,c;
wire sum,carry;

FullAdder g(a,b,c,sum,carry);

initial
begin
    a=0;
    b=0;
    c=0;
    $monitor("%4dns a=%b b=%b c=%b sum=%b carry=%b",$stime,a,b,c,sum,carry);
end

always #50 begin
    c=c+1;
end

always #100 begin
    b=b+1;
end

always #200 begin
    a=a+1;
end

initial #350 $finish;
endmodule