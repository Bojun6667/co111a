`include "ch01.v"

module Or8Way_test;

reg [7:0] in;
wire out;

Or8Way g(in,out);

initial
begin
    in=00000000;
    $monitor("%4dns in=%b Or8Way: out=%d",$stime,in,out);
end

always #50 begin
    in=in+1;
end

initial #200 $finish;
endmodule