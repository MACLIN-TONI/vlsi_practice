module dual_port_ram #(
    parameter DEPTH = 16,
    parameter WIDTH = 8
)(
    input clk,
    input we,
    input [$clog2(DEPTH)-1:0] wr_addr,
    input [WIDTH-1:0] wr_data,
    input re,
    input [$clog2(DEPTH)-1:0] rd_addr,
    output reg [WIDTH-1:0] rd_data 
);
    reg [WIDTH-1:0] mem [0:DEPTH-1];

    always @(posedge clk) begin
        if(we && re) begin
            rd_data <= mem[rd_addr];
            mem[wr_addr] <= wr_data;
        end
        else if(re) begin
            rd_data <= mem[rd_addr];
        end
        else if(we) begin
            mem[wr_addr] <= wr_data;
            rd_data <= rd_data;
        end
        else begin
            rd_data <= rd_data;
        end
    end
endmodule