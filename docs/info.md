<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

The Stochastic MAC (SCMAC) unit performs multiplication and accumulation using stochastic bit streams. Two input bits, ui[0] (input X) and ui[1] (weight W), are multiplied using a simple AND gate. The multiplication result is accumulated in an 8-bit counter on every rising edge of the clock. When both input bits are high, the accumulator increments by one. The accumulated value is continuously available on the output pins uo[7:0].

## How to test

Apply a clock signal to the clk input.
Assert reset (rst_n = 0) to clear the accumulator.
Release reset (rst_n = 1).
Apply stochastic bit streams to:
ui[0] : Input stream X
ui[1] : Weight stream W
Observe the accumulator value on uo[7:0].
When both inputs are logic '1', the accumulator increments on each clock cycle. When either input is logic '0', the accumulator retains its current value.

## External hardware

No external hardware is required. The design uses only the Tiny Tapeout input, output, clock, and reset signals. Testing can be performed entirely through simulation or the Tiny Tapeout demo board.
