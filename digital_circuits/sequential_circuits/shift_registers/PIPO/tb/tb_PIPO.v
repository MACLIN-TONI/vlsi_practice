`timescale 1ns/1ps
module tb_PIPO;

    reg clk;
    reg en;
    reg areset_n;
    reg [3:0] in;
    wire [3:0] out;

    PIPO dut(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .in(in),
        .out(out)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_PIPO);
    end

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        en = 1'b0;
        areset_n = 1'b0;
        in = 4'b0000;
    end

    initial begin
        #5 en = 1'b1;
        #5 areset_n = 1'b1;
        #5;
        @(negedge clk) in = 4'b1010;
        @(negedge clk) in = 4'b1110;
        @(negedge clk) in = 4'b0011;
        @(negedge clk) in = 4'b0010; 
        @(negedge clk) in = 4'b1111;

        #10 areset_n = 1'b0;
        @(negedge clk) in = 4'b1111;
        #10 areset_n = 1'b1;

        #10 en = 1'b0;
        @(negedge clk) in = 4'b0000;
        #10 en = 1'b1;
        

        #20;
        $finish;

    end
endmodule