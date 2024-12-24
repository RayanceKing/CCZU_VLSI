module testbench;

    reg clk;
    reg reset;
    reg din;
    wire dout;

    // 实例化序列检测器
    moore_sequence_detector uut (
        .clk(clk),
        .reset(reset),
        .din(din),
        .dout(dout)
    );

    // 生成时钟信号
    always #5 clk = ~clk;

    initial begin
        $dumpfile("moore_sequence_detector.vcd"); // 指定 VCD 文件名
        $dumpvars(0, testbench);                 // 记录所有变量

        // 初始化信号
        clk = 0;
        reset = 1;
        din = 0;

        // 释放复位
        #10 reset = 0;

        // 输入序列：1011101，应该在检测到第二个 1101 时输出 1
        #10 din = 1;
        #10 din = 0;
        #10 din = 1;
        #10 din = 1;
        #10 din = 0;
        #10 din = 1; // 此时检测到第一个 1101
        #10 din = 1;
        #10 din = 0;
        #10 din = 1; // 此时检测到第二个 1101

        // 停止仿真
        #50 $finish;
    end

endmodule
