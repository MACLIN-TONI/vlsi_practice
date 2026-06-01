`timescale 1ns/1ps
module tb_comparator_4bit;
    reg [3:0] a, b;
    wire eq, lt, gt;

    comparator_4bit dut (
        .a(a),
        .b(b),
        .eq(eq),
        .lt(lt),
        .gt(gt)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_comparator_4bit);
    end

    integer pass=0;
    integer fail=0;

    task exhaustive_sweep;
        input [3:0] t_a;
        reg exp_eq, exp_lt, exp_gt;
        reg [4:0] i;
        begin
            a=t_a;
            $display("Exhaustive Sweep Test");
            for(i=0;i<16;i=i+1) begin
                b=i;
                exp_eq = (t_a == b);
                exp_lt = (t_a < b);
                exp_gt = (t_a > b);
                #10;
                
                if(exp_eq === eq && exp_lt === lt && exp_gt === gt) begin
                    if((eq + lt + gt) !== 1) begin
                        $display("Multiple outputs high simultaneously");
                    end
                    else begin
                        $display("PASS: a=%b b=%b | eq =%b lt=%b gt=%b",a,b,eq,lt,gt);
                        pass=pass+1;
                    end
                    
                end
                else begin
                    $display("FAIL: a=%b b=%b | eq =%b lt=%b gt=%b | exp_eq=%b exp_lt=%b exp_gt=%b",a,b,eq,lt,gt,exp_eq,exp_lt,exp_gt);
                    fail=fail+1;
                end


            end
            
            
        end
    endtask

    task check;
        input reg [99:0] case_type;
        input reg [3:0] t_a, t_b;
        reg exp_eq, exp_lt, exp_gt;
        begin
            $display("%s test",case_type);
            a=t_a;
            b=t_b;
            exp_eq = (t_a == t_b);
            exp_lt = (t_a < t_b);
            exp_gt = (t_a > t_b);
            #10;
                
            if(exp_eq === eq && exp_lt === lt && exp_gt === gt) begin
                if((eq + lt + gt) !== 1) begin               
                     $display("Multiple outputs high simultaneously");
                end
                else begin
                    $display("PASS: a=%b b=%b | eq =%b lt=%b gt=%b",a,b,eq,lt,gt);
                    pass=pass+1;
                end
                    
            end 
            else begin
                $display("FAIL: a=%b b=%b | eq =%b lt=%b gt=%b | exp_eq=%b exp_lt=%b exp_gt=%b",a,b,eq,lt,gt,exp_eq,exp_lt,exp_gt);
                fail=fail+1;
            end

        end
    endtask

    initial begin
        exhaustive_sweep(10);
        check("Boundary",0,0);
        check("Boundary",15,15);
        check("Boundary",0,15);
        check("Boundary",15,0);
        check("Symmetric",4,5);
        check("Symmetric",5,4);
        check("Equal",8,8);
        check("Isolation",0,1);
        check("Isolation",1,0);
        
        $display("Test summary");
        $display("Pass:%d",pass);
        $display("FAIL:%d",fail);
        $finish;
        
        
    end

endmodule
