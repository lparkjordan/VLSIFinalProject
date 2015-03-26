module e155ASIC #(parameter TIMEBITS = 3) (input  logic        clk1, clk2, reset,                  // 40 MHz clock 
               input logic keypadInputNswitchInput,
					input logic [3:0] switch1, switch2,      // the four DIP switches
					input  logic [3:0]  keypadRows,
					output logic [3:0]  keypadCols,
               output logic [6:0]  sevenSeg,				// the segments of the common-anode 7 segment display
					output logic        enable1, enable2  // the enables
					);    
					
logic [3:0]  digit1Keypad, digit2Keypad, digit1, digit2;
logic [TIMEBITS-1:0] timer1, timer2; // = 18'b0;
logic timer1out, timer2out;

//// Create a 6.5 ms timer for sevenSegOutput and lab3 modules
//always_ff @(posedge clk) begin
//	timer <= timer + 'b1; //increment timer
//end

flopr #(TIMEBITS) timerreg1(clk1, clk2, reset, 'b0, timer1 + 'b1, timer1);
flopr #(TIMEBITS) timerreg2(clk1, clk2, reset, 'b10, timer2 + 'b1, timer2);

assign timer1out = ~(|timer1[TIMEBITS-2:0]);
assign timer2out = ~(|timer2[TIMEBITS-2:0]);

//choose input of hex digits from either keypad or switches
assign digit1 = (keypadInputNswitchInput)	? digit1Keypad : switch1; 
assign digit2 = (keypadInputNswitchInput)	? digit2Keypad : switch2;

//get digits from keypad
lab3 keypadInput(timer1out, timer2out, reset, keypadRows, keypadCols, digit1Keypad, digit2Keypad);  // output digit1 and digit2 from keypad

//output digits to seven seg
sevenSegOutput out(timer1[TIMEBITS-1], digit1, digit2, enable1, enable2, sevenSeg);
					
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


module lab3(input  logic        ph1, ph2,                  // timer 
				input  logic        reset,
				input  logic [3:0]  rows,
				output logic [3:0]  cols,
				output logic [3:0]  currentDigit, lastDigit
             );                  // the segments
  
  //typedef enum logic [1:0] {C1=2'b00, C2, C3, C4} statetype;

  
  // enumerated type for hex digits
  //typedef enum logic [3:0] {d0, d1, d2, d3, d4, d5, d6 ,d7 ,d8 ,d9 ,da ,db, dc, dd ,de ,df} digit;
//  statetype state = C1; // which column is being checked
//  statetype nextstate = C2;  // which column is going to be checked next
  logic [1:0] state;
  logic [1:0] nextstate;
  
  logic [3:0] lastrow; // keep track of last button pressed (store row data corresponding to last key)
  logic [3:0] nextlastrow;
  
  logic updatedigit; //flag to update digit displays
  //digit currentDigit = d0, lastDigit = d0, nextdigit = d0;
  logic [3:0] nextdigit;
  
  logic [3:0] currentSelector; //the digit being used for output 
  //logic [17:0] timer = 18'b0; //counts 6.5 ms
    
//	//update states
//	// Update FSM every 6.5 ms
//	always_ff @(posedge timer) begin	
//			state <= nextstate;
//			lastrow <= nextlastrow;
//			//update digits as necessary
//			if (updatedigit) begin
//				lastDigit <= currentDigit;
//				currentDigit <= nextdigit; 
//			end
//			else begin
//				lastDigit <= lastDigit;
//				currentDigit <= currentDigit;
//			end
//	end
	
	flopr #(2) statereg(ph1, ph2, reset, 2'd0, nextstate, state);
	flopr #(4) lastrowreg(ph1, ph2, reset, 4'b0, nextlastrow, lastrow);
	flopr #(4) lastdigitreg(ph1, ph2, reset, 4'b0, (updatedigit) ? currentDigit : lastDigit, lastDigit);
	flopr #(4) currentdigitreg(ph1, ph2, reset, 4'b0, (updatedigit) ? nextdigit : currentDigit, currentDigit);
		
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

//module sevenSegOutput(input logic clk,
//							input logic [3:0] digit1, digit2,
//							output logic  enable1, enable2,
//							output logic [6:0] seg
//							);
//logic [17:0] timer = 18'b0;
// logic [3:0] currentDigit;
// 
//always_ff @(posedge clk) begin
//	timer <= timer + 18'b1; //increment timer
//end
//
//assign enable1 = ~timer[17];
//assign enable2 = timer[17];
//assign currentDigit = enable2 ? digit1 : digit2; 
//
//always_comb
//	case (currentDigit)
//		//                abc_defg
//		4'b0000: seg = 7'b000_0001; //0
//		4'b0001: seg = 7'b100_1111; //1
//		4'b0010: seg = 7'b001_0010; //2
//		4'b0011: seg = 7'b000_0110; //3
//		4'b0100: seg = 7'b100_1100; //4
//		4'b0101: seg = 7'b010_0100; //5
//		4'b0110: seg = 7'b010_0000; //6
//		4'b0111: seg = 7'b000_1111; //7
//		4'b1000: seg = 7'b000_0000; //8
//		4'b1001: seg = 7'b000_1100; //9
//		4'b1010: seg = 7'b000_1000; //a
//		4'b1011: seg = 7'b110_0000; //b
//		4'b1100: seg = 7'b111_0010; //c
//		4'b1101: seg = 7'b100_0010; //d
//		4'b1110: seg = 7'b011_0000; //e
//		4'b1111: seg = 7'b011_1000; //f
//		default: seg = 7'b111_1111; //default (display nothing)
//	endcase	
//							
//endmodule

