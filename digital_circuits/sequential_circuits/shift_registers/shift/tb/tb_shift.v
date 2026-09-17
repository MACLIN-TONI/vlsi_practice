`timescale 1ns/1ps

module tb_shift;
    reg clk;
    reg en;
    reg areset_n;
    reg i;
    wire out;

    shift dut(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .i(i),
        .out(out)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_shift);
    end

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        en = 0;
        areset_n = 0;
        i=0;

    end

    initial begin
        #5 areset_n = 1;
        #5 en = 1;
        @(negedge clk) i=0;
        @(negedge clk) i=0;
        @(negedge clk) i=1;
        @(negedge clk) i=1;
        @(negedge clk) i=0;
        @(negedge clk) i=1;
        @(negedge clk) i=0;
        #50 $finish;





    end
endmodule 