# Makefile for Verilog simulation using Verilator, VSIM, and Iverilog

# Define VSIM variables
VSIM = vsim

# Define simulation variables
SIM_BINARY = sim_bin

# Compiler and simulator
IVERILOG = iverilog
VVP = vvp

# Directories and files for evaluation
SIM_SRC = src/packet_gen.sv src/router.sv src/router_Controler.sv src/router_DP.sv test/tb.sv

SIM_SRC_VERILATOR = $(SIM_SRC)

COMP_OPTS_SV := --incr --relax

TB_TOP = tb_router
MODULE = Multiplier_tb

GTKWAVE = tb.vcd

OUTPUT_FILE = out.vvp

# Default target
.PHONY: all
all: help

# Help target
.PHONY: help
help:
	@echo "Verilog Simulation Makefile"
	@echo "---------------------------"
	@echo "Targets:"
	@echo "  help          - Display this help message"
	@echo "  sim TOOL=vsim - Run simulation using VSIM"
	@echo "  sim TOOL=iverilog - Run simulation using IVerilog"
	@echo "  clean         - Remove generated files"

# Simulation target
.PHONY: sim
sim:
ifdef TOOL
ifeq ($(TOOL),vsim)
	@echo "Running VSIM simulation..."
	vlog $(SIM_SRC)
	$(VSIM) $(TB_TOP)


else ifeq ($(TOOL),iverilog)
	$(IVERILOG) -g2012 -o $(OUTPUT_FILE) $(SIM_SRC)
	$(VVP) $(OUTPUT_FILE)
	gtkwave $(GTKWAVE)

else
	@echo "Invalid TOOL specified. Please use  'vsim' or 'iverilog'."
endif
else
	@echo "Please specify the simulation tool using 'make sim TOOL=vsim' or 'make sim TOOL=iverilog'."
endif

# Clean target
.PHONY: clean
clean:
	@echo "Cleaning up..."
	rm -f $(OUTPUT_FILE) tb.vcd
