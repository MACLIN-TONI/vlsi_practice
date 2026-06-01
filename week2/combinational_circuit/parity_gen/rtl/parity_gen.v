module parity_gen (
    input [7:0] data,
    output reg even_parity, odd_parity
);
    always @(*) begin
        even_parity = ^data;
        odd_parity= ~even_parity;
    end

endmodule