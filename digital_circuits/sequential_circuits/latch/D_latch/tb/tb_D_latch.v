module tb_D_latch;

    reg clk;
    reg d;
    wire q;
    wire qb;

    D_latch dut(
        .clk(clk),
        .d(d),
        .q(q),
        .qb(qb)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_D_latch);
    end

    initial begin
        clk=0;
        forever #5 clk=~clk;
    end
    
    task check;
        reg [2:0] i;
        begin
            for(i=0;i<2;i=i+1) begin
                d=i;
                #12;
                $display("d=%b | q=%b | qb=%b", d,q,qb);

            end
        end
    endtask

    
    initial begin
        check();
        check();
        $finish;
    end

endmodule