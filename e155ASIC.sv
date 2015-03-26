module e155ASIC #(parameter TIMEBITS = 3) (input  logic        clk1, clk2, reset,                  // 40 MHz clock 
               input logic keypadInputNswitchInput,
                    input logic [3:0] switch1, switch2,      // the four DIP switches
                    input  logic [3:0]  keypadRows,
                    output logic [3:0]  keypadCols,
                      output logic [6:0]  sevenSeg,                // the segments of the common-anode 7 segment display
                    output logic        enable1, enable2  // the enables
                    );    
                    
logic [3:0]  digit1Keypad, digit2Keypad, digit1, digit2;
logic slowtimer;

//choose input of hex digits from either keypad or switches
assign digit1 = (keypadInputNswitchInput)    ? digit1Keypad : switch1; 
assign digit2 = (keypadInputNswitchInput)    ? digit2Keypad : switch2;

//get digits from keypad
lab3 keypadInput(clk1, clk2, reset, keypadRows, keypadCols, digit1Keypad, digit2Keypad, slowtimer);  // output digit1 and digit2 from keypad

//output digits to seven seg
sevenSegOutput out(slowtimer, digit1, digit2, enable1, enable2, sevenSeg);
                    
endmodule 

module sevenSegOutput(input logic timer,
                            input logic [3:0] digit1, digit2,
                            output logic  enable1, enable2,
                            output logic [6:0] seg
                            );
 logic [3:0] currentDigit;
 
assign enable1 = timer;
assign enable2 = ~timer;
assign currentDigit = enable2 ? digit1 : digit2; 

always_comb
    case (currentDigit)
        //                gfedcba
        4'b0000: seg = 7'b1000000;
        4'b0001: seg = 7'b1111001;
        4'b0010: seg = 7'b0100100;
        4'b0011: seg = 7'b0110000;
        4'b0100: seg = 7'b0011001;
        4'b0101: seg = 7'b0010010;
        4'b0110: seg = 7'b0000010;
        4'b0111: seg = 7'b1111000;
        4'b1000: seg = 7'b0000000;
        4'b1001: seg = 7'b0011000;
        4'b1010: seg = 7'b0001000;
        4'b1011: seg = 7'b0000011;
        4'b1100: seg = 7'b0100111;
        4'b1101: seg = 7'b0100001;
        4'b1110: seg = 7'b0000110;
        4'b1111: seg = 7'b0001110;
        default: seg = 7'b1111111;
    endcase    
                            
endmodule


