module D (
    input      clk,
    input      en,
    input      areset_n,
    input      preset,   
    input      d,
    output reg q
);
    always @(posedge clk, negedge areset_n, posedge preset) begin
        if (!areset_n)
            q <= 1'b0;
        else if (preset)
            q <= 1'b1;
        else if (en)
            q <= d;
        else
            q <= q;
    end
endmodule