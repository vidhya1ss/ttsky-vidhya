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

    // ui_in[0] = stochastic input X
    // ui_in[1] = stochastic weight W

    wire mult;
    reg [7:0] acc;

    assign mult = ui_in[0] & ui_in[1];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            acc <= 8'd0;
        else if (mult)
            acc <= acc + 8'd1;
        else
            acc <= acc;
    end

    assign uo_out = acc;

    // Unused bidirectional pins
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // Prevent warnings
    wire _unused = &{ena, uio_in, ui_in[7:2], 1'b0};

endmodule

`default_nettype wire
