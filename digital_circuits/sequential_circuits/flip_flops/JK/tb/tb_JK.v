`timescale 1ns/1ps
module tb_JK;
    reg clk;
    reg en;
    reg areset_n;
    reg j;
    reg k;
    wire q;

    JK dut(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .j(j),
        .k(k),
        .q(q)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_JK);
    end

    initial begin
        clk=1'b0;
        forever #5 clk= ~clk;
    end

    task check;
        reg [2:0] w,x,y,z;
        begin
            for(w=0;w<2;w=w+1) begin
                for(x=0;x<2;x=x+1) begin
                    for(y=0;y<2;y=y+1) begin
                        for(z=0;z<2;z=z+1) begin
                            @(negedge clk) en = w;
                            @(negedge clk) areset_n = x;
                            @(negedge clk) j = y;
                            @(negedge clk) k = z;
                            #5 $display("en=%b |areset_n=%b |j=%b |k=%b |q=%b |",en,areset_n,j,k,q);
                            
                        end
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