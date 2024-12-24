module mux_4to1_conditional (
    input wire [3:0] D,  // 4 个输入信号
    input wire [1:0] Sel, // 2 位选择信号
    output wire Y         // 输出信号
);

    // 使用条件运算符实现多路复用器
    assign Y = (Sel == 2'b00) ? D[0] :
               (Sel == 2'b01) ? D[1] :
               (Sel == 2'b10) ? D[2] :
               (Sel == 2'b11) ? D[3] : 1'b0;

endmodule
