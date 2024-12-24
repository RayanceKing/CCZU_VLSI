module mux_4to1_logic (
    input wire [3:0] D,  // 4 个输入信号
    input wire [1:0] Sel, // 2 位选择信号
    output wire Y         // 输出信号
);

    // 使用逻辑表达式实现多路复用器
    assign Y = (~Sel[1] & ~Sel[0] & D[0]) |  // 选择 D[0]
               (~Sel[1] &  Sel[0] & D[1]) |  // 选择 D[1]
               ( Sel[1] & ~Sel[0] & D[2]) |  // 选择 D[2]
               ( Sel[1] &  Sel[0] & D[3]);   // 选择 D[3]

endmodule
