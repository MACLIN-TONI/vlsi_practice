module mod_10(
    input clk,
    input en,
    input areset_n,
    output [3:0] out,
    output rst_out
);

    wire [3:0] w;

    wire rst;
    assign rst = ~(~areset_n | (w[0] & ~w[1] & w[2] & ~w[3]));

    assign rst_out = ~rst;
    D u3(
        .clk(clk),
        .en(en),
        .areset_n(rst),
        .d(~w[3]),
        .q(w[3])
    );

    D u2(
        .clk(~w[3]),
        .en(en),
        .areset_n(rst),
        .d(~w[2]),
        .q(w[2])
    );

    D u1(
        .clk(~w[2]),
        .en(en),
        .areset_n(rst),
        .d(~w[1]),
        .q(w[1])
    );

    D u0(
        .clk(~w[1]),
        .en(en),
        .areset_n(rst),
        .d(~w[0]),
        .q(w[0])
    );

    assign {out[3],out[2],out[1],out[0]}= {w[0],w[1],w[2],w[3]};


endmodule 