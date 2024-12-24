module spiking_neural_network #(
    parameter NUM_INPUTS = 4,
    parameter NUM_HIDDEN = 3,
    parameter NUM_OUTPUTS = 2,
    parameter V_rest = 0,
    parameter V_th = 10,
    parameter Tau_m = 10
) (
    input wire clk,
    input wire reset,
    input wire [NUM_INPUTS-1:0] inputs,
    output wire [NUM_OUTPUTS-1:0] outputs
);

    wire [NUM_HIDDEN-1:0] hidden_spikes;
    wire [NUM_OUTPUTS-1:0] output_spikes;

    // 输入层 -> 隐藏层
    genvar i;
    generate
        for (i = 0; i < NUM_HIDDEN; i = i + 1) begin : input_to_hidden
            lif_neuron #(
                .V_rest(V_rest),
                .V_th(V_th),
                .Tau_m(Tau_m)
            ) hidden_neuron (
                .clk(clk),
                .reset(reset),
                .I_in(inputs[i % NUM_INPUTS]),
                .spike(hidden_spikes[i]),
                .V_out()
            );
        end
    endgenerate

    // 隐藏层 -> 输出层
    generate
        for (i = 0; i < NUM_OUTPUTS; i = i + 1) begin : hidden_to_output
            lif_neuron #(
                .V_rest(V_rest),
                .V_th(V_th),
                .Tau_m(Tau_m)
            ) output_neuron (
                .clk(clk),
                .reset(reset),
                .I_in(hidden_spikes[i % NUM_HIDDEN]),
                .spike(output_spikes[i]),
                .V_out()
            );
        end
    endgenerate

    assign outputs = output_spikes;

endmodule
