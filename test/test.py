import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_project(dut):

    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    await ClockCycles(dut.clk, 5)

    dut.rst_n.value = 1

    # X=1, W=1
    dut.ui_in.value = 0b00000011

    await ClockCycles(dut.clk, 5)

    assert int(dut.uo_out.value) >= 4

    # X=0, W=0
    dut.ui_in.value = 0

    old_acc = int(dut.uo_out.value)

    await ClockCycles(dut.clk, 5)

    assert int(dut.uo_out.value) == old_acc
