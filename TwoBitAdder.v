/*
 *  File: TwoBitAdder.v
 *  Author: Caleb Huning
 *  Modules:
 *  	TwoBitAdder	- Module which takes two 2-bit inputs and returns
 *					  their sum as one 2-bit output
 *  	TestAdder	- TestBench to demonstrate functionality of the
 *					  TwoBitAdder module
 */


/*
 *  Module: TwoBitAdder
 *  Author: Caleb Huning
 *  Ports:
 *  	ab - I/P reg	The first two-bit operand
 *  	cd - I/P reg	The second two-bit operand which will be added to ab
 *  	o - O/P wire	The sum of ab and cd, using saturation to restrict
 *						the output from 00 to 11
 */
module TwoBitAdder( input [1:0] ab, input [1:0] cd, output [1:0] o );
	// Variables to hold outputs of each gate
	wire na, nb, nc, nd, x0, x1, y0, y1, y2, y3, y4;
	not #1 // NOT gates
		ng1( na, ab[1] ), // Negation of A
		ng2( nb, ab[0] ), // Negation of B
		ng3( nc, cd[1] ), // Negation of C
		ng4( nd, cd[0] ); // Negation of D
	and #1 // AND gates
		// High bit AND gates
		ag1( x0, ab[1], nc ), // AND gate for AC'
		ag2( x1, ab[0], cd[0] ), // AND gate for BD
		// Low bit AND gates
		ag3( y0, na, nb, cd[0] ), // AND gate for A'B'D
		ag4( y1, ab[0], nc, nd ), // AND gate for BC'D'
		ag5( y2, ab[0], cd[1] ), // AND gate for BC
		ag6( y3, ab[1], cd[0] ), // AND gate for AD
		ag7( y4, ab[1], cd[1] ); // AND gate for AC
	or #1 // OR gates
		// High bit OR gates
		og1( o[1], x0, x1, cd[1] ), // OR gate for AC' + BD
		// Low bit OR gates
		og2( o[0], y0, y1, y2, y3, y4 ); // OR gate for A'B'D + BC'D' + BC + AD + AC
	// Expected output is now stored in o; end of module
endmodule


/*
 *  Module: TestAdder	- TestBench for TwoBitAdder module
 *  Author: Caleb Huning
 *  Ports: None
 */
module TestAdder;
	reg [1:0] ab, cd; // Storage for input operands
	wire [1:0] o; // Storage for output AB + CD
	TwoBitAdder tba( ab, cd, o ); // Instantiate TwoBitAdder module
	// This block manually checks all 16 possible inputs
	// Waits 4 ticks between each input to get correct output
	initial begin
		// Set inputs to 00 + 00 and display output; expected output is 00
		ab = 2'b00;
		cd = 2'b00;
		#4 $display("num1: %2b num2: %2b num1+num2: %2b", ab, cd, o);
		// Set inputs to 01 + 00 and display output; expected output is 01
		ab = 2'b01;
		#4 $display("num1: %2b num2: %2b num1+num2: %2b", ab, cd, o);
		// Set inputs to 11 + 00 and display output; expected output is 11
		ab = 2'b11;
		#4 $display("num1: %2b num2: %2b num1+num2: %2b", ab, cd, o);
		// Set inputs to 10 + 00 and display output; expected output is 10
		ab = 2'b10;
		#4 $display("num1: %2b num2: %2b num1+num2: %2b", ab, cd, o);
		// Set inputs to 00 + 01 and display output; expected output is 01
		ab = 2'b00;
		cd = 2'b01;
		#4 $display("num1: %2b num2: %2b num1+num2: %2b", ab, cd, o);
		// Set inputs to 01 + 01 and display output; expected output is 10
		ab = 2'b01;
		#4 $display("num1: %2b num2: %2b num1+num2: %2b", ab, cd, o);
		// Set inputs to 11 + 01 and display output; expected output is 11
		ab = 2'b11;
		#4 $display("num1: %2b num2: %2b num1+num2: %2b", ab, cd, o);
		// Set inputs to 10 + 01 and display output; expected output is 11
		ab = 2'b10;
		#4 $display("num1: %2b num2: %2b num1+num2: %2b", ab, cd, o);
		// Set inputs to 00 + 11 and display output; expected output is 11
		ab = 2'b00;
		cd = 2'b11;
		#4 $display("num1: %2b num2: %2b num1+num2: %2b", ab, cd, o);
		// Set inputs to 01 + 11 and display output; expected output is 11
		ab = 2'b01;
		#4 $display("num1: %2b num2: %2b num1+num2: %2b", ab, cd, o);
		// Set inputs to 11 + 11 and display output; expected output is 11
		ab = 2'b11;
		#4 $display("num1: %2b num2: %2b num1+num2: %2b", ab, cd, o);
		// Set inputs to 10 + 11 and display output; expected output is 11
		ab = 2'b10;
		#4 $display("num1: %2b num2: %2b num1+num2: %2b", ab, cd, o);
		// Set inputs to 00 = 10 and display output; expected output is 10
		ab = 2'b00;
		cd = 2'b10;
		#4 $display("num1: %2b num2: %2b num1+num2: %2b", ab, cd, o);
		// Set inputs to 01 + 10 and display output; expected output is 11
		ab = 2'b01;
		#4 $display("num1: %2b num2: %2b num1+num2: %2b", ab, cd, o);
		// Set inputs to 11 + 10 and display output; expected output is 11
		ab = 2'b11;
		#4 $display("num1: %2b num2: %2b num1+num2: %2b", ab, cd, o);
		// Set inputs to 10 + 10 and display output; expected output is 11
		ab = 2'b10;
		#4 $display("num1: %2b num2: %2b num1+num2: %2b", ab, cd, o);
	end
	// All 16 outputs have now been tested and displayed, end of module
endmodule