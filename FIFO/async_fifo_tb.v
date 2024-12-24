module tb_async_fifo;

    reg write_clk;      // 写时钟信号
    reg read_clk;       // 读时钟信号
    reg reset;          // 复位信号
    reg write_en;       // 写使能信号
    reg read_en;        // 读使能信号
    reg [7:0] data_in;  // 输入数据
    wire [7:0] data_out; // 输出数据
    wire fifo_full;      // FIFO 满标志
    wire fifo_empty;     // FIFO 空标志

    // 实例化异步 FIFO
    async_fifo uut (
        .write_clk(write_clk),
        .read_clk(read_clk),
        .reset(reset),
        .write_en(write_en),
        .read_en(read_en),
        .data_in(data_in),
        .data_out(data_out),
        .fifo_full(fifo_full),
        .fifo_empty(fifo_empty)
    );

    // 生成 VCD 文件
    initial begin
        $dumpfile("async_fifo.vcd");
        $dumpvars(0, tb_async_fifo);
    end

    // 写时钟生成
    initial begin
        write_clk = 0;
        forever #7 write_clk = ~write_clk;
    end

    // 读时钟生成
    initial begin
        read_clk = 0;
        forever #10 read_clk = ~read_clk;
    end

    // 测试向量
    initial begin
        // 初始化
        reset = 1; write_en = 0; read_en = 0; data_in = 8'b00000000; #15;
        reset = 0; #10;

        // 写入数据
        write_en = 1; data_in = 8'b11001010; #10;
        write_en = 0; #10;
        write_en = 1; data_in = 8'b10101010; #10;
        write_en = 0; #10;

        // 读取数据
        read_en = 1; #10;
        read_en = 0; #10;
        read_en = 1; #10;
        read_en = 0; #10;

        $finish;
    end

endmodule
