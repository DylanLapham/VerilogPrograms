// Problem 1: 

// `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dylan Lapham
// 
// Create Date: 08/28/2023 01:55:32 PM
// Design Name: 
// Module Name: subtractor
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

// inputs and outputs. 4-bits (0, 1, 2, 3)
module subtractor(A, B, bin, diff, bout);
    // inputs and outputs
    output diff, bout;
    input A, B, bin;
    // code for logic component
    assign diff = (A ^ B) ^ bin; // diff is A xor B xor bin
    assign bout = ((~A) && bin) || ((~A) && B) || (B && bin); // bout: bin and not A OR B and bin OR not A and B
endmodule

module subtractor_4bit(diff, bout, A, B, bin);
    // inputs and outputs
    output [3:0] diff;
    output bout;
    input [3:0] A;
    input [3:0] B;
    input bin;
    // internal signal
    wire [2:0] b;

    // instantiate four copies for 4-bit
    // positional 
    subtractor FS0 (A[0], B[0], bin, diff[0], b[0]); 
    subtractor FS1 (A[1], B[1], b[0], diff[1], b[1]);
    subtractor FS2 (A[2], B[2], b[1], diff[2], b[2]);
    subtractor FS3 (A[3], B[3], b[2], diff[3], bout);
endmodule
