`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2025 10:09:50 PM
// Design Name: 
// Module Name: carparkingsystemtb
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

    // Instantiate the Unit Under Test (UUT)
    carparking uut (
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

    // Clock Generation
    always begin
        #5 clk = ~clk; // 100 MHz clock
    end

    // Initial block for stimulus
    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        sensor1_entry = 0;
        sensor1_exit = 0;
        sensor2_entry = 0;
        sensor2_exit = 0;
        password1 = 16'h0000;
        password2 = 16'h0000;

        // Reset the system
        rst = 1;
        #10;
        rst = 0;
        #10;

        // Test case 1: Sensor 1 entry with wrong password
        sensor1_entry = 1;
        password1 = 16'h0000; // Wrong password
        #20;
        sensor1_entry = 0;

        // Test case 2: Sensor 1 entry with correct password
        sensor1_entry = 1;
        password1 = 16'h1234; // Correct password
        #20;
        sensor1_entry = 0;

        // Test case 3: Sensor 1 exit
        sensor1_exit = 1;
        #20;
        sensor1_exit = 1;

        // Test case 4: Sensor 2 entry with wrong password
        sensor2_entry = 1;
        password2 = 16'h1234; // Wrong password
        #20;
        sensor2_entry = 0;

        // Test case 5: Sensor 2 entry with correct password
        sensor2_entry = 0;
        password2 = 16'h1234; // Correct password
        #20;
        sensor2_entry = 0;

        // Test case 6: Sensor 2 exit
        sensor2_exit = 1;
        #20;
        sensor2_exit = 1;

        // Test case 7: Reset the system
        rst = 1;
        #10;
        rst = 0;
        #10;

        // End simulation
        # 500 $finish;
    end

    // Monitor outputs for debugging
    initial begin
        $monitor("At time %t, Greenled1 = %b, Redled1 = %b, Greenled2 = %b, Redled2 = %b, HEX_1 = %b, HEX_2 = %b, HEX_3 = %b, HEX_4 = %b", 
                 $time, Greenled1, Redled1, Greenled2, Redled2, HEX_1, HEX_2, HEX_3, HEX_4);
    end

endmodule

