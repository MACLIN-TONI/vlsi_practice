module SR (
    input clk,
    input s,
    input r,
    output q,
    output qb
);
    wire w1,w2;
    SR_latch_NAND sr_latch1(
        .clk(~clk),
        .s(s),
        .r(r),
        .q(w1),
        .qb(w2)
    );

    SR_latch_NAND sr_latch2(
        .clk(clk),
        .s(w1),
        .r(w2),
        .q(q),
        .qb(qb)
    );


endmodule 