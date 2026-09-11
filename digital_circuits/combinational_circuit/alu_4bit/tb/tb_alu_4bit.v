`timescale 1ns/1ps
module tb_alu_4bit;

    reg signed [3:0] a, b;
    reg [2:0] opcode;
    wire zero;
    wire negative;
    wire overflow;
    wire carry_out;
    wire [3:0] out;

    alu_4bit dut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .zero(zero),
        .negative(negative),
        .overflow(overflow),
        .carry_out(carry_out),
        .out(out)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_alu_4bit);
    end

    integer pass=0;
    integer fail=0;

    task exhaustive;
        reg exp_zero;
        reg exp_negative;
        reg exp_overflow;
        reg exp_carry_out;
        reg [3:0] exp_out;
        reg [4:0] i, j;
        
        reg [3:0] o;
        begin
            for(i=0;i<16;i=i+1) begin
                a=i[3:0];
                for (j=0;j<16;j=j+1) begin
                    b=j[3:0];
                    for(o=0;o<8;o=o+1) begin
                        opcode = o;
                        exp_out=0;
                        exp_carry_out=0;
                        exp_overflow=0;
                        case (opcode) 
                            3'b000: begin
                                {exp_carry_out,exp_out} = {1'b0,a} + {1'b0,b};
                                exp_overflow = (a[3] == b[3]) && (a[3] != exp_out[3]);
                             end
            
                            3'b001: begin
                                {exp_carry_out,exp_out} = {1'b0,a} - {1'b0,b};
                                exp_overflow = (a[3] != b[3]) && (a[3] != exp_out[3]);
                            end
                            3'b010: exp_out = a&b;
                            3'b011: exp_out = a | b;
                            3'b100: exp_out = a ^ b;
                            3'b101: exp_out = ~a;
                            3'b110: begin
                                // a - 1 1 1 1 -> 1 1 1 0
                                exp_out = a << 1;
                                exp_carry_out = a[3];
                            end 
                            3'b111: begin
                                // a - 1 1 1 1 -> 0 1 1 1
                                exp_out = a >>> 1;
                                exp_carry_out = a[0];
                            end
                            default: begin
                                exp_out= 4'bxxxx;
                                exp_carry_out = 1'bx;
                                exp_overflow = 1'bx;
                            end
                        endcase
                        exp_zero = (exp_out == 4'b0000);
                        exp_negative = (exp_out[3] == 1'b1);
                        #10;
                        if(exp_zero === zero && exp_negative === negative && exp_overflow === overflow && exp_carry_out === carry_out && exp_out === out) begin
                            $display("PASS: a=%d a=%b b=%d b=%b opcode=%b | zero=%b negative=%b overflow=%b carry_out=%b out=%b",a,a,b,b,opcode,zero,negative,overflow,carry_out,out);
                            pass=pass+1;
                        end
                        else begin
                            $display("FAIL: a=%d a=%b b=%d b=%b opcode=%b | zero=%b negative=%b overflow=%b carry_out=%b out=%b | exp_zero=%b exp_negative=%b exp_overflow=%b exp_carry_out=%b exp_out=%b",a,a,b,b,opcode,zero,negative,overflow,carry_out,out,exp_zero,exp_negative,exp_overflow,exp_carry_out,exp_out);
                            fail=fail+1;
                        end

                    end
                end

            end
            
        end
    endtask

    task opcode_sweep;
        input signed [3:0] t_a, t_b;
        reg exp_zero;
        reg exp_negative;
        reg exp_overflow;
        reg exp_carry_out;
        reg [3:0] exp_out;
        reg [3:0] o;
        begin
            a=t_a; b=t_b;
            for(o=0;o<8;o=o+1) begin
                opcode=o;
                exp_zero=0;
                exp_negative=0;
                exp_overflow=0;
                exp_carry_out=0;
                exp_out=0;
                case (opcode) 
                3'b000: begin
                    {exp_carry_out,exp_out} = {1'b0,a} + {1'b0,b};
                    exp_overflow = (a[3] == b[3]) && (a[3] != exp_out[3]);
                 end
            
                3'b001: begin
                    {exp_carry_out,exp_out} = {1'b0,a} - {1'b0,b};
                    exp_overflow = (a[3] != b[3]) && (a[3] != exp_out[3]);
                end
                3'b010: exp_out = a&b;
                3'b011: exp_out = a | b;
                3'b100: exp_out = a ^ b;
                3'b101: exp_out = ~a;
                3'b110: begin
                    // a - 1 1 1 1 -> 1 1 1 0
                    exp_out = a << 1;
                    exp_carry_out = a[3];
                end 
                3'b111: begin
                    // a - 1 1 1 1 -> 0 1 1 1
                    exp_out = a >>> 1;
                    exp_carry_out = a[0];
                end
                default: begin
                    exp_out= 4'bxxxx;
                    exp_carry_out = 1'bx;
                    exp_overflow = 1'bx;
                end
                endcase
                exp_zero = (exp_out == 4'b0000);
                exp_negative = (exp_out[3] == 1'b1);
                #10;
                if(exp_zero === zero && exp_negative === negative && exp_overflow === overflow && exp_carry_out === carry_out && exp_out === out) begin
                    $display("PASS: a=%d a=%b b=%d b=%b opcode=%b | zero=%b negative=%b overflow=%b carry_out=%b out=%b",a,a,b,b,opcode,zero,negative,overflow,carry_out,out);
                    pass=pass+1;
                end
                else begin
                    $display("FAIL: a=%d a=%b b=%d b=%b opcode=%b | zero=%b negative=%b overflow=%b carry_out=%b out=%b | exp_zero=%b exp_negative=%b exp_overflow=%b exp_carry_out=%b exp_out=%b",a,a,b,b,opcode,zero,negative,overflow,carry_out,out,exp_zero,exp_negative,exp_overflow,exp_carry_out,exp_out);
                    fail=fail+1;
                end

                
            end
        end

    endtask

    task input_sweep;
        input [3:0] t_opcode;
        reg exp_zero;
        reg exp_negative;
        reg exp_overflow;
        reg exp_carry_out;
        reg [3:0] exp_out;
        reg [4:0] i, j;
        
        
        begin
            for(i=0;i<16;i=i+1) begin
                a=i[3:0];
                for (j=0;j<16;j=j+1) begin
                    b=j[3:0];
                    
                        opcode = t_opcode;
                        exp_out=0;
                        exp_carry_out=0;
                        exp_overflow=0;
                        case (opcode) 
                            3'b000: begin
                                {exp_carry_out,exp_out} = {1'b0,a} + {1'b0,b};
                                exp_overflow = (a[3] == b[3]) && (a[3] != exp_out[3]);
                             end
            
                            3'b001: begin
                                {exp_carry_out,exp_out} = {1'b0,a} - {1'b0,b};
                                exp_overflow = (a[3] != b[3]) && (a[3] != exp_out[3]);
                            end
                            3'b010: exp_out = a&b;
                            3'b011: exp_out = a | b;
                            3'b100: exp_out = a ^ b;
                            3'b101: exp_out = ~a;
                            3'b110: begin
                                // a - 1 1 1 1 -> 1 1 1 0
                                exp_out = a << 1;
                                exp_carry_out = a[3];
                            end 
                            3'b111: begin
                                // a - 1 1 1 1 -> 0 1 1 1
                                exp_out = a >>> 1;
                                exp_carry_out = a[0];
                            end
                            default: begin
                                exp_out= 4'bxxxx;
                                exp_carry_out = 1'bx;
                                exp_overflow = 1'bx;
                            end
                        endcase
                        exp_zero = (exp_out == 4'b0000);
                        exp_negative = (exp_out[3] == 1'b1);
                        #10;
                        if(exp_zero === zero && exp_negative === negative && exp_overflow === overflow && exp_carry_out === carry_out && exp_out === out) begin
                            $display("PASS: a=%d a=%b b=%d b=%b opcode=%b | zero=%b negative=%b overflow=%b carry_out=%b out=%b",a,a,b,b,opcode,zero,negative,overflow,carry_out,out);
                            pass=pass+1;
                        end
                        else begin
                            $display("FAIL: a=%d a=%b b=%d b=%b opcode=%b | zero=%b negative=%b overflow=%b carry_out=%b out=%b | exp_zero=%b exp_negative=%b exp_overflow=%b exp_carry_out=%b exp_out=%b",a,a,b,b,opcode,zero,negative,overflow,carry_out,out,exp_zero,exp_negative,exp_overflow,exp_carry_out,exp_out);
                            fail=fail+1;
                        end

                    
                end

            end
            
        end
    endtask

    task check;
        input signed [3:0] t_a, t_b;
        input [3:0] t_opcode;
        reg exp_zero;
        reg exp_negative;
        reg exp_overflow;
        reg exp_carry_out;
        reg [3:0] exp_out;
        
        begin
            a=t_a; b=t_b;
            
                opcode=t_opcode;
                exp_zero=0;
                exp_negative=0;
                exp_overflow=0;
                exp_carry_out=0;
                exp_out=0;
                case (opcode) 
                3'b000: begin
                    {exp_carry_out,exp_out} = {1'b0,a} + {1'b0,b};
                    exp_overflow = (a[3] == b[3]) && (a[3] != exp_out[3]);
                 end
            
                3'b001: begin
                    {exp_carry_out,exp_out} = {1'b0,a} - {1'b0,b};
                    exp_overflow = (a[3] != b[3]) && (a[3] != exp_out[3]);
                end
                3'b010: exp_out = a&b;
                3'b011: exp_out = a | b;
                3'b100: exp_out = a ^ b;
                3'b101: exp_out = ~a;
                3'b110: begin
                    // a - 1 1 1 1 -> 1 1 1 0
                    exp_out = a << 1;
                    exp_carry_out = a[3];
                end 
                3'b111: begin
                    // a - 1 1 1 1 -> 0 1 1 1
                    exp_out = a >>> 1;
                    exp_carry_out = a[0];
                end
                default: begin
                    exp_out= 4'bxxxx;
                    exp_carry_out = 1'bx;
                    exp_overflow = 1'bx;
                end
                endcase
                exp_zero = (exp_out == 4'b0000);
                exp_negative = (exp_out[3] == 1'b1);
                #10;
                if(exp_zero === zero && exp_negative === negative && exp_overflow === overflow && exp_carry_out === carry_out && exp_out === out) begin
                    $display("PASS: a=%d a=%b b=%d b=%b opcode=%b | zero=%b negative=%b overflow=%b carry_out=%b out=%b",a,a,b,b,opcode,zero,negative,overflow,carry_out,out);
                    pass=pass+1;
                end
                else begin
                    $display("FAIL: a=%d a=%b b=%d b=%b opcode=%b | zero=%b negative=%b overflow=%b carry_out=%b out=%b | exp_zero=%b exp_negative=%b exp_overflow=%b exp_carry_out=%b exp_out=%b",a,a,b,b,opcode,zero,negative,overflow,carry_out,out,exp_zero,exp_negative,exp_overflow,exp_carry_out,exp_out);
                    fail=fail+1;
                end

                
            
        end

    endtask

    initial begin
        exhaustive();
        opcode_sweep(-4,5);
        input_sweep(3'b000);
        check(0,0,3'b000);
        check(4'b1111,4'b1111,3'b000);
        check(-8,-8,3'b000);
        check(7,7,3'b000);
        check(1,0,3'b001);
        check(0,1,3'b001);


        $display("Test summary:");
        $display("PASS:%d",pass);
        $display("FAIL:%d",fail);
        $finish;
    end

endmodule