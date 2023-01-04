`include "ch05.v"

module Memory_test;
reg [15:0] in;
reg[14:0] address;
reg clock, load;
wire[15:0] out;

Memory ram(in, address, clock, load, out);

initial begin
    clock=0;
    load=0;
    in=64;
    $monitor("%4dns in=%d clock=%d load=%d address=%b = %d out=%d", $stime, in, clock, load, address, address, out);
    #2;
    address=24576;
    #2;
    address=16384;
    load=1;
    #2;
    load=0;
    #2;
    address=24575;
    load=1;
    #2;
    load=0;
    #2;
    address=256;
    load=1;
    #2;
    load=0;
    #2;
    address=0;
    #2 address=256;
    #2 address=16384;
    #2 address=24575;
    #2 address=24576;
    #2 $finish;
end
/*
always #1 begin
    if (address==24576) begin
        $display("Keyboard");
    end
    if (address>=16384&&address<=24574) begin
        $display("Screen");
    end
    if (address>=0&&address<=16383) begin
        $display("RAM");
    end
end
*/
always #1 begin
    clock=~clock;
end
endmodule