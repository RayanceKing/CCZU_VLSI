// 64-bit Pipelined Multiplier
module pipelined_multiplier (
    input clk,
    input rst,
    input [63:0] a,
    input [63:0] b,
    output reg [127:0] result
);

    reg [63:0] a_reg [0:3];
    reg [63:0] b_reg [0:3];
    reg [127:0] partial_products [0:3];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            a_reg[0] <= 64'd0;
            b_reg[0] <= 64'd0;
            partial_products[0] <= 128'd0;
            partial_products[1] <= 128'd0;
            partial_products[2] <= 128'd0;
            partial_products[3] <= 128'd0;
            result <= 128'd0;
        end else begin
            // Stage 1
            a_reg[0] <= a;
            b_reg[0] <= b;
            partial_products[0] <= a[31:0] * b[31:0];

            // Stage 2
            a_reg[1] <= a_reg[0];
            b_reg[1] <= b_reg[0];
            partial_products[1] <= a_reg[0][63:32] * b_reg[0][31:0] + partial_products[0];

            // Stage 3
            a_reg[2] <= a_reg[1];
            b_reg[2] <= b_reg[1];
            partial_products[2] <= a_reg[1][31:0] * b_reg[1][63:32] + partial_products[1];

            // Stage 4
            a_reg[3] <= a_reg[2];
            b_reg[3] <= b_reg[2];
            partial_products[3] <= a_reg[2][63:32] * b_reg[2][63:32] + partial_products[2];

            // Final result
            result <= partial_products[3];
        end
    end

endmodule