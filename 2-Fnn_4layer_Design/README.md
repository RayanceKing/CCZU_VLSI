### 设计一个基于 Verilog 的 4 层全连接神经网络（FNN）硬件实现

全连接神经网络（Fully Connected Neural Network, FNN）是机器学习中的一种基本网络结构。它通过多层神经元对输入数据进行处理并输出预测结果。在本设计中，我们将用 Verilog 硬件描述语言实现一个 4 层 FNN，假设每层神经元的数量固定，并硬编码权重和偏置。

---

### 设计目标

1. **输入层**：接受输入数据并将其传递到第一隐藏层。
2. **隐藏层**：包括多个神经元，每个神经元计算前一层输出的加权和，并通过 ReLU 激活函数处理。
3. **输出层**：生成最终的预测结果。
4. **硬件约束**：
   - 每层固定 4 个神经元。
   - 数据宽度为 8 位（输入、权重和偏置）。
   - 使用硬编码的权重和偏置。

---

### 网络结构

1. **网络配置**：
   - 每层包含 4 个神经元。
   - 4 层全连接，包括 1 个输入层，2 个隐藏层，和 1 个输出层。

2. **激活函数**：
   - 使用 ReLU（Rectified Linear Unit），公式为：
     
     \[ f(x) = \max(0, x) \]

3. **权重和偏置**：
   - 硬编码为常量，方便在 FPGA 或 ASIC 上实现。

---

### 硬件实现框架

#### 1. **顶层模块 (`FNN`)**

```verilog
module FNN (
    input clk,
    input reset,
    input [31:0] input_data,
    output [31:0] output_data
);
    // Internal wires for layer outputs
    wire [31:0] layer1_out;
    wire [31:0] layer2_out;
    wire [31:0] layer3_out;

    // Layer 1
    fully_connected_layer layer1 (
        .clk(clk),
        .reset(reset),
        .input_data(input_data),
        .weights({8'd1, 8'd2, 8'd3, 8'd4}),
        .biases({8'd1, 8'd1, 8'd1, 8'd1}),
        .output_data(layer1_out)
    );

    // Layer 2
    fully_connected_layer layer2 (
        .clk(clk),
        .reset(reset),
        .input_data(layer1_out),
        .weights({8'd1, 8'd2, 8'd3, 8'd4}),
        .biases({8'd1, 8'd1, 8'd1, 8'd1}),
        .output_data(layer2_out)
    );

    // Layer 3
    fully_connected_layer layer3 (
        .clk(clk),
        .reset(reset),
        .input_data(layer2_out),
        .weights({8'd1, 8'd2, 8'd3, 8'd4}),
        .biases({8'd1, 8'd1, 8'd1, 8'd1}),
        .output_data(layer3_out)
    );

    // Layer 4 (Output layer)
    fully_connected_layer layer4 (
        .clk(clk),
        .reset(reset),
        .input_data(layer3_out),
        .weights({8'd1, 8'd2, 8'd3, 8'd4}),
        .biases({8'd1, 8'd1, 8'd1, 8'd1}),
        .output_data(output_data)
    );

endmodule
```

#### 2. **全连接层模块 (`fully_connected_layer`)**

```verilog
module fully_connected_layer (
    input clk,
    input reset,
    input [31:0] input_data,
    input [31:0] weights,
    input [31:0] biases,
    output [31:0] output_data
);
    reg [31:0] weighted_sum;
    reg [31:0] relu_output;

    // Weighted sum computation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            weighted_sum <= 0;
        end else begin
            weighted_sum[7:0]   <= (input_data[7:0]   * weights[7:0])   + biases[7:0];
            weighted_sum[15:8]  <= (input_data[15:8]  * weights[15:8])  + biases[15:8];
            weighted_sum[23:16] <= (input_data[23:16] * weights[23:16]) + biases[23:16];
            weighted_sum[31:24] <= (input_data[31:24] * weights[31:24]) + biases[31:24];
        end
    end

    // ReLU activation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            relu_output <= 0;
        end else begin
            relu_output[7:0]   <= (weighted_sum[7:0]   > 0) ? weighted_sum[7:0]   : 0;
            relu_output[15:8]  <= (weighted_sum[15:8]  > 0) ? weighted_sum[15:8]  : 0;
            relu_output[23:16] <= (weighted_sum[23:16] > 0) ? weighted_sum[23:16] : 0;
            relu_output[31:24] <= (weighted_sum[31:24] > 0) ? weighted_sum[31:24] : 0;
        end
    end

    assign output_data = relu_output;

endmodule
```

---

### 测试平台（Testbench）

```verilog
module FNN_tb;
    reg clk;
    reg reset;
    reg [31:0] input_data;
    wire [31:0] output_data;

    // Instantiate the FNN module
    FNN uut (
        .clk(clk),
        .reset(reset),
        .input_data(input_data),
        .output_data(output_data)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test stimulus
    initial begin
        reset = 1;
        input_data = 32'h00000000;
        #10 reset = 0;

        input_data = 32'h01020304; // Example input
        #100;

        input_data = 32'h05060708; // Another example input
        #100;

        $finish;
    end

    // Waveform generation
    initial begin
        $dumpfile("fnn_waveform.vcd");
        $dumpvars(0, FNN_tb);
    end

endmodule
```

---

### 仿真与波形查看

1. **编译与仿真**：
   - 使用 Icarus Verilog：
     ```bash
     iverilog -o fnn_sim FNN.v fully_connected_layer.v FNN_tb.v
     vvp fnn_sim
     ```

2. **查看波形**：
   - 使用 GTKWave：
     ```bash
     gtkwave fnn_waveform.vcd
     ```

3. **验证结果**：
   - 在波形中观察每层的输入、加权求和、ReLU 输出以及最终的输出层结果。

---

### 总结

以上设计展示了一个简单的 4 层全连接神经网络硬件实现框架，适合在 FPGA 或其他硬件平台上实现。
- **扩展性**：可以增加层数或调整每层神经元数量。
- **优化**：支持动态加载权重和偏置，实现更多实际应用。
- **未来改进**：引入训练过程，通过硬件支持在线学习能力。

