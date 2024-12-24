module D_flip_flop (
    input wire D,          // 输入 D
    input wire clk,        // 时钟信号
    input wire reset,      // 同步复位信号
    output reg Q           // 输出 Q
);

    // 在时钟上升沿触发时
    always @(posedge clk) begin
        if (reset)          // 如果复位信号有效
            Q <= 1'b0;      // 输出置为0
        else
            Q <= D;        // 否则，输出赋值为 D
    end

endmodule
