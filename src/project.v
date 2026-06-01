/*
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    wire x;
    wire w;
    wire mult;

    reg [7:0] acc;

    assign x = ui_in[0];
    assign w = ui_in[1];

    // Stochastic multiplication
    assign mult = x & w;

    // Accumulator
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            acc <= 8'd0;
        else if (mult)
            acc <= acc + 8'd1;
    end

    // Output accumulator
    assign uo_out = acc;

    // Unused IOs
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    wire _unused = &{ena, uio_in, ui_in[7:2], 1'b0};

endmodule
