`timescale 1ns/1ps

module tb_T;

    reg clk;
    reg en;
    reg areset_n;
    reg t;
    wire q;

    T dut(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .t(t),
        .q(q)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_T);
    end

    task check;
        reg [2:0] i,j,k;
        begin
            for(i=0;i<2;i=i+1) begin
                for(j=0;j<2;j=j+1) begin
                    for(k=0;k<2;k=k+1) begin
                        @(negedge clk) en=i;
                        @(negedge clk) areset_n=j;
                        @(negedge clk) t=k;
                        #1;
                        $display("en= %b |areset_n= %b |t= %b |q= %b ",en,areset_n,t,q);

                    end
                end
            end
        end
    endtask

    initial begin
        clk = 1'b0;
        forever #5 clk =~clk;
    end

    initial begin 
                
        check();
        
        #10;
        $finish();
    end




endmodule