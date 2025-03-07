`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2025 10:06:11 PM
// Design Name: 
// Module Name: carparkingsystem
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


module carparking(
input sensor1_entry, sensor1_exit, sensor2_entry, sensor2_exit, clk, rst,
input [15:0] password1, password2,
output reg Greenled1, Redled1, Greenled2, Redled2,
output reg [6:0] HEX_1, HEX_2, HEX_3, HEX_4
);

parameter IDLE = 3'b000, 
          WAIT_PASSWORD = 3'b001,
          WRONG_PASSWORD = 3'b010,
          RIGHT_PASSWORD = 3'b011,
          STOP = 3'b100;

reg [2:0] current_state, next_state;
reg [31:0] counter;

// State register
always @(posedge clk or posedge rst) begin
    if (rst)
        current_state <= IDLE;
    else 
        current_state <= next_state;
end

// Counter logic
always @(posedge clk or posedge rst) begin
    if (rst)
        counter <= 0;
    else if (current_state == WAIT_PASSWORD)
        counter <= counter + 1;
    else
        counter <= 0;
end

// Next state logic
always @(*) begin
    case (current_state)
        IDLE: begin
            if (sensor1_entry == 1 || sensor2_exit == 1)
                next_state = WAIT_PASSWORD;
            else
                next_state = IDLE;
                
           
        end

        WAIT_PASSWORD: begin
            if (counter <= 3)
                next_state = WAIT_PASSWORD;
            else if (sensor1_entry == 1) begin
                if (password1 == 16'h1234) // Password is 1234
                    next_state = RIGHT_PASSWORD;
                else
                    next_state = WRONG_PASSWORD;
            end else if (sensor2_exit == 1) begin
                if (password2 == 16'h1234) // Password is 1234
                    next_state = RIGHT_PASSWORD;
                else
                    next_state = WRONG_PASSWORD;
            end
        end

        WRONG_PASSWORD: begin
            if (sensor1_entry == 1 && password1 == 16'h1234)
                next_state = RIGHT_PASSWORD;
            else if (sensor2_exit == 1 && password2 == 16'h1234)
                next_state = RIGHT_PASSWORD;
            else
                next_state = WRONG_PASSWORD;
                
                  
        end

        RIGHT_PASSWORD: begin
            if (sensor1_entry == 1 && sensor1_exit == 1) 
                next_state = STOP;
               else if ((sensor2_entry == 1 && sensor2_exit == 1)) 
                         next_state = STOP;
            else if (sensor1_exit == 1 || sensor2_entry == 1)
                next_state = IDLE;
            else
                next_state = RIGHT_PASSWORD;
                 
        end

        STOP: begin
            if (password1 == 16'h1234 || password2 == 16'h1234)
                next_state = RIGHT_PASSWORD;
            else
                next_state = STOP;
                
        end

        default: next_state = IDLE;
    endcase
end

// Output logic
always @(*) begin
    case (current_state)
        IDLE: begin
            Greenled1 = 1'b0;
            Redled1 = 1'b1;
            Greenled2 = 1'b0;
            Redled2 = 1'b1;
            HEX_1 = 7'b000_0110; // E
            HEX_2 = 7'b000_0110; // E
            HEX_3 = 7'b000_0110; // E
            HEX_4 = 7'b000_0110; // E
        end

        WRONG_PASSWORD: begin
            Greenled1 = 1'b0;
            Redled1 = 1'b1;
            Greenled2 = 1'b0;
            Redled2 = 1'b1;
            HEX_1 = 7'b000_0110; // E
            HEX_2 = 7'b000_0110; // E
            HEX_3 = 7'b000_0110; // E
            HEX_4 = 7'b000_0110; // E
        end

        RIGHT_PASSWORD: begin
            Greenled1 = 1'b1;
            Redled1 = 1'b0;
            Greenled2 = 1'b1;
            Redled2 = 1'b0;
             if (sensor2_exit == 1 && sensor1_entry == 1)begin
            HEX_1 = 7'b100_0011; // G
            HEX_2 = 7'b100_0000; // O
            HEX_3 = 7'b100_0011; // G
            HEX_4 = 7'b100_0000; // O
            end
            else if (sensor1_entry == 1)begin
                 if(sensor1_entry == 1 && sensor1_exit == 1) begin
                   HEX_1 = 7'b000_0110; // E
                             HEX_2 = 7'b000_0110; // E
                             end
                             
           else   HEX_1 = 7'b100_0011; // G
                      HEX_2 = 7'b100_0000; // O
        end
        else if( sensor2_exit == 1)begin
          if(sensor2_entry == 1 && sensor2_exit == 1)
          begin  HEX_3 = 7'b000_0110; // E
                     HEX_4 = 7'b000_0110; // E
                     end
          else begin 
              HEX_3 = 7'b100_0011; // G
                    HEX_4 = 7'b100_0000; // O
                    end
        end 
        end

        STOP: begin
            Greenled1 = 1'b0;
            Redled1 = 1'b1;
            Greenled2 = 1'b0;
            Redled2 = 1'b1;
            HEX_1 = 7'b000_0110; // E
            HEX_2 = 7'b000_0110; // E
            HEX_3 = 7'b000_0110; // E
            HEX_4 = 7'b000_0110; // E
        end

        default: begin
            Greenled1 = 1'b0;
            Redled1 = 1'b1;
            Greenled2 = 1'b0;
            Redled2 = 1'b1;
            HEX_1 = 7'b000_0110; // E
            HEX_2 = 7'b000_0110; // E
            HEX_3 = 7'b000_0110; // E
            HEX_4 = 7'b000_0110; // E
        end
    endcase
end

endmodule

