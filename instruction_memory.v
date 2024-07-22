`timescale 1ns / 1ps

module instruction_memory(
	output reg [31:0] instruction,

	input [7:0] read_address,
	input reset,clk
);
	
	reg [31:0] mem [255:0];
	integer i;
	
	always @(posedge clk) begin

		if(reset)
			for(i = 0; i < 256; i = i + 1)
				mem[i] = 32'b 0;
		

		///////////////////////////////////////////////////////
		//		a * b = c
		//		a in R1, b in R2, c in R3
		//		a = 5, b = 9
		
		mem[0] = 32'b 001110_00000_00001_0000000000000101;
		//R1 <- 5
		mem[1] = 32'b 001110_00000_00010_0000000000001001;
		//R2 <- 9
		mem[2] = 32'b 000000_00001_00010_00011_00000_001101;
		//R3 <- R1 * R2	
		
		///////////////////////////////////////////////////////
		//		a! = b
		//		a in R4, b in R7
		//		a = 5
		 
		mem[3] = 32'b 001110_00000_00100_0000000000000101;
		//R4 <- 5
 		mem[4] = 32'b 001110_00000_00101_0000000000000001;
		//R5 <- 1
		mem[5] = 32'b 000000_00100_00101_00110_00000_000110;
		//R6 <- R4 - R5
		mem[6] = 32'b 000000_00100_00110_00111_00000_001101;
		//r7 <- r4 * r6
		mem[7] = 32'b 000000_00110_00101_00110_00000_000110;
		//R6 <- R6 - R5
		mem[8] = 32'b 000000_00110_00111_00111_00000_001101;
		//R7 <- R7 * R6
		mem[9] = 32'b 001100_00110_00101_0000000000000001;
		//branch 
		mem[10] = 32'b 000100_00000000000000000000000111;
		//jump to mem[7]		

		instruction = mem[read_address];	
	end
endmodule