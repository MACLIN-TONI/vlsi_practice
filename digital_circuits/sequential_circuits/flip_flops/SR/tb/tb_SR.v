`timescale 1ns/1ps

module tb_SR;

    reg clk;
    reg s;
    reg r;
    wire q;
    wire qb;

    SR dut(
        .clk(clk),
        .s(s),
        .r(r),
        .q(q),
        .qb(qb)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_SR);
    end 

    initial begin
        clk = 1'b0;
        forever #2 clk= ~clk;
    end

    task check;
        reg [2:1] i,j;
        begin
            for(i=0;i<2;i=i+1) begin
                for(j=0;j<2;j=j+1) begin
                    s=i; r=j;
                    #7
                    $display("s=%b | r=%b | q=%b |qb=%b", s,r,q,qb);
                end
            end
        end
    endtask

    initial begin
        
        check();
        check();
        check();

        $finish;
    end



endmodule