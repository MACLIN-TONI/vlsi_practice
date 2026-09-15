module mod_10(
    input clk,
    input en,
    input areset_n,
    input apreset,
    output reg [3:0] out
);

    wire [3:0] w;

    wire pset;
    

    D u3(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .apreset(apreset | pset),
        .d(~w[3]),
        .q(w[3])
    );

    D u2(
        .clk(w[3]),
        .en(en),
        .areset_n(areset_n & ~pset),
        .apreset(apreset),
        .d(~w[2]),
        .q(w[2])
    );

    D u1(
        .clk(w[2]),
        .en(en),
        .areset_n(areset_n & ~pset),
        .apreset(apreset),
        .d(~w[1]),
        .q(w[1])
    );

    D u0(
        .clk(w[1]),
        .en(en),
        .areset_n(areset_n),
        .apreset(apreset | pset),
        .d(~w[0]),
        .q(w[0])
    );
    assign pset = (~w[0] & ~w[1] & ~w[2] & ~w[3]);
    assign {out[3],out[2],out[1],out[0]}= {w[0],w[1],w[2],w[3]};


endmodule 