module lab3 #(parameter TIMEBITS = 3) (input  logic        ph1, ph2,                  // timer 
                input  logic        reset,
                input  logic [3:0]  rows,
                output logic [3:0]  cols,
                output logic [3:0]  currentDigit, lastDigit,
                output logic slowtimer
             );                  // the segments
  

    logic [1:0] state;
    logic [1:0] nextstate;

    logic [3:0] lastrow; // keep track of last button pressed (store row data corresponding to last key)
    logic [3:0] nextlastrow;
    logic updatedigit; //flag to update digit displays
    logic [3:0] nextdigit;
  
    logic [3:0] currentSelector; //the digit being used for output

    logic [TIMEBITS-1:0] enabletimer;
    logic slowen; // enable that goes high every 2^NBITS-1 cycles
    logic slowtimer; // 50% duty cycle timer that changes every 2^NBITS-1 cycles

    flopr #(TIMEBITS) enablereg(ph1,ph2,reset,'b0,enabletimer+1,enabletimer);
    assign slowen = &enabletimer;
    flopenr #(1) timerreg(ph1,ph2,reset,slowen,~slowtimer, slowtimer);
    
    flopenr #(2) statereg(ph1, ph2, reset, slowen, nextstate, state);
    flopenr #(4) lastrowreg(ph1, ph2, reset, slowen, nextlastrow, lastrow);
    flopenr #(4) lastdigitreg(ph1, ph2, reset, slowen, (updatedigit) ? currentDigit : lastDigit, lastDigit);
    flopenr #(4) currentdigitreg(ph1, ph2, reset, slowen, (updatedigit) ? nextdigit : currentDigit, currentDigit);
        
    // column scan logic 
    // Note, columns not being scanned are left to float
    // so that connections do not cause short circuits
    always_comb begin
        case (state)
            2'd0: cols = 4'b1zzz;
            2'd1: cols = 4'bz1zz;
            2'd2: cols = 4'bzz1z;
            2'd3: cols = 4'bzzz1;
            default: cols = 4'bzzzz;
        endcase
    end
    
    // next state logic
    always_comb begin
        // If same button is still down, freeze the system
        if (|(lastrow & rows)) begin
            nextdigit = currentDigit; // Can I commment this out?
            updatedigit = 0;
            nextstate = state; // don't change column under consideration
            nextlastrow = lastrow;
        end
        else begin
            //If something new is pressed!
            if (|rows) begin
                nextstate = state; // don't change column under consideration
                casez (rows)
                        4'b1???: nextlastrow = 4'b1000;
                        4'b01??: nextlastrow = 4'b0100;
                        4'b001?: nextlastrow = 4'b0010;
                        4'b0001: nextlastrow = 4'b0001;
                        default: nextlastrow = 4'b0000; //shouldn't happen
                endcase                        
                // We have a new digit!
                updatedigit = 1;
                case (state)
                    2'd0: casez (rows)
                        4'b1???: nextdigit = 4'h1;//d1;
                        4'b01??: nextdigit = 4'h4;//d4;
                        4'b001?: nextdigit = 4'h7;//d7;
                        4'b0001: nextdigit = 4'he;//de;
                        default: nextdigit = currentDigit; //shouldn't happen
                        endcase
                    2'd1: casez (rows)
                        4'b1???: nextdigit = 4'h2;//d2;
                        4'b01??: nextdigit = 4'h5;//d5;
                        4'b001?: nextdigit = 4'h8;//d8;
                        4'b0001: nextdigit = 4'h0;//d0;
                        default: nextdigit = currentDigit; //shouldn't happen
                        endcase
                    2'd2: casez (rows)
                        4'b1???: nextdigit = 4'h3;//d3;
                        4'b01??: nextdigit = 4'h6;//d6;
                        4'b001?: nextdigit = 4'h9;//d9;
                        4'b0001: nextdigit = 4'hf;//df;
                        default: nextdigit = currentDigit; //shouldn't happen
                        endcase
                    2'd3: casez (rows)
                        4'b1???: nextdigit = 4'ha;//da;
                        4'b01??: nextdigit = 4'hb;//db;
                        4'b001?: nextdigit = 4'hc;//dc;
                        4'b0001: nextdigit = 4'hd;//dd;
                        default: nextdigit = currentDigit; //shouldn't happen
                        endcase
                endcase
            end
            
            // If nothing has been pressed here, check next column
            else begin
                updatedigit = 0;
                nextdigit = currentDigit;
                nextlastrow = 4'b0000; // reset knowledge of last button pushed
                
                case (state)
                    2'd0: nextstate = 2'd1;
                    2'd1: nextstate = 2'd2;
                    2'd2: nextstate = 2'd3;
                    2'd3: nextstate = 2'd0;
                    default: nextstate = 2'd0;
                endcase
            end
        end
    end
    
endmodule

module flopenr #(parameter WIDTH = 8)
                (input  logic             ph1, ph2, reset, en,
                 input  logic [WIDTH-1:0] d, 
                 output logic [WIDTH-1:0] q);
 
  logic [WIDTH-1:0] d2, resetval;

  assign resetval = 0;

  mux3 #(WIDTH) enrmux(q, d, resetval, {reset, en}, d2);
  flop #(WIDTH) f(ph1, ph2, d2, q);
endmodule

module flopr #(parameter WIDTH = 8)
                (input  logic             ph1, ph2, reset,
         input logic [WIDTH-1:0] resetval,
                 input  logic [WIDTH-1:0] d, 
                 output logic [WIDTH-1:0] q);
                      
 logic [WIDTH-1:0] d2;
 
 assign d2 = reset ? resetval : d;
 flop #(WIDTH) f(ph1, ph2, d2, q);
endmodule

module flop #(parameter WIDTH = 8)
             (input  logic             ph1, ph2, 
              input  logic [WIDTH-1:0] d, 
              output logic [WIDTH-1:0] q);

  logic [WIDTH-1:0] mid;

  latch1 #(WIDTH) master(ph2, d, mid);
  latch1 #(WIDTH) slave(ph1, mid, q);
endmodule

module latch1 #(parameter WIDTH = 8)
              (input  logic             ph, 
               input  logic [WIDTH-1:0] d, 
               output logic [WIDTH-1:0] q);

  always_latch
    if (ph) q <= d;
endmodule
