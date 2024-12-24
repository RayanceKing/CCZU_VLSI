module tb_mux_4to1_logic;

    reg [3:0] D;       // 测试输入 D
    reg [1:0] Sel;     // 测试选择信号 Sel
    wire Y;            // 测试输出 Y

    // 实例化多路复用器
    mux_4to1_logic uut (
        .D(D),
        .Sel(Sel),
        .Y(Y)
    );

    // 生成 VCD 文件
    initial begin
        $dumpfile("mux_4to1_logic.vcd"); // 指定 VCD 文件名
        $dumpvars(0, tb_mux_4to1_logic); // 指定记录变量的层次
    end

    // 测试向量
    initial begin
        $display(" D    Sel | Y"); // 打印标题

        D = 4'b0001; Sel = 2'b00; #10 $display("%b  %b  | %b", D, Sel, Y);
        D = 4'b0010; Sel = 2'b01; #10 $display("%b  %b  | %b", D, Sel, Y);
        D = 4'b0100; Sel = 2'b10; #10 $display("%b  %b  | %b", D, Sel, Y);
        D = 4'b1000; Sel = 2'b11; #10 $display("%b  %b  | %b", D, Sel, Y);

        D = 4'b1110; Sel = 2'b00; #10 $display("%b  %b  | %b", D, Sel, Y);
        D = 4'b1110; Sel = 2'b01; #10 $display("%b  %b  | %b", D, Sel, Y);
        D = 4'b1110; Sel = 2'b10; #10 $display("%b  %b  | %b", D, Sel, Y);
        D = 4'b1110; Sel = 2'b11; #10 $display("%b  %b  | %b", D, Sel, Y);

        $finish; // 结束仿真
    end

endmodule
