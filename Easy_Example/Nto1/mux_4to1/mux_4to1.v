module mux_4to1 (
    input wire [3:0] D,  // 4 个输入信号
    input wire [1:0] Sel, // 2 位选择信号
    output reg Y         // 输出信号
);

    // 使用 case 语句实现多路复用器
    always @(*) begin
        case (Sel)
            2'b00: Y = D[0]; // 当 Sel 为 00 时，选择 D[0]
            2'b01: Y = D[1]; // 当 Sel 为 01 时，选择 D[1]
            2'b10: Y = D[2]; // 当 Sel 为 10 时，选择 D[2]
            2'b11: Y = D[3]; // 当 Sel 为 11 时，选择 D[3]
            default: Y = 1'b0; // 默认输出 0
        endcase
    end

endmodule
