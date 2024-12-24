module moore_sequence_detector_overlap(
    input wire clk,
    input wire reset,
    input wire din,          // 输入位流
    output reg dout          // 输出，1 表示检测到序列 1101
);

    // 状态定义
    parameter S0 = 3'b000;  // 初始状态
    parameter S1 = 3'b001;  // 检测到 1
    parameter S2 = 3'b010;  // 检测到 11
    parameter S3 = 3'b011;  // 检测到 110
    parameter S4 = 3'b100;  // 检测到 1101

    reg [2:0] current_state, next_state; // 3 位状态寄存器

    // 状态寄存器
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // 状态转移逻辑
    always @(*) begin
        case (current_state)
            S0: next_state = din ? S1 : S0;  // 初始状态
            S1: next_state = din ? S2 : S0;  // 检测到 1
            S2: next_state = din ? S2 : S3;  // 检测到 11
            S3: next_state = din ? S4 : S0;  // 检测到 110
            S4: next_state = din ? S2 : S0;  // 检测到 1101，重叠检测返回 S2
            default: next_state = S0;        // 默认返回初始状态
        endcase
    end

    // 输出逻辑：仅在状态 S4 输出 1
    always @(posedge clk or posedge reset) begin
        if (reset)
            dout <= 0;
        else
            dout <= (current_state == S4);
    end

endmodule
