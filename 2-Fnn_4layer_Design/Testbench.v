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
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Test stimulus
    initial begin
        // Initialize signals
        reset = 1;
        input_data = 32'h0;
        #10;

        reset = 0;
        input_data = 32'h01020304; // Example input
        #100;

        input_data = 32'h05060708; // Another example input
        #100;

        $finish; // End simulation
    end

    // Waveform generation
    initial begin
        $dumpfile("fnn_waveform.vcd"); // VCD file to store waveforms
        $dumpvars(0, FNN_tb);          // Dump all variables in the testbench
    end
endmodule
