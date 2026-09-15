`timescale 1ns/1ps

module tb_up_negedge;
    reg clk;
    reg en;
    reg areset_n;
    wire [2:0] out;

    up_negedge dut(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .out(out)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_up_negedge);
    end

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        en = 0;
        areset_n = 0;
    end

    task check;
        begin
            $display("en = %b | areset_n = %b | out = %b",en,areset_n,out);
        end
    endtask

    initial begin
        #10 areset_n = 1;
        #7 en = 1;

        repeat(20) begin
            @(posedge clk) check();
        end

        #10 $finish; 
    end
endmodule