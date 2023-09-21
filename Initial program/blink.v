// sets the timescale for the simulation
// unit: 1 nanosecond, precision: 1 picosecond
`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer: Dylan Lapham
// 
// Create Date: 06/15/2023 07:37:01 PM
// Module Name: blink 
// Target Devices: Nexys A7 FPGA board
// Tool Versions: Vivado 2023.1
// Description: This Verilog program is a basic start to the HDL itself. A blinking light can be seen approximately 3 times every second on led 0 of the Nexys A7 FPGA board.
// 
// Dependencies: Nexys-4-DDR-Master.xdc
//////////////////////////////////////////////////////////////////////////////////

// module named blink has two ports: input clock and an output led
// clk is clock signal
module blink(output led, input clk);
    // this line declares a 25-bit register named count. This register will be used to keep track of the number of clock cycles.
    reg [24:0] count = 0;
    //  assigns the most significant bit of the count register to the output port led. This means that the LED will be controlled by the MSB of the count register.
    assign led = count[24];
    // execute whenever there is a positive edge or rising edge of clock signal
    always @ (posedge(clk))
    // increment count
    count <= count + 1;
endmodule
