# Makefile
# Cocotb simulation Makefile for TinyTapeout

# defaults
SIM ?= icarus
FST ?= -fst
TOPLEVEL_LANG ?= verilog

# Source directory
SRC_DIR = $(PWD)/../src

# Main Verilog design file
PROJECT_SOURCES = tt_um_example.v

ifneq ($(GATES),yes)

# RTL simulation
SIM_BUILD = sim_build/rtl
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES))

else

# Gate-level simulation
SIM_BUILD = sim_build/gl

COMPILE_ARGS += -DGL_TEST
COMPILE_ARGS += -DFUNCTIONAL
COMPILE_ARGS += -DUSE_POWER_PINS
COMPILE_ARGS += -DSIM
COMPILE_ARGS += -DUNIT_DELAY=\#1

# SKY130 standard cell libraries
VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v
VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v

# Gate-level netlist
VERILOG_SOURCES += $(PWD)/gate_level_netlist.v

endif

# Include header files
COMPILE_ARGS += -I$(SRC_DIR)

# Testbench
VERILOG_SOURCES += $(PWD)/tb.v

# DUT top module
TOPLEVEL = tt_um_example

# Cocotb Python test file (test.py)
MODULE = test

# Include cocotb rules
include $(shell cocotb-config --makefiles)/Makefile.sim
