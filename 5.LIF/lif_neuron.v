module lif_neuron #(
    parameter V_rest = 0,      // 静息电位
    parameter V_th = 10,       // 阈值电位
    parameter Tau_m = 10       // 膜时间常数
) (
    input wire clk,
    input wire reset,
    input wire [15:0] I_in,    // 输入电流 (16 位)
    output reg spike,          // 脉冲输出
    output reg [15:0] V_out    // 膜电位输出
);

    reg [15:0] V_mem;          // 膜电位寄存器

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            V_mem <= V_rest;   // 复位时重置膜电位
            spike <= 0;
        end else begin
            // 更新膜电位
            V_mem <= V_mem + ((I_in - V_mem) / Tau_m);

            // 触发脉冲并重置膜电位
            if (V_mem >= V_th) begin
                spike <= 1;
                V_mem <= V_rest;
            end else begin
                spike <= 0;
            end
        end
    end

    always @(posedge clk) begin
        V_out <= V_mem;  // 同步更新膜电位输出
    end

endmodule
