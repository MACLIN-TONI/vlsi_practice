module SR_latch_NOR (
    input clk,
    input s,
    input r,
    output reg q,
    output reg qb
);
    
    wire w1,w2;

    and (w1,r,clk);
    and (w2,s,clk);

    nor (q,w1,qb);
    nor (qb,w2,q);




    
endmodule 