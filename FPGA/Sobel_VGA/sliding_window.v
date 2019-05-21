`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module sliding_window(
	input clock,
	input [9:0] AH,
	input [8:0] AV,
	input reset,
	input [WORD_SIZE-1:0] inputPixel,
	output reg [WORD_SIZE-1:0] sliding0,
	output reg [WORD_SIZE-1:0] sliding1,
	output reg [WORD_SIZE-1:0] sliding2,
	output reg [WORD_SIZE-1:0] sliding3,
	output reg [WORD_SIZE-1:0] sliding4,
	output reg [WORD_SIZE-1:0] sliding5,
	output reg [WORD_SIZE-1:0] sliding6,
	output reg [WORD_SIZE-1:0] sliding7,
	output reg [WORD_SIZE-1:0] sliding8
	);
					 
   parameter WORD_SIZE=16;
   parameter BUFFER_SIZE=3;
   parameter ROW_SIZE = 180;
  
 
   reg [WORD_SIZE-1:0] buffer1[ROW_SIZE-1:0];
   reg [WORD_SIZE-1:0] buffer2[ROW_SIZE-1:0];

 
	always @(posedge clock) begin
		if(reset) begin	
			sliding0 <= 0;
			sliding1 <= 0;
			sliding2 <= 0;
			sliding3 <= 0;
			sliding4 <= 0;
			sliding5 <= 0;
			sliding6 <= 0;
			sliding7 <= 0;
			sliding8 <= 0;	
		end
		else begin
			sliding0 <= sliding1;
			sliding1 <= sliding2;
			sliding3 <= sliding4;
			sliding4 <= sliding5;
			sliding6 <= sliding7;
			sliding7 <= sliding8;
			sliding8 <= inputPixel;
			sliding2 <= buffer1[AH][WORD_SIZE-1:0];
			sliding5 <= buffer2[AH][WORD_SIZE-1:0];
			
			buffer2[AH][WORD_SIZE-1:0] <= sliding8;
			buffer1[AH][WORD_SIZE-1:0] <= sliding5;
	   end
	end
	
	

endmodule	
				

