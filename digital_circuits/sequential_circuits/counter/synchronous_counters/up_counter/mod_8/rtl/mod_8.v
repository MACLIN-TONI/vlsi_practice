module mod_8(
    input clk,
    input en,
    input areset_n,
    output [2:0] out
);

    wire [2:0] w;

    D dff2(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d((w[2] ^ (w[1] & w[0]))),
        .q(w[2])
    );

    D dff1(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d((w[1] ^ w[0])),
        .q(w[1])
    );

    D dff0(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(~w[0]),
        .q(w[0])
    );

    assign out = w;


endmodule