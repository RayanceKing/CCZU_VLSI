以下是一个 **Mealy 型状态机** 实现，用于检测序列 `1101`，支持**重叠检测**，即检测到序列后可以立即继续从部分匹配的状态开始，并包含生成 VCD 文件的测试平台。

---

### Mealy 型状态机模块（重叠检测）

---

### 测试平台（Testbench）

---

### 仿真步骤

1. **保存代码**：
   - 将状态机代码保存为 `mealy_sequence_detector_overlap.v`。
   - 将测试平台代码保存为 `testbench.v`。

2. **编译代码**（以 Icarus Verilog 为例）：
   ```bash
   iverilog -o mealy_sequence_detector_overlap mealy_sequence_detector_overlap.v mealy_sequence_detector_overlap_tb.v
   ```

3. **运行仿真**：
   ```bash
   vvp -n mealy_sequence_detector_overlap -lxt2
   ```

4. **查看波形**：
   使用 `GTKWave` 打开生成的 `mealy_sequence_detector_overlap.vcd` 文件：
   ```bash
   gtkwave mealy_sequence_detector_overlap.vcd
   ```

---

### 运行结果说明

1. **输入序列**：
   输入序列为 `din = 1101101`。
2. **输出信号**：
   - 在检测到第一个 `1101` 时，`dout = 1`。
   - 重叠检测到第二个 `1101` 时，`dout = 1` 再次变高。

---

### 特点

1. **重叠检测**：
   - 状态机在检测到 `1101` 后返回到部分匹配的状态 `S1`，支持连续检测。

2. **Mealy 型**：
   - 输出 `dout` 在状态转移时立即改变，响应速度快。

3. **模块化设计**：
   - 清晰的状态和输出逻辑，便于扩展和修改为检测其他序列。

通过这些步骤，您可以成功仿真和验证 Mealy 型状态机的重叠序列检测功能！