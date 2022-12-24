`include "ch01.v"

module Or16_test;
reg[0:15] a,b;
wire[0:15] out;

Or16 g(a[0:15],b[0:15],out[0:15]);

initial
begin
    a = 16'b0000;
    b = 16'b0000;
    $monitor("%4dns a=%b b=%b out=%b",$stime,a,b,out);
end

always #50 begin
    b=b+1000;
end

always #100 begin
    a=a+1000;
end

initial #500 $finish;
endmodule