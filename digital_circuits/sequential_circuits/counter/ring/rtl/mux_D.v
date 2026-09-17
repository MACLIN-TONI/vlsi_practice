module mux_D(
    input clk,
    input en,
    input areset_n,
    input p_in,
    input s_in,
    input load_shift,
    output reg out
);

    wire in;

    assign in = (load_shift)?p_in:s_in;

    D dff(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(in),
        .q(out)
    );

endmodule