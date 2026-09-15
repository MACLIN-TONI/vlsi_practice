module PISO (
    input clk,
    input en,
    input areset_n,
    input [3:0] in,
    input load_shift,
    output out
);

    wire [3:0] w;

    mux_D u3(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .p_in(in[3]),
        .s_in(in[3]),
        .load_shift(load_shift),
        .out(w[3])
    );

    mux_D u2(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .p_in(in[2]),
        .s_in(w[3]),
        .load_shift(load_shift),
        .out(w[2])
    );

    mux_D u1(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .p_in(in[1]),
        .s_in(w[2]),
        .load_shift(load_shift),
        .out(w[1])
    );

    mux_D u0(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .p_in(in[0]),
        .s_in(w[1]),
        .load_shift(load_shift),
        .out(w[0])
    );

    assign out = w[0];
    
endmodule 