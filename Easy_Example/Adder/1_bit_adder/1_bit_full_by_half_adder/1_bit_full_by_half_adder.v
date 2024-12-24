//此处需要
//  1_bit_adder/1_bit_half_adder/1_bit_half_adder.v
module full_adder (
    input wire A,      // 第一个输入
    input wire B,      // 第二个输入
    input wire Cin,    // 输入进位
    output wire S,     // 和输出
    output wire Cout   // 输出进位
);

    wire S1, C1, C2;   // 中间信号

    // 实例化第一个半加器
    half_adder ha1 (
        .a(A),
        .b(B),
        .S(S1),
        .C(C1)
    );

    // 实例化第二个半加器
    half_adder ha2 (
        .a(S1),
        .b(Cin),
        .S(S),
        .C(C2)
    );

    // 通过 OR 门合并两个进位
    assign Cout = C1 | C2;

endmodule
