module shift (
    input clk,
    input en,
    input areset_n,
    input i,
    output out
);

    wire [1:0] w;
    wire load_shift = i;
    


    mux_D u1(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .p_in(1'b1),
        .s_in(i),
        .load_shift(load_shift),
        .out(w[1])
    );

    mux_D u0(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .p_in(1'b1),
        .s_in(w[1]),
        .load_shift(load_shift),
        .out(w[0])
    );

    assign out = w[0];
    
endmodule 