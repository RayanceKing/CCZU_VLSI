module mealy_sequence_detector_overlap(
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

    reg [2:0] current_state, next_state; // 状态寄存器

    // 状态寄存器
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // 状态转移和输出逻辑
    always @(*) begin
        // 默认值
        next_state = S0;
        dout = 0;

        case (current_state)
            S0: begin
                next_state = din ? S1 : S0;
            end
            S1: begin
                next_state = din ? S2 : S0;
            end
            S2: begin
                next_state = din ? S2 : S3;
            end
            S3: begin
                if (din) begin
                    next_state = S1;  // 检测到 1101，返回 S1 以允许重叠
                    dout = 1;         // 检测到序列 1101，立即输出
                end else begin
                    next_state = S0;
                end
            end
            default: next_state = S0;
        endcase
    end

endmodule
