module tb_sequence_detector_moore_overlap;

    reg clk;          // 时钟信号
    reg reset;        // 复位信号
    reg in;           // 输入序列
    wire out;         // 输出序列检测结果

    // 实例化序列检测器
    sequence_detector_moore_overlap uut (
        .clk(clk),
        .reset(reset),
        .in(in),
        .out(out)
    );

    // 生成 VCD 文件
    initial begin
        $dumpfile("sequence_detector_moore_overlap.vcd"); // 指定 VCD 文件名
        $dumpvars(0, tb_sequence_detector_moore_overlap); // 指定记录变量的层次
    end

    // 时钟生成（周期为 10 单位时间）
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 每 5 单位时间反转时钟
    end

    // 测试向量
    initial begin
        $display("in | out");  // 打印标题

        // 初始化
        reset = 1; in = 0; #10 reset = 0;  // 复位初始化
        #10 in = 1; #10 in = 1; #10 in = 0; #10 in = 1;  // 测试序列1101
        #10 in = 1; #10 in = 0; #10 in = 1; #10 in = 0;  // 测试序列1010
        #10 in = 1; #10 in = 1; #10 in = 0; #10 in = 1;  // 测试序列1101
        #10 in = 0; #10 in = 1; #10 in = 1; #10 in = 0;  // 测试序列0110

        $finish; // 结束仿真
    end

endmodule
