module TrafficLightController(clk, MAINT, Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw);
    output reg Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw;
    input clk, MAINT;
    
    // 
    reg [5:0] state, nextState;
    
    initial
    begin
        state <= 0;
        nextState <= 0;
        // I just learned you can do this for multiple signals.
        {Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw} <= 0;
    end
    
   always @(state)
   begin
        case(state)
        0, 1, 2, 3, 4, 5: begin
            {Ga, Rb, Rw} <= 3'b111;
            {Ya, Ra, Yb, Gb, Gw} <= 5'b00000;
            nextState <=  state + 1;
            end
        6, 7, 8, 9: begin
            {Ya, Rb, Rw} <= 3'b111;
            {Ra, Yb, Ga, Gb, Gw} <= 5'b00000;
            nextState <= state + 1;
            end
       10, 11, 12, 13, 14, 15: begin
            {Ra, Gb, Rw} <= 3'b111;
            {Ga, Ya, Yb, Rb, Gw} <= 5'b00000;
            nextState <= state + 1;
            end
       16, 17: begin
            {Ra, Yb, Rw} <= 3'b111;
            {Ga, Ya, Gb, Rb, Gw} <= 5'b00000;
            nextState <= state + 1;
            end
       18, 19, 20, 21: begin
            {Ra, Rb, Gw} <= 3'b111;
            {Ga, Ya, Gb, Yb, Rw} <= 5'b00000;
            nextState <= state + 1;
            end
       22, 24: begin //blinks at 2hz
            {Ra, Rb, Rw} <= 3'b111;
            {Ga, Ya, Gb, Yb, Gw} <= 5'b00000;
            nextState <= state + 1;
            end
       23, 25: begin //blinks at 2hz
            {Ra, Rb} <= 2'b11;
            {Ya, Ra, Gb, Yb, Gw, Rw} <= 6'b000000;
            nextState <= state + 1;
            end
       // this is the maintenance mode
       26: begin
            {Ra, Rb, Rw} <= 3'b111;
            {Ga, Ya, Gb, Yb, Gw} <= 5'b00000;
            nextState <= 27;
            end
       27: begin
            {Ra, Rb, Rw} <= 3'b111;
            {Ga, Ya, Gb, Yb, Gw} <= 5'b00000;
            nextState <= 28;
            end
       28: begin
            {Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw} <= 8'b00000000;
            nextState <= 29;
            end
       29: begin
            {Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw} <= 8'b00000000;
            nextState <= 26;
            end
       default:
           begin
           nextState <= 0;
           {Ra, Ya, Ga, Rb, Yb, Gb, Rw, Gw} <= 8'b00000000;
           end
        endcase
   end
   
   always @(posedge clk)
    begin
        if (MAINT)
        begin
            if (nextState <= 29)
                state <= nextState;
            else
                state <= 26;
        end
            else
            begin
                if (nextState == 26 || nextState == 27|| nextState == 28 || nextState == 29)
                    state <= 0;
                else
                    state <= nextState;
            end
    end
endmodule

module complexDivider(clk100Mhz, slowClk);
  input clk100Mhz; //fast clock
  output reg slowClk; //slow clock

  reg[27:0] counter;

  initial begin
    counter = 0;
    slowClk = 0;
  end

  always @ (posedge clk100Mhz)
  begin
    if(counter == 25000000) begin 
      counter <= 1;
      slowClk <= ~slowClk;
    end
    else begin
      counter <= counter + 1;
    end
  end

endmodule

module top(clk, MAINT, Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw);
    output Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw;
    input clk, MAINT;
    
    wire slowCLK;
    
    // instantiate modules
    TrafficLightController TLC1(slowCLK, MAINT, Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw);
    complexDivider CD(clk, slowCLK);
endmodule
