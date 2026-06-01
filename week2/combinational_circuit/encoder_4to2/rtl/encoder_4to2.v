module encoder_4to2 (
    input wire [3:0] d_in,
    output reg [1:0] d_out,
    output reg valid
);

    always @(*) begin
        // d_out=2'b00;
        // d_out[1] = d_in[2] | d_in[3];
        // d_out[0] = d_in[1] | d_in[3];

        valid = 1'b1;
        case(d_in)
            4'b0001:d_out=2'b00;
            4'b0010:d_out=2'b01;
            4'b0100:d_out=2'b10;
            4'b1000:d_out=2'b11;
            default: begin
                d_out = 2'b00;
                valid = 1'b0;
            end 
        endcase

    end
endmodule