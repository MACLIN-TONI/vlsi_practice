module mod_8(
    input clk,
    input en,
    input areset_n,
    input up_down,
    output [2:0] out
);

    wire a,b,c;

    wire a_in, b_in, c_in;

    assign a_in = (~a & ~b & ~c & ~up_down) | (~a & b & c & up_down) | (a & b & ~c) | (a & ~b & up_down) | (a & c & ~up_down);
    assign b_in = ~(b ^ (c ^ up_down));
    assign c_in = ~c;

    assign out = {a,b,c};

    D dff2(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(a_in),
        .q(a)
    );

    D dff1(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(b_in),
        .q(b)
    );

    D dff0(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(c_in),
        .q(c)
    );


endmodule 

