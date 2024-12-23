# CCZU_VLSI
常州大学集成电路专业VLSI课程设计
# Mac安装iVerilog指南
## 🍺brew环境
默认您已经安装了brew环境。
### 安装Iverilog
```bash
brew install icarus-verilog
```
### 安装verilator
```bash
brew install verilator
```
### 安装gtkwave（波形图展示工具）
```bash
brew install --HEAD randomplum/gtkwave/gtkwave
```
## 安装yosys
### 从github上将yosys文件夹下载下来
```bash
git clone https://github.com/YosysHQ/yosys.git
```
### 在下载的yosys文件夹中打开终端，安装denpendencies
```bash
brew tap Homebrew/bundle && brew bundle
```
### build Yosys simply
```bash
make
sudo make install
```
### graphviz安装，从而可以打印png格式的电路结构图
```bash
brew install graphviz
```
## GTKWave报错解决
若遇到以下错误：
```
“Can't locate Switch.pm in @INC (you may need to install the Switch module) (@INC contains: /Library/Perl/5.30/darwin-thread-multi-2level /Library/Perl/5.30 /Network/Library/Perl/5.30/darwin-thread-multi-2level /Network/Library/Perl/5.30 /Library/Perl/Updates/5.30.3 /System/Library/Perl/5.30/darwin-thread-multi-2level /System/Library/Perl/5.30 /System/Library/Perl/Extras/5.30/darwin-thread-multi-2level /System/Library/Perl/Extras/5.30) at /opt/homebrew/bin/gtkwave line 2.BEGIN failed--compilation aborted at /opt/homebrew/bin/gtkwave line 2.”
```
运行以下命令解决：
```bash
sudo cpan install Switch
```
## ctags安装
```bash
brew install ctags
```
## 配置VScode
- 安装CTags Support插件()
- 安装Verilog Highlight插件(无需配置)
- 安装Verilog-HDL/SystemVerilog/Bluespec SystemVerilog
### 设置Ctags路径
设置为brew中的`/opt/homebrew/bin/ctags`
![Ctags设置](/pic/ctags.png)
### 设置Linter:编译器设置
![Linter设置](/pic/Linter.png)
- 编译指令：`iverilog -o wave led_test.v led_test_tb.v`
- vvp：`vvp -n wave`
- gtkwave打开生成的波形文件：`gtkwave ./test.vcd`
