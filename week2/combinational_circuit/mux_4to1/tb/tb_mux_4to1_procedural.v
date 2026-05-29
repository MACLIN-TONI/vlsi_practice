`timescale 1ns/1ps
module tb_mux_4to1_procedural;
    reg a, b, c, d;
    reg [1:0] sel;
    wire out;
    mux_4to1_procedural dut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel),
        .out(out)

    );
    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_mux_4to1_procedural);
    end

    integer pass=0;
    integer fail=0;
    reg [1:0] t_sel;
    reg exp_out;
    integer i;

    task check;
        input [6*8-1:0] case_type;
        input t_a, t_b, t_c, t_d;
        
        begin
            a=t_a; b=t_b; c=t_c; d=t_d;
            
            
            $display("%s case",case_type);
            
            for(i=0;i<4;i=i+1) begin
                t_sel=i;
                sel=t_sel;
                case(t_sel)
                    2'b00:exp_out=t_a;
                    2'b01:exp_out=t_b;
                    2'b10:exp_out=t_c;
                    2'b11:exp_out=t_d;
                endcase
                
                #10;
                
                if (exp_out === out) begin
                $display("PASS: a=%b b=%b c=%b d=%b sel=%b out=%b",
                         a,b,c,d,sel,out);
                pass = pass + 1;
                end
                else begin
                    $display("FAIL: a=%b b=%b c=%b d=%b sel=%b out=%b exp=%b",
                        a,b,c,d,sel,out,exp_out);
                    fail = fail + 1;
                end
            end


            
            

        end

    endtask

    initial begin
        // integer i,j,k,l,m;
        // reg exp;
        // for(i=0;i<4;i=i+1) begin
        //     for (j=0;j<4;j=j+1) begin
        //         for(k=0;k<4;k=k+1) begin
        //             for(l=0;l<4;l=l+1) begin
        //                 for(m=0;m<4;m=m+1) begin
        //                     case(m)
        //                         2'b00:exp=i;
        //                         2'b01:exp=j;
        //                         2'b10:exp=k;
        //                         2'b11:exp=l;
        //                     endcase
        //                     check(i,j,k,l,m,exp);
        //                 end
                        
        //             end
        //         end
        //     end
        // end



        check("normal",1,0,1,0);
        check("corner",0,0,0,0);
        check("corner",1,1,1,1);
        check("corner",1,0,0,0);
        check("corner",0,1,0,0);
        check("corner",0,0,1,0);
        check("corner",0,0,0,1);


        $display("Test summary: %d passed, %d failed", pass, fail);
        $finish;
    end


endmodule
