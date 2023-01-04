`include "ch02.v"

module Inc16_test;
reg[15:0] in;
wire[15:0] out;

Inc16 g(in,out);

initial
begin
    in=16'b0000;
    $monitor("%4dns in=%b(Bin) %x(Hex) out=%b(Bin) %x(Hex)",$stime,in,in,out,out);
end

always #50 begin
    in=in+1000;
end

initial #150 $finish;
endmodule