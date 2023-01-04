`include "ch03.v"

module RAM8_test;
reg[15:0] in;
reg[2:0] address;
reg clock, load;
wire[15:0] out;

RAM8 g(in, clock, load, address, out);

initial begin
    clock=0;
    load=0;
    in=15;
    $monitor("%4dns in=%d clock=%d load=%d address=%d out=%d", $stime, in, clock, load, address, out);
    #4;
    load=1;
    address=4;
    #2;
    load=0;
    address=0;
    #2 address=1;
    #2 address=2;
    #2 address=3;
    #2 address=4;
    #2 address=5;
    #2 address=6;
    #2 address=7;
end
/*
initial #4 begin
    address=5;
    load=1;
end
initial #6 begin
    load=0;
    address=0;
end
initial #8 begin
    address=1;
end
initial #10 begin
    address=2;
end
initial #12 begin
    address=3;
end
initial #14 begin
    address=4;
end
initial #16 begin
    address=5;
end
initial #18 begin
    address=6;
end
initial #20 begin
    address=7;
end
*/
always #1 begin
    clock=~clock;
end

initial #20 $finish;
endmodule