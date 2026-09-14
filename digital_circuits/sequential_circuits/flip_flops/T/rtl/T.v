module T (
    input clk,
    input en,
    input areset_n,
    input t,
    output reg q
);
    always @(posedge clk) begin
        if(!areset_n) begin
            q <= 1'b0;
        end
        else if(!en) begin
            q <= q;
        end
        else begin
            if(t) begin
                q <= ~q;
            end
            else begin
                q <= q;
            end
        end

    end
endmodule