module register_file #(
    parameter DEPTH = 16,
    parameter WIDTH = 8
) (
    input clk,
    input we,
    input [$clog2(DEPTH)-1:0] wr_addr,
    input [WIDTH-1:0] wr_data,
    input [$clog2(DEPTH)-1:0] rd_addr_a,
    output [WIDTH-1:0] rd_data_a,
    input [$clog2(DEPTH)-1:0] rd_addr_b,
    output [WIDTH-1:0] rd_data_b
);
    reg [WIDTH-1:0] mem [0:DEPTH-1];

    always@(posedge clk) begin
        if(we) begin
            mem[wr_addr] <= wr_data;
        end
    end

    assign rd_data_a = mem[rd_addr_a];
    assign rd_data_b = mem[rd_addr_b];
endmodule