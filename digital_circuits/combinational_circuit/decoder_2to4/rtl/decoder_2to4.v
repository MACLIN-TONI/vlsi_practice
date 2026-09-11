module decoder_2to4 (
    input en,
    input [1:0] din,
    output reg [3:0] out
);
    always @(*)
    begin
        out=4'b0000;
        out = en ? 1<<din :0;

    end
endmodule
