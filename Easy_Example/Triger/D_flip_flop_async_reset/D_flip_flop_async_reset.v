module D_flip_flop_async_reset (
    input wire D,          // 输入 D
    input wire clk,        // 时钟信号
    input wire reset,      // 异步复位信号
    output reg Q           // 输出 Q
);

    // 异步复位功能
    always @(posedge clk or posedge reset) begin
        if (reset)          // 如果异步复位信号有效
            Q <= 1'b0;      // 输出置为0
        else
            Q <= D;        // 否则，输出赋值为 D
    end

endmodule
