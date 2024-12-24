// Testbench for 64-bit Pipelined Multiplier
module tb_pipelined_multiplier;

    reg clk;
    reg rst;
    reg [63:0] a;
    reg [63:0] b;
    wire [127:0] result;

    pipelined_multiplier uut (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .result(result)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        rst = 1;
        a = 0;
        b = 0;
        #10;
        rst = 0;

        // Test case 1
        a = 64'd15;
        b = 64'd10;
        #40;

        // Test case 2
        a = 64'd123456789;
        b = 64'd987654321;
        #40;

        // Test case 3
        a = 64'd0;
        b = 64'd9999;
        #40;

        // Test case 4
        a = 64'd18446744073709551615; // 2^64 - 1
        b = 64'd1;
        #40;

        $stop;
    end

    // Waveform generation
    initial begin
        $dumpfile("wave.vcd"); // 波形文件名
        $dumpvars(0, tb_pipelined_multiplier); // 保存的信号范围
    end

endmodule
