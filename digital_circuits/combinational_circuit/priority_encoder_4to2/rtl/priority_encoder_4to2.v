module priority_encoder_4to2 (
    input wire [3:0] d_in,
    output reg [1:0] d_out,
    output reg valid
);
    always @(*) begin
        d_out=2'b00;
        valid=1'b1;
        casez(d_in) 
            4'b0001:d_out=2'b00;
            4'b001?:d_out=2'b01;
            4'b01??:d_out=2'b10;
            4'b1???:d_out=2'b11;
            default: begin
                valid = 1'b0;
                d_out=2'b00;
            end 
        endcase

    end

endmodule