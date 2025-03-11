`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2025 10:50:40 PM
// Design Name: Car Parking System
// Module Name: car_parking
// Project Name: FPGA Car Parking System
// Target Devices: Artix-7
// Tool Versions: Vivado
// Description: 
// - FSM-based parking system with password authentication
// - LED indicators and 7-segment display
// Dependencies: None
//////////////////////////////////////////////////////////////////////////////////
module car_parking(
    input wire clk, rst,
    input wire sensor1_entry, sensor1_exit, sensor2_entry, sensor2_exit,
    input wire [15:0] password1, password2,
    output reg Greenled1, Redled1, Greenled2, Redled2,
    output reg [6:0] HEX_1, HEX_2, HEX_3, HEX_4
);

    // State Encoding
    typedef enum reg [2:0] {
        IDLE          = 3'b000, 
        WAIT_PASSWORD = 3'b001,
        WRONG_PASS    = 3'b010,
        RIGHT_PASS    = 3'b011,
        STOP         = 3'b100
    } state_t;
    
    state_t current_state, next_state;
    
    // Clocked State Transition
    always @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= IDLE;
        else 
            current_state <= next_state;
    end

    // Password Verification Logic
    wire pass1_correct = (password1 == 16'h1234);
    wire pass2_correct = (password2 == 16'h1234);
    
    // Next State Logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (sensor1_entry || sensor2_entry)
                    next_state = WAIT_PASSWORD;
                else
                    next_state = IDLE;
            end
            
            WAIT_PASSWORD: begin
                if ((sensor1_entry && pass1_correct) || (sensor2_entry && pass2_correct))
                    next_state = RIGHT_PASS;
                else
                    next_state = WRONG_PASS;
            end
            
            WRONG_PASS: begin
                if ((sensor1_entry && pass1_correct) || (sensor2_entry && pass2_correct))
                    next_state = RIGHT_PASS;
                else
                    next_state = WRONG_PASS;
            end
            
            RIGHT_PASS: begin
                if (sensor1_exit || sensor2_exit)
                    next_state = STOP;
                else
                    next_state = RIGHT_PASS;
            end
            
            STOP: begin
                next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end
    
    // Output Logic: LEDs and 7-Segment Display
    always @(*) begin
        // Default values
        Greenled1 = 0;
        Redled1 = 1;
        Greenled2 = 0;
        Redled2 = 1;
        HEX_1 = 7'b000_0110; // Default E
        HEX_2 = 7'b000_0110; // Default E
        HEX_3 = 7'b000_0110; // Default E
        HEX_4 = 7'b000_0110; // Default E
        
        case (current_state)
            WRONG_PASS: begin
                HEX_1 = 7'b100_0010; // W
                HEX_2 = 7'b000_0111; // R
                HEX_3 = 7'b000_0111; // R
                HEX_4 = 7'b100_0000; // O
            end
            
            RIGHT_PASS: begin
                if (sensor1_entry && !sensor1_exit && pass1_correct) begin
                    Greenled1 = 1; Redled1 = 0;
                    HEX_1 = 7'b100_0011; // G
                    HEX_2 = 7'b100_0000; // O
                end
                else if (sensor2_entry && !sensor2_exit && pass2_correct) begin
                    Greenled2 = 1; Redled2 = 0;
                    HEX_3 = 7'b100_0011; // G
                    HEX_4 = 7'b100_0000; // O
                end
            end
            
            STOP: begin
                HEX_1 = 7'b000_0110; // E
                HEX_2 = 7'b000_0110; // E
                HEX_3 = 7'b000_0110; // E
                HEX_4 = 7'b000_0110; // E
            end
        endcase
    end

endmodule


