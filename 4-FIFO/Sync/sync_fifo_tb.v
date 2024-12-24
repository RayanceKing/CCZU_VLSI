module tb_sync_fifo;

    reg clk;               // 时钟信号
    reg reset;             // 复位信号
    reg write_en;          // 写使能信号
    reg read_en;           // 读使能信号
    reg [7:0] data_in;     // 输入数据
    wire [7:0] data_out;   // 输出数据
    wire fifo_full;        // FIFO 满标志
    wire fifo_empty;       // FIFO 空标志

    // 实例化同步 FIFO
    sync_fifo uut (
        .clk(clk),               // 时钟信号连接
        .reset(reset),           // 复位信号连接
        .write_enable(write_en),     // 写使能信号连接
        .read_enable(read_en),       // 读使能信号连接
        .write_data(data_in),       // 输入数据连接
        .read_data(data_out),     // 输出数据连接
        .fifo_full(fifo_full),   // FIFO 满标志连接
        .fifo_empty(fifo_empty)  // FIFO 空标志连接
    );

    // 生成 VCD 文件
    initial begin
        $dumpfile("sync_fifo.vcd");
        $dumpvars(0, tb_sync_fifo);
    end

    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // 测试向量
    initial begin
        // 初始化
        reset = 1; write_en = 0; read_en = 0; data_in = 8'b00000000; #10;
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
