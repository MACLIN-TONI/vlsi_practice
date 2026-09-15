`timescale 1ns/1ps

module tb_SIPO;
    reg clk;
    reg en;
    reg areset_n;
    reg in;
    wire [3:0] out;

    SIPO dut(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .in(in),
        .out(out)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_SIPO);
    end

    initial begin
        clk= 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        en=0;
        areset_n=0;
        in = 0;
    end

    initial begin
        #10 en=1;
        #5 areset_n=1;

        @(negedge clk) in =1'b1;
        @(negedge clk) in =1'b1;
        @(negedge clk) in =1'b0;
        @(negedge clk) in =1'b1;

        #10 areset_n=0;
        #20 areset_n = 1;

        @(negedge clk) in =1'b1;
        @(negedge clk) in =1'b1;
        
        #10 en = 0;

        @(negedge clk) in =1'b0;

        #10 en = 1;
        
        @(negedge clk) in =1'b1;


        #50 $finish;
    end




endmodule