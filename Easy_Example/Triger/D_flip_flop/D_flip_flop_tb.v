module tb_D_flip_flop;

    reg D;               // 测试输入 D
    reg clk;             // 测试时钟
    reg reset;           // 测试复位信号
    wire Q;              // 测试输出 Q

    // 实例化 D 触发器
    D_flip_flop uut (
        .D(D),
        .clk(clk),
        .reset(reset),
        .Q(Q)
    );

    // 生成 VCD 文件
    initial begin
        $dumpfile("D_flip_flop.vcd"); // 指定 VCD 文件名
        $dumpvars(0, tb_D_flip_flop); // 指定记录变量的层次
    end

    // 时钟生成（周期为 10 单位时间）
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 每 5 单位时间反转时钟
    end

    // 测试向量
    initial begin
        $display(" D  Reset  | Q"); // 打印标题

        // 初始化
        D = 0; reset = 0; #10 $display("%b %b  | %b", D, reset, Q);

        // 测试复位信号
        D = 1; reset = 1; #10 $display("%b %b  | %b", D, reset, Q); // 复位使 Q = 0
        reset = 0; #10 $display("%b %b  | %b", D, reset, Q);        // Q = D

        // 测试时钟触发
        D = 0; reset = 0; #10 $display("%b %b  | %b", D, reset, Q); // Q = D
        D = 1; reset = 0; #10 $display("%b %b  | %b", D, reset, Q); // Q = D

        // 测试复位信号再激活
        D = 1; reset = 1; #10 $display("%b %b  | %b", D, reset, Q); // 复位使 Q = 0
        reset = 0; #10 $display("%b %b  | %b", D, reset, Q);        // Q = D

        $finish; // 结束仿真
    end

endmodule
