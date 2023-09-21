// Problem 2:

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2023 08:39:41 PM
// Design Name: 
// Module Name: ALU
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

// ALU
// A: 4-bit input
// B: 4-bit input
// Cin: 1-bit input
// Output: 4-bit output
// Cout: 1-bit output
// Control: 3-bit control input
module ALU(Output, Cout, A, B, Control, Cin);
    // 3-bit register signal: reg is a storage element whos value can be manipulated in code.
    output reg[3:0] Output;
    output reg Cout;
    input[3:0] A;
    input[3:0] B;
    input[2:0] Control;
    input Cin;

    // execute whenever signals change in list.
    // could also do always @(A, B, Control, Cin)??
    always @(*) begin
        case(Control)
            // 3 bits 'b for binary, 000
            // Ex: 8 bits would be 8'b00010101
            // <= non-blocking statement, we can execute statements without blocking the sequential flow. Several statements same time.
            // = blocking statement, must complete execution of statement before next statements in a sequential block get executed.
            // thinking here is that an ALU should have to complete execution of a statement before the next one gets executed.
            // considering this circuit is completely combinational, blocking statements will lead to more consistent behavior.
            3'b000: begin
                Output = A + B + Cin;
                Cout = (A[2] & B[2]) | (A[2] & Cin) | (B[2] & Cin);
            end
            3'b001: begin
                Output = A - B - Cin;
                Cout = ~(A[2] ^ B[2]) & ((B[2] & Cin) | (~B[2] & Cin)); 
            end
            3'b010: begin
                Output = A | B;
                Cout = 1'b0;
            end
            3'b011: begin
                Output = A & B;
                Cout = 1'b0;
            end
            3'b100: begin
                Output = A << 1;
                Cout = A[2];
            end
            3'b101: begin 
                Output = A >> 1;
                Cout = A[0];
            end
            3'b110: begin
                Output = {A[2:0], A[3]};
                Cout = A[2]; 
            end
            3'b111: begin
                Output = {A[0], A[3:1]};
                Cout = A[0];
            end
        endcase
    end
endmodule
