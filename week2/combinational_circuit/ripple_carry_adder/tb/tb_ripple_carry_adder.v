`timescale 1ns/1ps
module tb_ripple_carry_adder;

    reg [3:0] a, b;
    reg cin;
    wire [3:0] sum;
    wire carry_out;

    ripple_carry_adder #(.N(4)) dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .carry_out(carry_out)
    );
    
    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_ripple_carry_adder);
    end

    integer pass=0;
    integer fail=0;

    task exhaustive;
        reg [5:0] i,j;
        reg [1:0] k; 
        reg [3:0] exp_sum;
        reg exp_carry_out;
        begin
            for (i=0;i<16;i=i+1) begin
                a=i;
                for(j=0;j<16;j=j+1) begin
                    b=j;
                    for (k=0;k<2;k=k+1) begin
                        cin=k;
                        {exp_carry_out,exp_sum} = a + b + cin;
                        #10;
                        if(exp_sum === sum && exp_carry_out === carry_out) begin
                            $display("PASS: a=%b b=%b cin=%b | carry_out=%b sum=%b",a,b,cin,carry_out,sum);
                            pass=pass+1;

                        end
                        else begin
                            $display("FAIL: a=%b b=%b cin=%b | carry_out=%b sum=%b | exp_carry_out=%b exp_sum=%b",a,b,cin,carry_out,sum,exp_carry_out,exp_sum);
                            fail=fail+1;
                        end

                    end
                end
            end
            

        end

    endtask

    task check;
        input [3:0] t_a, t_b;
        input t_cin;
        reg [3:0] exp_sum;
        reg exp_carry_out;
        begin
            a=t_a; b=t_b; cin=t_cin;
            {exp_carry_out,exp_sum} = a+b+cin;
            #10;
            if(exp_sum === sum && exp_carry_out === carry_out) begin
                $display("PASS: a=%b b=%b cin=%b | carry_out=%b sum=%b",a,b,cin,carry_out,sum);
                    pass=pass+1;

            end
            else begin
                $display("FAIL: a=%b b=%b cin=%b | carry_out=%b sum=%b | exp_carry_out=%b exp_sum=%b",a,b,cin,carry_out,sum,exp_carry_out,exp_sum);
                fail=fail+1;
            end

        end

    endtask

    initial begin
        exhaustive();
        check(4'h0,4'h0,1'b0);
        check(4'h15,4'h15,1'b1);
        check(4'h15,4'h15,1'b0);
        check(4'h15,4'h15,1'b1);
        check(4'h15,4'h0,1'b0);
        check(4'h15,4'h1,1'b0);
        check(4'h1,4'h0,1'b0);
        check(4'h0,4'h1,1'b0);

        $display("Test Summary:");
        $display("PASS:%d",pass);
        $display("FAIL:%d",fail);
        $finish;

    end


endmodule