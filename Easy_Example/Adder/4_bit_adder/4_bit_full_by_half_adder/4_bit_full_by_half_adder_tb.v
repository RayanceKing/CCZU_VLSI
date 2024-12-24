module tb_four_bit_adder;

    reg [3:0] A;        // 测试输入 A
    reg [3:0] B;        // 测试输入 B
    reg Cin;            // 测试输入 Cin
    wire [3:0] S;       // 输出和
    wire Cout;          // 输出进位

    // 实例化 4 位全加器
    four_bit_adder uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );

    // 生成 VCD 文件
    initial begin
        $dumpfile("four_bit_adder.vcd"); // 指定 VCD 文件名
        $dumpvars(0, tb_four_bit_adder); // 指定记录变量的层次
    end

    // 测试向量
    initial begin
        $display(" A   B  Cin |  S   Cout"); // 打印标题
        A = 4'b0000; B = 4'b0000; Cin = 0; #10 $display("%b %b  %b  | %b  %b", A, B, Cin, S, Cout);
        A = 4'b0001; B = 4'b0010; Cin = 0; #10 $display("%b %b  %b  | %b  %b", A, B, Cin, S, Cout);
        A = 4'b0101; B = 4'b0011; Cin = 0; #10 $display("%b %b  %b  | %b  %b", A, B, Cin, S, Cout);
        A = 4'b0111; B = 4'b0110; Cin = 1; #10 $display("%b %b  %b  | %b  %b", A, B, Cin, S, Cout);
        A = 4'b1111; B = 4'b1111; Cin = 0; #10 $display("%b %b  %b  | %b  %b", A, B, Cin, S, Cout);
        A = 4'b1111; B = 4'b1111; Cin = 1; #10 $display("%b %b  %b  | %b  %b", A, B, Cin, S, Cout);
        $finish; // 结束仿真
    end

endmodule
