# 4-bit ALU Design in Verilog

## Project Overview

This project implements a 4-bit Arithmetic Logic Unit (ALU) using Verilog. The ALU performs basic arithmetic and logic operations and is verified using a Verilog testbench and waveform simulation.

This project was created as a beginner VLSI/RTL design project to understand how hardware can be described, simulated, and verified using HDL code.

## Features

The ALU supports the following operations:

| Select Signal | Operation |
|---|---|
| 000 | Addition |
| 001 | Subtraction |
| 010 | AND |
| 011 | OR |
| 100 | XOR |
| 101 | NOT A |
| 110 | Shift Left |
| 111 | Shift Right |

## Inputs

- `A[3:0]`: 4-bit input A
- `B[3:0]`: 4-bit input B
- `sel[2:0]`: operation select signal

## Outputs

- `Y[3:0]`: 4-bit ALU output
- `carry_out`: carry output for arithmetic operations
- `zero`: zero flag, set to 1 when output Y is 0

## Tools Used

- Verilog
- Icarus Verilog
- GTKWave
- VS Code
- macOS Terminal

## File Structure

```text
vlsi-4bit-alu/
├── README.md
├── src/
│   └── alu_4bit.v
├── tb/
│   └── alu_4bit_tb.v
├── waveforms/
│   └── alu_4bit.vcd
└── docs/
    └── alu_waveform_results.png

    How to Run

Compile the design and testbench:

iverilog -o alu_sim src/alu_4bit.v tb/alu_4bit_tb.v

Run the simulation:

vvp alu_sim

Open the waveform:

gtkwave waveforms/alu_4bit.vcd
Simulation Results

For the main test case:

A = 5
B = 3

The ALU produced the following outputs:

Select	Operation	Expected Result
000	ADD	8
001	SUB	2
010	AND	1
011	OR	7
100	XOR	6
101	NOT A	10
110	Shift Left	10
111	Shift Right	2

The waveform output confirms that the ALU correctly changes output based on the selected operation.

Waveform Screenshot

What I Learned

Through this project, I learned:

Basics of RTL design
How Verilog describes hardware circuits
Difference between design files and testbenches
How to compile and simulate Verilog using Icarus Verilog
How to view digital waveforms using GTKWave
How an ALU performs arithmetic and logic operations inside a processor