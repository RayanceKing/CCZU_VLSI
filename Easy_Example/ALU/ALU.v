module ALU (
    input wire [3:0] A,        // 4 位输入 A
    input wire [3:0] B,        // 4 位输入 B
    input wire [2:0] Opcode,   // 3 位操作码，用于选择操作
    output reg [3:0] Result,   // 4 位结果输出
    output reg CarryOut        // 进位输出，用于加法和减法
);

    always @(*) begin
        case (Opcode)
            3'b000: {CarryOut, Result} = A + B;       // 加法
            3'b001: {CarryOut, Result} = A - B;       // 减法
            3'b010: Result = A & B;                   // 按位与
            3'b011: Result = A | B;                   // 按位或
            3'b100: Result = A ^ B;                   // 按位异或
            3'b101: Result = ~A;                      // 按位取反
            3'b110: Result = A << 1;                  // 左移
            3'b111: Result = A >> 1;                  // 右移
            default: {CarryOut, Result} = {1'b0, 4'b0000}; // 默认值
        endcase
    end

endmodule
