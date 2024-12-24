module sequence_detector_moore_overlap (
    input wire clk,        // 时钟信号
    input wire reset,      // 异步复位信号
    input wire in,         // 输入序列
    output reg out         // 输出，序列检测结果
);

    // 定义状态
    typedef enum reg [1:0] {
        S0 = 2'b00, // 初始状态
        S1 = 2'b01, // 接收到第一个1
        S2 = 2'b10, // 接收到11
        S3 = 2'b11  // 接收到110
    } state_t;

    state_t state, next_state;

    // 状态机状态转换
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;    // 复位时回到初始状态
        else
            state <= next_state;  // 否则，进入下一个状态
    end

    // 状态转移逻辑
    always @(*) begin
        case (state)
            S0: begin
                next_state = (in) ? S1 : S0; // 如果输入是1，进入S1，否则保持S0
            end
            S1: begin
                next_state = (in) ? S2 : S0; // 如果输入是1，进入S2，否则回到S0
            end
            S2: begin
                next_state = (in) ? S1 : S3; // 如果输入是1，回到S1，否则进入S3
            end
            S3: begin
                next_state = (in) ? S2 : S0; // 如果输入是1，进入S2，否则回到S0
            end
            default: begin
                next_state = S0;
            end
        endcase
    end

    // 输出逻辑（Moore 型状态机）
    always @(state) begin
        case (state)
            S0: out = 0; // 初始状态，输出为0
            S1: out = 0; // 接收到第一个1，输出为0
            S2: out = 0; // 接收到11，输出为0
            S3: out = 1; // 接收到110，输出为1
            default: out = 0;
        endcase
    end

endmodule
