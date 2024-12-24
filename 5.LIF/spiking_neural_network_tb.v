module testbench;

    reg clk;
    reg reset;
    reg [3:0] inputs;          // 假设输入层有 4 个神经元
    wire [1:0] outputs;        // 假设输出层有 2 个神经元

    spiking_neural_network #(
        .NUM_INPUTS(4),
        .NUM_HIDDEN(3),
        .NUM_OUTPUTS(2),
        .V_rest(0),
        .V_th(10),
        .Tau_m(10)
    ) uut (
        .clk(clk),
        .reset(reset),
        .inputs(inputs),
        .outputs(outputs)
    );

    // 生成时钟信号
    always #5 clk = ~clk;

    initial begin
        $dumpfile("spiking_neural_network.vcd");
        $dumpvars(0, testbench);

        // 初始化信号
        clk = 0;
        reset = 1;
        inputs = 4'b1010;

        #10 reset = 0;          // 释放复位
        #100 inputs = 4'b1100; // 改变输入信号
        #100 inputs = 4'b0011; // 改变输入信号
        #200 $finish;          // 结束仿真
    end

endmodule
