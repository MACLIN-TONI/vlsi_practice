module D (
    input      clk,
    input      en,
    input      areset_n,
    input      preset,   // async force to 1
    input      clear,    // async force to 0
    input      d,
    output reg q
);
    always @(posedge clk, negedge areset_n, posedge preset, posedge clear) begin
        if (!areset_n)
            q <= 1'b0;
        else if (clear)
            q <= 1'b0;
        else if (preset)
            q <= 1'b1;
        else if (en)
            q <= d;
        else
            q <= q;
    end
endmodule