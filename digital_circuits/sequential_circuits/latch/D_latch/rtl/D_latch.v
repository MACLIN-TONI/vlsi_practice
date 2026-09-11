module D_latch(
    input clk,
    input d,
    output q,
    output qb
);

    SR_latch_NAND SR(
        .clk(clk),
        .s(d),
        .r(~d),
        .q(q),
        .qb(qb)
    );

endmodule