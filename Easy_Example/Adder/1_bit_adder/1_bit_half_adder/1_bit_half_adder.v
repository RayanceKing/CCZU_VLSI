module half_adder (
    input wire a,   // 第一个输入
    input wire b,   // 第二个输入
    output wire S,  // 和输出
    output wire C   // 进位输出
);

    // 使用布尔表达式定义和和进位
    assign S = a ^ b; // 异或操作：a XOR b
    assign C = a & b; // 与操作：a AND b

endmodule
