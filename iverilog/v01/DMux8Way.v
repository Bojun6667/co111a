`include "ch01.v"

module DMux8Way_test;
reg in;
reg[0:2] sel;
wire a, b, c, d, e, f, g, h;

DMux8Way g0(in, sel[0:2], a, b, c, d, e, f, g, h);

initial
    
begin
    in = 1;
    sel = 000;
    $monitor("%4dns in=%b sel=%b a=%b b=%b c=%b d=%b e=%b f=%b g=%b h=%b", $stime, in, sel, a, b, c, d, e, f, g, h);
end

always #50 begin
    sel = sel + 1;
end

initial #350 $finish;
endmodule