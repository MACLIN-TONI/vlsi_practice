`timescale 1ns/1ps

module tb_SR_latch_NOR;
    reg clk;
    reg s;
    reg r;
    wire q;
    wire qb;

    SR_latch_NOR dut(
        .clk(clk),
        .s(s),
        .r(r),
        .q(q),
        .qb(qb)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_SR_latch_NOR);
    end

    initial begin
        clk=0;
        
    end
    always #5 clk = ~clk;
    
    task check;
        reg [2:0] i,j;
        begin
            
            for(i=0;i<2;i=i+1) begin
                for(j=0;j<2;j=j+1) begin
                    
                    s=i;r=j;
                    #10;
                    $display("s=%b | r=%b | q=%b | qb=%b", s,r,q,qb);

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