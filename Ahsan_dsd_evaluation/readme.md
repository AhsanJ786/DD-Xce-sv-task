# Verilog Simulation Project

## Overview

This project involves the design and simulation of a Network-on-Chip (NoC) router system using Verilog. The project includes several key modules, such as a Packet Generator, Router, and Router Data Path, which are all integrated and verified through simulation. The project uses a `Makefile` for managing the build process, supporting both VSIM and Icarus Verilog as simulation tools.

## Directory Structure

- **src/**
  - `packet_gen.sv`: Module for generating packets to be routed.
  - `router.sv`: Top-level router module.
  - `router_Controler.sv`: Control logic for the router.
  - `router_DP.sv`: Data Path module for the router.

- **test/**
  - `tb.sv`: Testbench for the router system.

- **doc/**
  - `stg.jpg`: State Transition Graph (STG) for the router's control logic.
  - `Connection.jpg`: Block diagram showing the interconnection between Packet Generator, Router Data Path, and Router Controller.


### Targets

- `help`: Display this help message.
- `sim TOOL=vsim`: Run simulation using VSIM.
- `sim TOOL=iverilog`: Run simulation using Icarus Verilog.
- `clean`: Remove generated files.

### Simulation Variables

- **VSIM**: Set to `vsim` for ModelSim simulations.
- **SIM_BINARY**: Binary for simulation, set to `sim_bin`.
- **IVERILOG**: Set to `iverilog` for Icarus Verilog simulations.
- **VVP**: Set to `vvp` for running Icarus Verilog simulations.
- **SIM_SRC**: List of Verilog source files to be simulated.
- **TB_TOP**: Top-level testbench module.
- **MODULE**: Top-level testbench module name.
- **GTKWAVE**: Set to `tb.vcd` for waveform viewing.

### Usage

To simulate using VSIM:
```bash
make sim TOOL=vsim
```

To simulate using Icarus Verilog:
```bash
make sim TOOL=iverilog
```

To clean up generated files:
```bash
make clean
```





