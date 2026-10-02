module rom (
    input [3:0] addr,
    output reg [7:0] data
);


    always @(*) begin
        case (addr)
            0: data = 8'h3F;
            1: data = 8'h06;
            2: data = 8'h5B;
            3: data = 8'h4F;
            4: data = 8'h66;
            5: data = 8'h6D;
            6: data = 8'h7D;
            7: data = 8'h07;
            8: data = 8'h7F;
            9: data = 8'h6F;
            4'hA: data = 8'h77;
            4'hB: data = 8'h7C;
            4'hC: data = 8'h39;
            4'hD: data = 8'h5E;
            4'hE: data = 8'h79;
            4'hF: data = 8'h71;
            default: data = 8'h00;

        endcase
    end

endmodule