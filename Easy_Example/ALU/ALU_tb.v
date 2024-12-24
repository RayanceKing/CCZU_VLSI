module tb_ALU;

    reg [3:0] A;        // 测试输入 A
    reg [3:0] B;        // 测试输入 B
    reg [2:0] Opcode;   // 测试操作码
    wire [3:0] Result;  // 测试输出结果
    wire CarryOut;      // 测试进位输出

    // 实例化 ALU
    ALU uut (
        .A(A),
        .B(B),
        .Opcode(Opcode),
        .Result(Result),
        .CarryOut(CarryOut)
    );

    // 生成 VCD 文件
    initial begin
        $dumpfile("ALU.vcd"); // 指定 VCD 文件名
        $dumpvars(0, tb_ALU); // 指定记录变量的层次
    end

    // 测试向量
    initial begin
        $display("A\tB    Opcode | Result\tCarryOut"); // 打印标题

        A = 4'b0011; B = 4'b0001; Opcode = 3'b000;  #10 $display("%b\t%b\t%b | %b\t%b", A, B, Opcode, Result, CarryOut); // 加法
        A = 4'b0101; B = 4'b0011; Opcode = 3'b001;  #10 $display("%b\t%b\t%b | %b\t%b", A, B, Opcode, Result, CarryOut); // 减法
        A = 4'b1100; B = 4'b1010; Opcode = 3'b010;  #10 $display("%b\t%b\t%b | %b", A, B, Opcode, Result);            // 按位与
        A = 4'b1100; B = 4'b1010; Opcode = 3'b011;  #10 $display("%b\t%b\t%b | %b", A, B, Opcode, Result);            // 按位或
        A = 4'b1100; B = 4'b1010; Opcode = 3'b100;  #10 $display("%b\t%b\t%b | %b", A, B, Opcode, Result);            // 按位异或
        A = 4'b1100; Opcode = 3'b101;               #10 $display("%b\t\t%b | %b", A, Opcode, Result);                // 按位取反
        A = 4'b1100; Opcode = 3'b110;               #10 $display("%b\t\t%b | %b", A, Opcode, Result);                // 左移
        A = 4'b1100; Opcode = 3'b111;               #10 $display("%b\t\t%b | %b", A, Opcode, Result);                // 右移

        $finish; // 结束仿真
    end

endmodule
