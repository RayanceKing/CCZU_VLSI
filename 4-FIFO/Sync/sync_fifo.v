module sync_fifo #(
    parameter DATA_WIDTH = 8,  // 数据宽度
    parameter FIFO_DEPTH = 16  // FIFO深度
) (
    input wire clk,             // 时钟信号
    input wire reset,           // 复位信号
    input wire write_enable,    // 写使能信号
    input wire read_enable,     // 读使能信号
    input wire [DATA_WIDTH-1:0] write_data,  // 写入的数据
    output reg [DATA_WIDTH-1:0] read_data,   // 读取的数据
    output reg fifo_empty,      // FIFO为空标志
    output reg fifo_full        // FIFO满标志
);

    // FIFO的存储阵列
    reg [DATA_WIDTH-1:0] fifo_mem [0:FIFO_DEPTH-1];
    
    // 写指针和读指针
    reg [4:0] write_ptr, read_ptr;
    
    // FIFO计数器
    reg [4:0] fifo_count;

    // 写操作
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            write_ptr <= 0;
            fifo_count <= 0;
            fifo_full <= 0;
        end else if (write_enable && !fifo_full) begin
            fifo_mem[write_ptr] <= write_data;  // 写数据到FIFO
            write_ptr <= write_ptr + 1;         // 写指针递增
            fifo_count <= fifo_count + 1;       // FIFO计数器递增
            fifo_empty <= 0;                    // FIFO非空
        end
    end

    // 读操作
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            read_ptr <= 0;
            fifo_empty <= 1;
        end else if (read_enable && !fifo_empty) begin
            read_data <= fifo_mem[read_ptr];  // 读取数据
            read_ptr <= read_ptr + 1;         // 读指针递增
            fifo_count <= fifo_count - 1;     // FIFO计数器递减
            fifo_full <= 0;                   // FIFO非满
        end
    end

    // 更新FIFO状态标志
    always @(fifo_count) begin
        if (fifo_count == FIFO_DEPTH) begin
            fifo_full <= 1;
        end else if (fifo_count == 0) begin
            fifo_empty <= 1;
        end
    end

endmodule
