module SISO(
    input clk,
    input en,
    input areset_n,
    input in,
    output reg out

);
    wire w1,w2,w3;

    D dff1(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(in),
        .q(w1)
    );

    D dff2(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(w1),
        .q(w2)
    );

    D dff3(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(w2),
        .q(w3)
    );

    D dff4(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(w3),
        .q(out)
    );

endmodule