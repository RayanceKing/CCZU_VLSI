module tb_full_adder;

    reg A;           // 测试输入 A
    reg B;           // 测试输入 B
    reg Cin;         // 测试输入 Cin
    wire S;          // 输出 S
    wire Cout;       // 输出 Cout

    // 实例化全加器
    full_adder uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );

    // 生成 VCD 文件
    initial begin
        $dumpfile("full_adder_with_half_adder.vcd"); // 指定 VCD 文件名
        $dumpvars(0, tb_full_adder); // 指定记录变量的层次
    end

    // 测试向量
    initial begin
        $display("A B Cin | S Cout"); // 打印标题
        A = 0; B = 0; Cin = 0; #10 $display("%b %b  %b  | %b  %b", A, B, Cin, S, Cout);
        A = 0; B = 0; Cin = 1; #10 $display("%b %b  %b  | %b  %b", A, B, Cin, S, Cout);
        A = 0; B = 1; Cin = 0; #10 $display("%b %b  %b  | %b  %b", A, B, Cin, S, Cout);
        A = 0; B = 1; Cin = 1; #10 $display("%b %b  %b  | %b  %b", A, B, Cin, S, Cout);
        A = 1; B = 0; Cin = 0; #10 $display("%b %b  %b  | %b  %b", A, B, Cin, S, Cout);
        A = 1; B = 0; Cin = 1; #10 $display("%b %b  %b  | %b  %b", A, B, Cin, S, Cout);
        A = 1; B = 1; Cin = 0; #10 $display("%b %b  %b  | %b  %b", A, B, Cin, S, Cout);
        A = 1; B = 1; Cin = 1; #10 $display("%b %b  %b  | %b  %b", A, B, Cin, S, Cout);
        $finish; // 结束仿真
    end

endmodule
