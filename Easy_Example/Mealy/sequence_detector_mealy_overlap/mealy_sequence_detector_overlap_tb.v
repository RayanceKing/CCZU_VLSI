module testbench;

    reg clk;
    reg reset;
    reg din;
    wire dout;

    // 实例化序列检测器
    mealy_sequence_detector_overlap uut (
        .clk(clk),
        .reset(reset),
        .din(din),
        .dout(dout)
    );

    // 时钟信号生成
    always #5 clk = ~clk;

    initial begin
        $dumpfile("mealy_sequence_detector_overlap.vcd"); // 生成 VCD 文件
        $dumpvars(0, testbench);                         // 记录所有变量

        // 初始化信号
        clk = 0;
        reset = 1;
        din = 0;

        // 释放复位信号
        #10 reset = 0;

        // 输入序列：1101101，支持重叠，dout 应在第 4 和第 6 个时钟周期为 1
        #10 din = 1; // 输入 1
        #10 din = 1; // 输入 1
        #10 din = 0; // 输入 0
        #10 din = 1; // 输出 dout = 1，此时检测到第一个 1101
        #10 din = 1; // 输入 1
        #10 din = 0; // 输入 0
        #10 din = 1; // 输出 dout = 1，此时检测到第二个 1101

        // 停止仿真
        #50 $finish;
    end

endmodule
