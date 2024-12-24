module full_adder (
    input wire A,      // 第一个输入
    input wire B,      // 第二个输入
    input wire Cin,    // 输入进位
    output wire S,     // 和输出
    output wire Cout   // 输出进位
);

    // 全加器逻辑
    assign S = A ^ B ^ Cin;       // 异或操作：A XOR B XOR Cin
    assign Cout = (A & B) | (B & Cin) | (A & Cin); // 进位逻辑

endmodule
