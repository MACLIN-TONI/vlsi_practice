`timescale 1ns/1ps

module tb_fsm;

    reg in, clk, rst;
    wire out;

    fsm dut(
        .in(in),
        .clk(clk),
        .rst(rst),
        .out(out)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0, tb_fsm);
    end

    // Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset
    initial begin
        rst = 1;
        in  = 0;

        #12;
        rst = 0;
    end

    // Input sequence: 1010111010
    initial begin
        @(negedge clk); in = 1;
        @(negedge clk); in = 0;
        @(negedge clk); in = 1;
        @(negedge clk); in = 0;

        @(negedge clk); in = 1;
        @(negedge clk); in = 1;
        @(negedge clk); in = 1;
        @(negedge clk); in = 0;

        @(negedge clk); in = 1;
        @(negedge clk); in = 0;

        #10 $finish;
    end

endmodule