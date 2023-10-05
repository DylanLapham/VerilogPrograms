`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dylan Lapham & Jae Yong Yu
// 
// Create Date: 09/19/2023 11:43:11 PM
// Design Name: Package sorter
// Module Name: Package_Sorter
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


module Package_Sorter(clk, weight, reset, Grp1, Grp2, Grp3, Grp4, Grp5, Grp6, currentGrp);
    output reg [7:0] Grp1, Grp2, Grp3, Grp4, Grp5, Grp6; // 6 8-bit unsigned outputs
    output reg [2:0] currentGrp;                         // 3-bit unsigned number representing current group number
    input clk, reset;                                    // clk and reset
    input [11:0] weight;                                 // 12-bit unsigned binary number indicating weight
    reg ready;                                           // is ready
    
    // not synthesizable. Should be fine, just noting.
    // we are ready, and each group is 'empty'
    initial 
    begin
        Grp1 = 0;
        Grp2 = 0;
        Grp3 = 0;
        Grp4 = 0;
        Grp5 = 0;
        Grp6 = 0;
        ready = 1;
    end
    
    always @(negedge clk, posedge reset)
    begin
        if(reset == 1) begin
            Grp1 <= 0;
            Grp2 <= 0;
            Grp3 <= 0;
            Grp4 <= 0;
            Grp5 <= 0;
            Grp6 <= 0;
            ready <= 1;
            end
        else begin
            // ready is true
            if(weight == 0)
                ready = 1;
            else if(ready == 1) begin
                // say we are not ready, as we will begin loading
                ready = 0;
                case(currentGrp)            // increment the respective group
                    1: Grp1 = Grp1 + 1;
                    2: Grp2 = Grp2 + 1;
                    3: Grp3 = Grp3 + 1;
                    4: Grp4 = Grp4 + 1;
                    5: Grp5 = Grp5 + 1;
                    6: Grp6 = Grp6 + 1;
                endcase
           end
       end
   end    
   
   // base on weights, decode.
   // this is all in the document, grouping into 6 possible groups based on the weight itself in grams.
   always @(*)
   begin
        if((weight > 0) && (weight < 251))          // between 1 and 250
            currentGrp = 1;
        else if((weight > 250) && (weight < 501))   // between 251 and 500
            currentGrp = 2;
        else if((weight > 500) && (weight < 751))   // between 500 and 750
            currentGrp = 3;
        else if((weight > 750) && (weight < 1501))  // between 750 and 1500
            currentGrp = 4;
        else if((weight > 1500) && (weight < 2001)) // between 1500 and 2000
            currentGrp = 5;
        else if((weight > 2000))                    // greater than 2000
            currentGrp = 6;
        else
            currentGrp = 0;
    end
endmodule

module Package_sorter_TestBench();

    reg [11:0] weight;
    wire [7:0] Grp1,Grp2,Grp3,Grp4,Grp5,Grp6;
    wire [2:0] currentGrp;
    reg reset, clk;

    reg [11:0] weight_array [1:13];
    reg [7:0] Grp1_array [1:13];
    reg [7:0] Grp2_array [1:13];
    reg [7:0] Grp3_array [1:13];
    reg [7:0] Grp4_array [1:13];
    reg [7:0] Grp5_array [1:13];
    reg [7:0] Grp6_array [1:13];
    reg [2:0] currentGrp_array [1:13];
    reg reset_array [1:13];
    integer i;

    initial
    begin
       // set clk to 0
       clk = 0;
    
       // 1
	   weight_array[1] = 12'b000000000000;
	   Grp1_array[1] = 8'b00000000;
	   Grp2_array[1] = 8'b00000000;
	   Grp3_array[1] = 8'b00000000;
	   Grp4_array[1] = 8'b00000000;
	   Grp5_array[1] = 8'b00000000;
	   Grp6_array[1] = 8'b00000000;
	   currentGrp_array[1] = 3'b000;
	    
	   // 2
	   // put on 270 to weight
	   weight_array[2] = 12'b000100001110;
	   Grp1_array[2] = 8'b00000000;  
	   Grp2_array[2] = 8'b00000001;
	   Grp3_array[2] = 8'b00000000;
	   Grp4_array[2] = 8'b00000000;
	   Grp5_array[2] = 8'b00000000;
	   Grp6_array[2] = 8'b00000000;
	   currentGrp_array[2] = 3'b010;
	   
	   // 3
	   // take off
	   weight_array[3] = 12'b000000000000;
	   Grp1_array[3] = 8'b00000000;
	   Grp2_array[3] = 8'b00000001;
	   Grp3_array[3] = 8'b00000000;
	   Grp4_array[3] = 8'b00000000;
	   Grp5_array[3] = 8'b00000000;
	   Grp6_array[3] = 8'b00000000;
	   currentGrp_array[3] = 3'b000;
	   
	   // 4
	   // put on 300
	   weight_array[4] = 12'b000100101100;
	   Grp1_array[4] = 8'b00000000;
	   Grp2_array[4] = 8'b00000010;
	   Grp3_array[4] = 8'b00000000;
	   Grp4_array[4] = 8'b00000000;
	   Grp5_array[4] = 8'b00000000;
	   Grp6_array[4] = 8'b00000000;
	   currentGrp_array[4] = 3'b010;
	   
	   // 5
	   // take off
	   weight_array[5] = 12'b000000000000;
	   Grp1_array[5] = 8'b00000000;
	   Grp2_array[5] = 8'b00000010;
	   Grp3_array[5] = 8'b00000000;
	   Grp4_array[5] = 8'b00000000;
	   Grp5_array[5] = 8'b00000000;
	   Grp6_array[5] = 8'b00000000;
	   currentGrp_array[5] = 3'b000;
	   
	   // 6
	   // put on 501
	   weight_array[6] = 12'b000111110101;
	   Grp1_array[6] = 8'b00000000;
	   Grp2_array[6] = 8'b00000010;
	   Grp3_array[6] = 8'b00000001;
	   Grp4_array[6] = 8'b00000000;
	   Grp5_array[6] = 8'b00000000;
	   Grp6_array[6] = 8'b00000000;
	   currentGrp_array[6] = 3'b011;
	   
	   // 7
	   // put on 501 + 512      
	   weight_array[7] = 12'b001111110101;
	   Grp1_array[7] = 8'b00000000;
	   Grp2_array[7] = 8'b00000010;
	   Grp3_array[7] = 8'b00000001;
	   Grp4_array[7] = 8'b00000000;
	   Grp5_array[7] = 8'b00000000;
	   Grp6_array[7] = 8'b00000000;
	   currentGrp_array[7] = 3'b100;
	   
	   // reset
	   reset_array[1] = 1;
	   reset_array[2] = 0;
	   reset_array[3] = 0;
	   reset_array[4] = 0;
	   reset_array[5] = 0;
	   reset_array[6] = 0;
	   reset_array[7] = 0;
	   
	   forever
	   begin 
		  #10 clk = ~clk;
	   end
    end
    
    always
    begin
        for(i = 1; i < 13; i = i + 1)
        begin
            $display(i);
            weight <= weight_array[i];
            reset <= reset_array[i];
            @(posedge clk)
                #1;
                if(!(Grp1 == Grp1_array[i] && Grp2 == Grp2_array[i] && Grp3 == Grp3_array[i] && Grp4 == Grp4_array[i] && Grp5 == Grp5_array[i] && Grp6 == Grp6_array[i] && currentGrp == currentGrp_array[i]))
                begin
                    $display("Incorrect");
                end
                else
                begin
                    $display("Correct");
                end
         end
            $display("Done Testing");
    end
    
    // instantiate module last
    Package_Sorter Package_Sorter_1(clk, weight, reset, Grp1, Grp2, Grp3, Grp4, Grp5, Grp6, currentGrp);      
endmodule