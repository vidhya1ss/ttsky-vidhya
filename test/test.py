# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):

    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    await ClockCycles(dut.clk, 5)

    dut.rst_n.value = 1

    # X=1, W=1
    dut.ui_in.value = 0b00000011

    await ClockCycles(dut.clk, 5)

    acc_value = int(dut.uo_out.value)

    dut._log.info(f"Accumulator = {acc_value}")

    assert acc_value >= 4, "Accumulator did not increment"

    # X=0, W=0
    dut.ui_in.value = 0

    old_acc = int(dut.uo_out.value)

    await ClockCycles(dut.clk, 5)

    assert int(dut.uo_out.value) == old_acc, \
        "Accumulator changed when inputs were zero"