//module lab3(input  logic        clk,                   // timer 
//				input  logic [3:0]  rows,
//				output logic [3:0]  cols,
//				output logic [3:0]  currentDigit, lastDigit,
//             );                  // the segments
//  
//  typedef enum logic [1:0] {C1, C2, C3, C4} statetype;
//  // enumerated type for hex digits
//  //typedef enum logic [3:0] {d0, d1, d2, d3, d4, d5, d6 ,d7 ,d8 ,d9 ,da ,db, dc, dd ,de ,df} digit;
//  statetype state = C1; // which column is being checked
//  statetype nextstate = C2;  // which column is going to be checked next
//  
//  logic [3:0] lastrow = 4'b0; // keep track of last button pressed (store row data corresponding to last key)
//  logic [3:0] nextlastrow = 4'b0;
//  
//  logic updatedigit = 0; //flag to update digit displays
//  //digit currentDigit = d0, lastDigit = d0, nextdigit = d0;
//  logic [3:0] nextdigit = 4'h0;
//  
//  logic [3:0] currentSelector; //the digit being used for output 
//  logic [17:0] timer = 18'b0; //counts 6.5 ms
//    
//	//update timer, enables, and currentSelector
//	always_ff @(posedge clk) begin
//		timer <= timer + 18'b1; //increment timer
//				
//		// Update FSM every 6.5 ms
//		if (timer == 18'b0) begin
//			state <= nextstate;
//			lastrow <= nextlastrow;
//			//update digits as necessary
//			if (updatedigit) begin
//				lastDigit <= currentDigit;
//				currentDigit <= nextdigit; 
//			end
//			else begin
//				lastDigit <= lastDigit;
//				currentDigit <= currentDigit;
//			end
//		end
//	end
//		
//	// column scan logic 
//	// Note, columns not being scanned are left to float
//	// so that connections do not cause short circuits
//	always_comb begin
//		case (state)
//			C1: cols = 4'b1zzz;
//			C2: cols = 4'bz1zz;
//			C3: cols = 4'bzz1z;
//			C4: cols = 4'bzzz1;
//			default: cols = 4'bzzzz;
//		endcase
//	end
//	
//	// next state logic
//	always_comb begin
//		// If same button is still down, freeze the system
//		if (|(lastrow & rows)) begin
//			nextdigit = currentDigit; // Can I commment this out?
//			updatedigit = 0;
//			nextstate = state; // don't change column under consideration
//			nextlastrow = lastrow;
//		end
//		else begin
//			//If something new is pressed!
//			if (|rows) begin
//				nextstate = state; // don't change column under consideration
//				casez (rows)
//						4'b1???: nextlastrow = 4'b1000;
//						4'b01??: nextlastrow = 4'b0100;
//						4'b001?: nextlastrow = 4'b0010;
//						4'b0001: nextlastrow = 4'b0001;
//						default: nextlastrow = 4'b0000; //shouldn't happen
//				endcase						
//				// We have a new digit!
//				updatedigit = 1;
//				case (state)
//					C1: casez (rows)
//						4'b1???: nextdigit = 4'h1;//d1;
//						4'b01??: nextdigit = 4'h4;//d4;
//						4'b001?: nextdigit = 4'h7;//d7;
//						4'b0001: nextdigit = 4'he;//de;
//						default: nextdigit = currentDigit; //shouldn't happen
//						endcase
//					C2: casez (rows)
//						4'b1???: nextdigit = 4'h2;//d2;
//						4'b01??: nextdigit = 4'h5;//d5;
//						4'b001?: nextdigit = 4'h8;//d8;
//						4'b0001: nextdigit = 4'h0;//d0;
//						default: nextdigit = currentDigit; //shouldn't happen
//						endcase
//					C3: casez (rows)
//						4'b1???: nextdigit = 4'h3;//d3;
//						4'b01??: nextdigit = 4'h6;//d6;
//						4'b001?: nextdigit = 4'h9;//d9;
//						4'b0001: nextdigit = 4'hf;//df;
//						default: nextdigit = currentDigit; //shouldn't happen
//						endcase
//					C4: casez (rows)
//						4'b1???: nextdigit = 4'ha;//da;
//						4'b01??: nextdigit = 4'hb;//db;
//						4'b001?: nextdigit = 4'hc;//dc;
//						4'b0001: nextdigit = 4'hd;//dd;
//						default: nextdigit = currentDigit; //shouldn't happen
//						endcase
//				endcase
//			end
//			
//			// If nothing has been pressed here, check next column
//			else begin
//				updatedigit = 0;
//				nextdigit = currentDigit;
//				nextlastrow = 4'b0000; // reset knowledge of last button pushed
//				
//				case (state)
//					C1: nextstate = C2;
//					C2: nextstate = C3;
//					C3: nextstate = C4;
//					C4: nextstate = C1;
//					default: nextstate = C1;
//				endcase
//			end
//		end
//	end
//	
//end
//endmodule
