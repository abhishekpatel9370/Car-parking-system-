`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2025 10:53:45 PM
// Design Name: 
// Module Name: carparking_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module carparking_tb;

    // Inputs
    reg sensor1_entry;
    reg sensor1_exit;
    reg sensor2_entry;
    reg sensor2_exit;
    reg clk;
    reg rst;
    reg [15:0] password1;
    reg [15:0] password2;

    // Outputs
    wire Greenled1;
    wire Redled1;
    wire Greenled2;
    wire Redled2;
    wire [6:0] HEX_1;
    wire [6:0] HEX_2;
    wire [6:0] HEX_3;
    wire [6:0] HEX_4;

    // Instantiate the carparking module
    car_parking uut (
        .sensor1_entry(sensor1_entry),
        .sensor1_exit(sensor1_exit),
        .sensor2_entry(sensor2_entry),
        .sensor2_exit(sensor2_exit),
        .clk(clk),
        .rst(rst),
        .password1(password1),
        .password2(password2),
        .Greenled1(Greenled1),
        .Redled1(Redled1),
        .Greenled2(Greenled2),
        .Redled2(Redled2),
        .HEX_1(HEX_1),
        .HEX_2(HEX_2),
        .HEX_3(HEX_3),
        .HEX_4(HEX_4)
    );

    // Clock generation
    always #5 clk = ~clk;  // 100 MHz clock (10 ns period)

    // Test sequence
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        sensor1_entry = 1;
        sensor1_exit = 0;
        sensor2_entry = 0;
        sensor2_exit = 0;
        password1 = 16'h1234;
        password2 = 16'h0000;

        // Apply reset for 2 clock cycles
        #20;
        rst = 0;

        // Test case 1: Correct password, vehicle at sensor 1
        @(posedge clk);
        sensor1_entry = 1;
        sensor1_exit = 0;
        password1 = 16'h1234;
        #50; // Wait and observe

        // Test case 2: Incorrect password, vehicle at sensor 1
        @(posedge clk);
        password1 = 16'h1111; // Wrong password
        #50;

        // Test case 3: Correct password, vehicle at sensor 2
        @(posedge clk);
        sensor1_entry = 0;
        sensor2_entry = 1;
        password2 = 16'h1234;
        #50;

        // Test case 4: Vehicle exits from sensor 1
        @(posedge clk)
        sensor2_entry = 0;
        sensor1_exit = 1;
        password1 = 16'h1234;
        #50;

        // Test case 5: Both sensors active simultaneously
        @(posedge clk);
        sensor1_entry = 1;
        sensor2_exit = 1;
        password1 = 16'h1234;
        password2 = 16'h1234;
        #50;

        // End simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %t | sensor1_entry: %b | sensor1_exit: %b | sensor2_entry: %b | sensor2_exit: %b | password1: %h | password2: %h | Greenled1: %b | Greenled2: %b | HEX_1: %b | HEX_2: %b | HEX_3: %b | HEX_4: %b",
                $time, sensor1_entry, sensor1_exit, sensor2_entry, sensor2_exit, password1, password2, Greenled1, Greenled2, HEX_1, HEX_2, HEX_3, HEX_4);
    end
endmodule

