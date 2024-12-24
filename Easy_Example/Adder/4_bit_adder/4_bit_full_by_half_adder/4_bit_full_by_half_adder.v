//此处需要
//  1_bit_adder/1_bit_half_adder/1_bit_half_adder.v
//  1_bit_adder/1_bit_full_by_half_adder/1_bit_full_by_half_adder.v
module four_bit_adder (
    input wire [3:0] A,     // 4 位输入 A
    input wire [3:0] B,     // 4 位输入 B
    input wire Cin,         // 输入进位
    output wire [3:0] S,    // 和输出（4 位）
    output wire Cout        // 输出进位
);

    wire C1, C2, C3;        // 中间进位信号

    // 实例化 4 个 1 位全加器
    full_adder fa0 (
        .A(A[0]),
        .B(B[0]),
        .Cin(Cin),
        .S(S[0]),
        .Cout(C1)
    );

    full_adder fa1 (
        .A(A[1]),
        .B(B[1]),
        .Cin(C1),
        .S(S[1]),
        .Cout(C2)
    );

    full_adder fa2 (
        .A(A[2]),
        .B(B[2]),
        .Cin(C2),
        .S(S[2]),
        .Cout(C3)
    );

    full_adder fa3 (
        .A(A[3]),
        .B(B[3]),
        .Cin(C3),
        .S(S[3]),
        .Cout(Cout)
    );

endmodule
