module mux_D(
    input clk,
    input en,
    input areset_n,
    input p_in,
    input qb_in,
    input load,
    output reg out
);

    wire in;

    assign in = (load)?p_in:qb_in;

    always @(posedge clk, negedge areset_n, load) begin
        if(~areset_n) begin
            out <= 0;
        end
        else if(~en) begin
            out <=out;
        end
        else begin
            out <=in;
        end
    end 

endmodule