module mod_10(
    input clk,
    input en,
    input areset_n,
    output [3:0] out
);

    wire [3:0] w;
    wire load;
    wire [3:0] p_in;
    assign p_in = 4'b1001;

    mux_D u3(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .p_in(p_in[3]),
        .qb_in(~w[3]),
        .load(load),
        .out(w[3])
    );

    mux_D u2(
        .clk(w[3]),
        .en(en),
        .areset_n(areset_n),
        .p_in(p_in[2]),
        .qb_in(~w[2]),
        .load(load),
        .out(w[2])
    );

    mux_D u1(
        .clk(w[2]),
        .en(en),
        .areset_n(areset_n),
        .p_in(p_in[1]),
        .qb_in(~w[1]),
        .load(load),
        .out(w[1])
    );

    mux_D u0(
        .clk(w[1]),
        .en(en),
        .areset_n(areset_n),
        .p_in(p_in[0]),
        .qb_in(~w[0]),
        .load(load),
        .out(w[0])
    );

    assign load = w[3] & w[2] & w[1] & w[0];
    
    assign {out[3],out[2],out[1],out[0]}= {w[0],w[1],w[2],w[3]};


endmodule 