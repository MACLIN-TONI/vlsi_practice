`timescale 1ns/1ps

module tb_PISO;
    reg clk;
    reg en;
    reg areset_n;
    reg [3:0] in;
    reg load_shift;
    wire out;

    PISO dut(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .in(in),
        .load_shift(load_shift),
        .out(out)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_PISO);
    end

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        en = 0;
        areset_n = 0;
        in = 4'b0000;
        load_shift = 0;
    end

    initial begin
        #5 areset_n = 1;
        #5 en = 1;
        #7 in = 4'b1010;
        #16 load_shift = 1;
        #3 load_shift = 0;

        #20 $finish;

    end
endmodule 