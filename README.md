Car Parking System

Overview

The Car Parking System is a Verilog implementation of an automated parking control system. It detects vehicle entry and exit with sensors, checks passwords, and controls LED indicators and a 7-segment display to indicate parking status.

Features

Detects vehicle entry and exit via sensors.

Verifies user password for authentication.

Controls LED indicators:

Green LED shows successful authentication.

Red LED shows incorrect authentication.

Displays messages on a 7-segment display:

"GO" when access is given.

"EE" when an error is detected.

Uses a finite state machine (FSM) to handle parking logic.

State Machine

System runs in the following states:

IDLE: Awaiting vehicle entry or exit event.

WAIT_PASSWORD: Awaiting password entry.

WRONG_PASSWORD: Refuses access for wrong password.

RIGHT_PASSWORD: Allows access for right password.

STOP: Resets the system when car exits.

Hardware Requirements

FPGA board (e.g., Xilinx Artix-7)

Entry and exit detection sensors

7-segment display

Status indication LEDs

Module Interface

Inputs:

sensor1_entry, sensor2_entry: Identify vehicle entry.

sensor1_exit, sensor2_exit: Register vehicle exit.

password1, password2: 16-bit passwords.

clk: System clock signal.

rst: Reset signal.

Outputs:

Greenled1, Greenled2: Illuminate when authentication succeeds.

Redled1, Redled2: Illuminate when access is denied.

HEX_1, HEX_2, HEX_3, HEX_4: Present system status using a 7-segment display.

How It Works

On vehicle approach, an entry sensor is activated.

The system asks for a password.

When a correct password is entered, the green LED flashes and "GO" is lit.

If the password is wrong, the red LED glows and "EE" is shown.

When the vehicle departs, the system returns to the IDLE state.

Installation & Usage

Load the Verilog code into an FPGA development tool (e.g., Vivado).

Synthesize and map the design.

Program the FPGA and set up the required hardware.

Test the system by simulating vehicle entry and exit with sensor inputs.

Future Improvements

Adding an LCD for improved user interface.

Using RFID-based authentication.

Adding a parking space availability counter.

License

This project is open-source under the MIT License
