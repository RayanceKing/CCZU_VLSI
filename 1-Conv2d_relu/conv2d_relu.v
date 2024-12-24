module Conv2D_ReLU (
    input wire clk,
    input wire reset,
    input wire signed [7:0] input_feature_map_00, input_feature_map_01, input_feature_map_02,
    input wire signed [7:0] input_feature_map_10, input_feature_map_11, input_feature_map_12,
    input wire signed [7:0] input_feature_map_20, input_feature_map_21, input_feature_map_22,
    input wire signed [7:0] kernel_00, kernel_01, kernel_02,
    input wire signed [7:0] kernel_10, kernel_11, kernel_12,
    input wire signed [7:0] kernel_20, kernel_21, kernel_22,
    output reg signed [15:0] output_feature_map
);
    // 中间变量，用于存储卷积结果
    reg signed [15:0] conv_result;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // 复位时输出特征图清零
            output_feature_map <= 0;
        end else begin
            // 卷积操作：逐项乘法累加
            conv_result = input_feature_map_00 * kernel_00 +
                          input_feature_map_01 * kernel_01 +
                          input_feature_map_02 * kernel_02 +
                          input_feature_map_10 * kernel_10 +
                          input_feature_map_11 * kernel_11 +
                          input_feature_map_12 * kernel_12 +
                          input_feature_map_20 * kernel_20 +
                          input_feature_map_21 * kernel_21 +
                          input_feature_map_22 * kernel_22;

            // ReLU 激活函数
            if (conv_result < 0) begin
                output_feature_map <= 0;
            end else begin
                output_feature_map <= conv_result;
            end
        end
    end
endmodule
