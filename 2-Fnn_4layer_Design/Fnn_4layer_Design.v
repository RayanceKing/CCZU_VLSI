module FNN(
    input wire clk,
    input wire reset,
    input wire [31:0] input_data,  // 4 inputs, each 8 bits
    output reg [31:0] output_data  // 4 outputs, each 8 bits
);

    // Number of neurons per layer
    parameter NEURONS = 4;

    // Define weights and biases for each layer (hardcoded as examples)
    reg [7:0] weights1[NEURONS-1:0][NEURONS-1:0];
    reg [7:0] biases1[NEURONS-1:0];

    reg [7:0] weights2[NEURONS-1:0][NEURONS-1:0];
    reg [7:0] biases2[NEURONS-1:0];

    reg [7:0] weights3[NEURONS-1:0][NEURONS-1:0];
    reg [7:0] biases3[NEURONS-1:0];

    reg [7:0] weights4[NEURONS-1:0][NEURONS-1:0];
    reg [7:0] biases4[NEURONS-1:0];

    // Intermediate signals
    reg [7:0] layer1_out[NEURONS-1:0];
    reg [7:0] layer2_out[NEURONS-1:0];
    reg [7:0] layer3_out[NEURONS-1:0];
    reg [7:0] layer4_out[NEURONS-1:0];

    integer i, j;

    // Initialize weights and biases
    initial begin
        // Layer 1 weights and biases
        weights1[0][0] = 8'h1; weights1[0][1] = 8'h2; weights1[0][2] = 8'h3; weights1[0][3] = 8'h4;
        biases1[0] = 8'h1;
        // Repeat initialization for other layers (weights2, biases2, etc.)
    end

    // Forward pass
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            output_data <= 0;
        end else begin
            // Layer 1: Input to Layer 1
            for (i = 0; i < NEURONS; i = i + 1) begin
                layer1_out[i] = biases1[i];
                for (j = 0; j < NEURONS; j = j + 1) begin
                    layer1_out[i] = layer1_out[i] + (weights1[i][j] * input_data[8*j +: 8]);
                end
                layer1_out[i] = layer1_out[i] > 8'd0 ? layer1_out[i] : 8'd0; // ReLU
            end

            // Layer 2: Layer 1 to Layer 2
            for (i = 0; i < NEURONS; i = i + 1) begin
                layer2_out[i] = biases2[i];
                for (j = 0; j < NEURONS; j = j + 1) begin
                    layer2_out[i] = layer2_out[i] + (weights2[i][j] * layer1_out[j]);
                end
                layer2_out[i] = layer2_out[i] > 8'd0 ? layer2_out[i] : 8'd0; // ReLU
            end

            // Layer 3: Layer 2 to Layer 3
            for (i = 0; i < NEURONS; i = i + 1) begin
                layer3_out[i] = biases3[i];
                for (j = 0; j < NEURONS; j = j + 1) begin
                    layer3_out[i] = layer3_out[i] + (weights3[i][j] * layer2_out[j]);
                end
                layer3_out[i] = layer3_out[i] > 8'd0 ? layer3_out[i] : 8'd0; // ReLU
            end

            // Layer 4: Layer 3 to Layer 4 (Output Layer)
            for (i = 0; i < NEURONS; i = i + 1) begin
                layer4_out[i] = biases4[i];
                for (j = 0; j < NEURONS; j = j + 1) begin
                    layer4_out[i] = layer4_out[i] + (weights4[i][j] * layer3_out[j]);
                end
                layer4_out[i] = layer4_out[i] > 8'd0 ? layer4_out[i] : 8'd0; // ReLU
            end

            // Pack the output data
            for (i = 0; i < NEURONS; i = i + 1) begin
                output_data[8*i +: 8] = layer4_out[i];
            end
        end
    end
endmodule
