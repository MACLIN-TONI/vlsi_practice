`timescale 1ns/1ps
module tb_demux_1to4;
    reg in;
    reg [1:0] sel;
    wire a, b, c, d;
    demux_1to4 dut (
        .in(in),
        .sel(sel),
        .a(a),
        .b(b),
        .c(c),
        .d(d)
    );
    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_demux_1to4);
    end
    
    integer pass=0;
    integer fail=0;
    reg exp_a, exp_b, exp_c, exp_d;
    

    task normal;
        integer i,j;
        begin
            
            $display("Normal Case");
            for(i=0;i<2;i=i+1) begin
                in=i;
                for(j=0;j<4;j=j+1) begin
                    sel=j;
                    exp_a=0;
                    exp_b=0;
                    exp_c=0;
                    exp_d=0;
                    case(sel)
                        2'b00:exp_a=in;
                        2'b01:exp_b=in;
                        2'b10:exp_c=in;
                        2'b11:exp_d=in;     
                    endcase
                    #10;
                    if(exp_a===a && exp_b === b && exp_c === c && exp_d === d) begin
                        $display("PASS: in=%b sel=%b | a=%b b=%b c=%b d=%b",in,sel,a,b,c,d);
                        pass=pass+1;
                    end
                    else begin
                        $display("FAIL: in=%b sel=%b | a=%b b=%b c=%b d=%b | exp_a=%b exp_b=%b exp_c=%b exp_d=%b",in,sel,a,b,c,d,exp_a,exp_b,exp_c,exp_d);
                        fail=fail+1;
                    end
                end
            end
        end
    endtask

    task boundary;
        input t_in;
        input [1:0] t_sel;
        begin
            $display("Boarder Case");
            in=t_in; sel=t_sel;
            exp_a=0;
            exp_b=0;
            exp_c=0;
            exp_d=0;
            case(sel)
                2'b00:exp_a=t_in;
                2'b01:exp_b=t_in;
                2'b10:exp_c=t_in;
                2'b11:exp_d=t_in;
            endcase
            #10;
            if(exp_a===a && exp_b === b && exp_c === c && exp_d === d) begin
                $display("PASS: in=%b sel=%b | a=%b b=%b c=%b d=%b",in,sel,a,b,c,d);
                pass=pass+1;
            end
            else begin
                $display("FAIL: in=%b sel=%b | a=%b b=%b c=%b d=%b | exp_a=%b exp_b=%b exp_c=%b exp_d=%b",in,sel,a,b,c,d,exp_a,exp_b,exp_c,exp_d);
                fail=fail+1;
            end
        end
    endtask

    task diff_control;
        input t_in;
        integer i;
        begin
            $display("diff_control Case");
            in=t_in;
            
            for(i=0;i<4;i=i+1) begin
                sel=i;
                exp_a=0;
                exp_b=0;
                exp_c=0;
                exp_d=0;
                case(sel)
                    2'b00:exp_a=t_in;
                    2'b01:exp_b=t_in;
                    2'b10:exp_c=t_in;
                    2'b11:exp_d=t_in;
                endcase
                #10;
                if(exp_a===a && exp_b === b && exp_c === c && exp_d === d) begin
                    $display("PASS: in=%b sel=%b | a=%b b=%b c=%b d=%b",in,sel,a,b,c,d);
                    pass=pass+1;
                end
                else begin
                    $display("FAIL: in=%b sel=%b | a=%b b=%b c=%b d=%b | exp_a=%b exp_b=%b exp_c=%b exp_d=%b",in,sel,a,b,c,d,exp_a,exp_b,exp_c,exp_d);
                    fail=fail+1;
                end
            end
        end
    endtask

    task diff_input;
        input [1:0] t_sel;
        integer i;
        begin
            $display("diff_input Case");
            sel=t_sel;
            for(i=0;i<2;i=i+1) begin
                in=i;
                exp_a=0;
                exp_b=0;
                exp_c=0;
                exp_d=0;
                case(t_sel)
                    2'b00:exp_a=in;
                    2'b01:exp_b=in;
                    2'b10:exp_c=in;
                    2'b11:exp_d=in;

                endcase
                #10;
                if(exp_a===a && exp_b === b && exp_c === c && exp_d === d) begin
                    $display("PASS: in=%b sel=%b | a=%b b=%b c=%b d=%b",in,sel,a,b,c,d);
                    pass=pass+1;
                end
                else begin
                    $display("FAIL: in=%b sel=%b | a=%b b=%b c=%b d=%b | exp_a=%b exp_b=%b exp_c=%b exp_d=%b",in,sel,a,b,c,d,exp_a,exp_b,exp_c,exp_d);
                    fail=fail+1;
                end
            end
        end
    endtask

   

    initial begin
        normal();

        boundary(1,2'b11);
        boundary(0,2'b00);

        diff_control(1'b1);
        diff_control(1'b0);

        diff_input(2'b11);
        diff_input(2'b00);
        

        $display("Test summary:");
        $display("PASS:%d",pass);
        $display("FAIL:%d",fail);
        

    end

endmodule