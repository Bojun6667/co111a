`include "ch01.v"

module Not16_test;
reg[0:15] in;
wire[0:15] out;

Not16 g(in[0:15],out[0:15]);

initial
begin
    in=16'b0000;
    $monitor("%dns in=%b out=%b",$stime,in,out);
end

always #50 begin
    in=in+1000;
end

initial #500 $finish;
endmodule