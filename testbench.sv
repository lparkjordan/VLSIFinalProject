module testbench();
	logic ph1, ph2, reset;
	logic mode; //inputs
	logic [3:0] switch1, switch2, rows; 
	logic [3:0] expectedColumns; // expected outputs
	logic [6:0] expectedSeg;
	logic [1:0] expectedMulti;
	logic [3:0] columns; // actual outputs
	logic [6:0] seg;
	logic multi1, multi2;
	logic [26:0] testvectors[10000:0];
	logic [31:0] vectornum, errors;
	
	//instantiate device under test
	e155ASIC dut(ph1, ph2, reset, mode, switch1, switch2, rows, columns, seg, multi1, multi2);
	
	//generate clock(s)
	always
    begin
     ph1 = 0; ph2 = 0; #2; 
     ph1 = 1; # 8; 
     ph1 = 0; #2; 
     ph2 = 1; # 8;
    end

	//at start of test, load vectors and pulse reset
	initial
		begin
			$readmemb ("e155asic.tv", testvectors);
			vectornum = 0; errors = 0;
			reset <= 1; #41; reset <= 0;
		end
	
	// apply test vectors on rising edge of clock phase 1
	always @ (posedge ph1)
		begin
			#1; 
			{mode, switch1, switch2, rows, expectedColumns, expectedSeg, expectedMulti} = testvectors[vectornum];
		end
	
	// check results on falling edge of clock phase 2
	always @ (negedge ph2)
	begin
		if(~reset) begin //skip during reset
			if(columns !== expectedColumns || seg !== expectedSeg || {multi1, multi2} !== expectedMulti) begin
				$display("Error on line %d: inputs = %h", vectornum+1, {mode, switch1, switch2, rows});
				$display(" outputs = %h (%h expected)", {columns, seg, multi1, multi2}, {expectedColumns, expectedSeg, expectedMulti});
				errors = errors + 1;
			end
			vectornum = vectornum + 1;
		end
		if(testvectors[vectornum] === 27'bx) begin
			$display("%d tests completed with %d errors", vectornum, errors);
			$stop;
		end
	end
endmodule