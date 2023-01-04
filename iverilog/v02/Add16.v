`include "ch02.v"

module Add16_test;
reg[15:0] a,b;
wire[15:0] out;

Add16 g(a,b,out);

initial
begin
    a=16'b0000;
    b=16'b0000;
    $monitor("%4dns a=%b(Bin) %d(Dec) b=%b(Bin) %d(Dec) out=%b(Bin) %d (Dec)",$stime,a,a,b,b,out,out);
end

always #50 begin
    a=a+100;
end

always #100 begin
    b=b+500;
end

initial #500 $finish;
endmodule