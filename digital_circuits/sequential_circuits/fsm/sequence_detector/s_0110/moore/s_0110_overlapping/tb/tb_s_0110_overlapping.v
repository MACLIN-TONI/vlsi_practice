`timescale 1ns/1ps

module tb_s_0110_overlapping;
    reg clk;
    reg en;
    reg areset_n;
    reg in;
    wire out;

    s_0110_overlapping dut (
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .in(in),
        .out(out)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_s_0110_overlapping);
    end

    initial begin
        clk = 0;
        en =0;
        areset_n =0;
        in = 0;
        forever #5 clk = ~clk;
    end

    task check;
        input reg t_in;
        begin
            in = t_in;
            #1;
            $display("en = %b | areset_n = %b | in = %b | out = %b",en,areset_n,in,out);
        end
    endtask

    initial begin
        #3 en = 1;
        #3 areset_n = 1;
        @(negedge clk) check(0);
        @(negedge clk) check(0);
        @(negedge clk) check(1);
        @(negedge clk) check(1);
        @(negedge clk) check(1);
        @(negedge clk) check(0);
        @(negedge clk) check(1);
        @(negedge clk) check(1);
        @(negedge clk) check(0);
        @(negedge clk) check(1);
        @(negedge clk) check(1);
        @(negedge clk) check(0);
        @(negedge clk) check(0);


        #10; $finish;
    end
endmodule