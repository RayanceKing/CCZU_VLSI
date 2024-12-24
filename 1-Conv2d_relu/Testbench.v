module testbench;
    reg clk;
    reg reset;
    reg signed [7:0] input_feature_map_00, input_feature_map_01, input_feature_map_02;
    reg signed [7:0] input_feature_map_10, input_feature_map_11, input_feature_map_12;
    reg signed [7:0] input_feature_map_20, input_feature_map_21, input_feature_map_22;
    reg signed [7:0] kernel_00, kernel_01, kernel_02;
    reg signed [7:0] kernel_10, kernel_11, kernel_12;
    reg signed [7:0] kernel_20, kernel_21, kernel_22;
    wire signed [15:0] output_feature_map;

    // 实例化被测模块
    Conv2D_ReLU uut (
        .clk(clk),
        .reset(reset),
        .input_feature_map_00(input_feature_map_00), .input_feature_map_01(input_feature_map_01), .input_feature_map_02(input_feature_map_02),
        .input_feature_map_10(input_feature_map_10), .input_feature_map_11(input_feature_map_11), .input_feature_map_12(input_feature_map_12),
        .input_feature_map_20(input_feature_map_20), .input_feature_map_21(input_feature_map_21), .input_feature_map_22(input_feature_map_22),
        .kernel_00(kernel_00), .kernel_01(kernel_01), .kernel_02(kernel_02),
        .kernel_10(kernel_10), .kernel_11(kernel_11), .kernel_12(kernel_12),
        .kernel_20(kernel_20), .kernel_21(kernel_21), .kernel_22(kernel_22),
        .output_feature_map(output_feature_map)
    );

    initial begin
        // 启用波形记录
        $dumpfile("wave.vcd"); // 指定波形文件名称
        $dumpvars(0, testbench); // 记录testbench模块中的所有信号

        clk = 0;
        reset = 1;

        // 模拟时钟
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        #10 reset = 0;

        // 提供输入特征图和卷积核
        input_feature_map_00 = 1; input_feature_map_01 = 2; input_feature_map_02 = 3;
        input_feature_map_10 = 4; input_feature_map_11 = 5; input_feature_map_12 = 6;
        input_feature_map_20 = 7; input_feature_map_21 = 8; input_feature_map_22 = 9;

        kernel_00 = 1; kernel_01 = 0; kernel_02 = -1;
        kernel_10 = 1; kernel_11 = 0; kernel_12 = -1;
        kernel_20 = 1; kernel_21 = 0; kernel_22 = -1;

        #20;
        $stop;  // 结束仿真
    end
endmodule
