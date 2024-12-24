仿真工具和步骤
使用 Icarus Verilog 仿真： 编译代码：

bash
复制代码
iverilog -o tb_sequence_detector_mealy_overlap tb_sequence_detector_mealy_overlap.v
运行仿真：

bash
复制代码
vvp tb_sequence_detector_mealy_overlap
生成 sequence_detector_mealy_overlap.vcd 文件。

查看波形： 使用 GTKWave 打开生成的 VCD 文件：

bash
复制代码
gtkwave sequence_detector_mealy_overlap.vcd
预期结果
仿真输出（$display）示例：

csharp
复制代码
in | out
0  | 0
1  | 0
1  | 0
0  | 0
1  | 1
1  | 0
0  | 0
1  | 0
1  | 0
0  | 0
波形文件将显示 in 和 out 随时间的变化，验证 Mealy 型状态机的行为是否符合预期，特别是在输入序列重叠时能否正确检测到新的 1101 序列并输出 1。