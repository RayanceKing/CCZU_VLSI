以下是完整的 **Moore 型状态机** Verilog 实现，检测序列 `1101`（无重叠），以及包含测试平台的完整代码：

### 仿真步骤

1. 保存代码：
   - 将 `Moore 型状态机模块` 保存为 `moore_sequence_detector.v`。
   - 将 `测试平台` 保存为 `testbench.v`。

2. 编译代码（以 Icarus Verilog 为例）：
   ```bash
   iverilog -o moore_sequence_detector.vvp moore_sequence_detector.v testbench.v
   ```

3. 运行仿真生成 VCD 文件：
   ```bash
   vvp sequence_detector_moore_tb -lxt2
   ```

4. 查看波形文件：
   使用 `GTKWave` 或其他波形查看工具打开生成的 `moore_sequence_detector.vcd` 文件：
   ```bash
   gtkwave moore_sequence_detector.vcd
   ```

---

### 运行结果说明

1. **输入序列**：
   输入位流 `din = 1011101`，序列检测器将在两个位置检测到 `1101`：
   - 第一个 `1101` 出现在第 6 个时钟周期，`dout` 应为 1。
   - 第二个 `1101` 出现在第 10 个时钟周期，`dout` 应再次变为 1。

2. **波形文件**：
   打开 VCD 文件，可以清晰地观察 `din` 和 `dout` 随时钟信号的变化，验证状态机工作正确性。

---

### 特点

1. **无重叠检测**：状态从 `S4` 返回到 `S0` 或 `S1`，保证不会检测到重叠的 `1101`。
2. **模块化设计**：状态机设计清晰，适合扩展到其他序列。
3. **兼容性高**：不使用高级语法，支持传统 Verilog 仿真器。