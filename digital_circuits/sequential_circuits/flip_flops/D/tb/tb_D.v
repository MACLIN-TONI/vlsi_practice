`timescale 1ns/1ps

module tb_D;

    reg clk;
    reg en;
    reg areset_n;
    reg d;
    wire q;

    D dut(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(d),
        .q(q)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_D);
    end

    initial begin
        clk= 1'b0;
        forever #5 clk = ~clk;
    end

    task check;
        reg [2:0] i, j, k;
        begin
            for(i=0;i<2;i=i+1) begin
                for(j=0;j<2;j=j+1) begin
                    for(k=0;k<2;k=k+1) begin
                        @(negedge clk) en=i;
                        @(negedge clk) areset_n=j;
                        @(negedge clk) d=k;

                        #2;
                        $display("en=%b | areset_n=%b | d=%b | q=%b |", en,areset_n,d,q);
                        
                    end
                end
            end
        end

    endtask

    initial begin
        
        check();
        check();

        $finish;
    end

endmodule