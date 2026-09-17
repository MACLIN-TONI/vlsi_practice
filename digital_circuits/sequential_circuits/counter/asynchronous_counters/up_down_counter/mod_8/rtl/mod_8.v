module mod_8(
    input clk,
    input en,
    input areset_n,
    input up_down,
    output [2:0] out
);

    wire [2:0] w;

    wire [2:0] clk_in;

    assign clk_in = (up_down)?{clk, ~w[2], ~w[1]} : {clk, w[2], w[1]}; 

    D u2(
        .clk(clk_in[2]),
        .en(en),
        .areset_n(areset_n),
        .d(~w[2]),
        .q(w[2])
    );

    D u1(
        .clk(clk_in[1]),
        .en(en),
        .areset_n(areset_n),
        .d(~w[1]),
        .q(w[1])
    );

    D u0(
        .clk(clk_in[0]),
        .en(en),
        .areset_n(areset_n),
        .d(~w[0]),
        .q(w[0])
    );

    assign {out[2],out[1],out[0]}= {w[0],w[1],w[2]};


endmodule 