module tb_half_adder;

    reg a;          // 测试输入 a
    reg b;          // 测试输入 b
    wire S;         // 输出 S
    wire C;         // 输出 C

    // 实例化半加器
    half_adder uut (
        .a(a),
        .b(b),
        .S(S),
        .C(C)
    );

    // 生成 VCD 文件
    initial begin
        $dumpfile("half_adder.vcd"); // 指定 VCD 文件名
        $dumpvars(0, tb_half_adder); // 指定记录变量的层次
    end

    // 测试向量
    initial begin
        $display("A B | S C"); // 打印标题
        a = 0; b = 0; #10 $display("%b %b | %b %b", a, b, S, C);
        a = 0; b = 1; #10 $display("%b %b | %b %b", a, b, S, C);
        a = 1; b = 0; #10 $display("%b %b | %b %b", a, b, S, C);
        a = 1; b = 1; #10 $display("%b %b | %b %b", a, b, S, C);
        $finish;
    end

endmodule
