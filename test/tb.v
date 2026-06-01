`default_nettype none
`timescale 1ns / 1ps

module tb ();

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
  end

  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;

  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

  tt_um_example dut (
      .ui_in(ui_in),
      .uo_out(uo_out),
      .uio_in(uio_in),
      .uio_out(uio_out),
      .uio_oe(uio_oe),
      .ena(ena),
      .clk(clk),
      .rst_n(rst_n)
  );

  // Clock generation
  initial begin
      clk = 0;
      forever #5 clk = ~clk;
  end

  // Test stimulus
  initial begin
      ena    = 1'b1;
      rst_n  = 1'b0;
      ui_in  = 8'b0;
      uio_in = 8'b0;

      #20;
      rst_n = 1'b1;

      // X=1, W=1
      ui_in[0] = 1'b1;
      ui_in[1] = 1'b1;

      #100;

      // X=1, W=0
      ui_in[1] = 1'b0;

      #50;

      $finish;
  end

  initial begin
      $monitor("t=%0t X=%b W=%b ACC=%d",
                $time,
                ui_in[0],
                ui_in[1],
                uo_out);
  end

endmodule

`default_nettype wire
