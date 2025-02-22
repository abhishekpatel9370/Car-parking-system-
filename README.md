Car Parking System

Overview

The Car Parking System is a Verilog-based implementation of an automated parking control system. It uses sensors to detect vehicle entry and exit, verifies passwords, and controls LED indicators and a 7-segment display to signal parking status.

Features

Detects vehicle entry and exit using sensors.

Verifies user password for authentication.

Controls LED indicators:

Green LED indicates successful authentication.

Red LED indicates incorrect authentication.

Displays messages on a 7-segment display:

"GO" when access is granted.

"EE" when an error occurs.

Implements a finite state machine (FSM) to manage parking logic.

State Machine

The system operates in the following states:

IDLE: Waiting for a vehicle entry or exit event.

WAIT_PASSWORD: Waiting for password input.

WRONG_PASSWORD: Denies access for incorrect password.

RIGHT_PASSWORD: Grants access for correct password.

STOP: Resets the system when the car exits.

Hardware Requirements

FPGA board (e.g., Xilinx Artix-7)

Sensors for entry and exit detection

7-segment display

LEDs for status indication

Module Interface

Inputs:

sensor1_entry, sensor2_entry: Detect vehicle entry.

sensor1_exit, sensor2_exit: Detect vehicle exit.

password1, password2: 16-bit passwords for authentication.

clk: System clock signal.

rst: Reset signal.

Outputs:

Greenled1, Greenled2: Indicate successful authentication.

Redled1, Redled2: Indicate denied access.

HEX_1, HEX_2, HEX_3, HEX_4: Display system status on a 7-segment display.

How It Works

When a vehicle approaches, an entry sensor is triggered.

The system prompts for a password.

If the password is correct, the green LED lights up and "GO" is displayed.

If the password is incorrect, the red LED lights up and "EE" is displayed.

When the vehicle exits, the system resets to the IDLE state.

Installation & Usage

Load the Verilog code into an FPGA development environment (e.g., Vivado).

Synthesize and implement the design.

Program the FPGA and connect the necessary hardware.

Test the system by simulating vehicle entry and exit with sensor inputs.

Future Improvements

Integrating an LCD for better user interface.

Implementing RFID-based authentication.

Adding a parking space availability counter.

License

This project is open-source under the MIT License.


Acknowledgments

Inspired by real-world automated parking systems.

Developed as a Verilog practice project.


