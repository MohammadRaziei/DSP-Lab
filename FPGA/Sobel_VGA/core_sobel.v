`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

module core_sobel(
	input  [WordSize-1:0] sliding0,
	input  [WordSize-1:0] sliding1,
	input  [WordSize-1:0] sliding2,
	input  [WordSize-1:0] sliding3,
	input  [WordSize-1:0] sliding4,
	input  [WordSize-1:0] sliding5,
	input  [WordSize-1:0] sliding6,
	input  [WordSize-1:0] sliding7,
	input  [WordSize-1:0] sliding8,
	output [WordSize-1:0] outputPixel
	);

	parameter WordSize=16;
	parameter BlueWordSize=5;
	parameter GreenWordSize=6;
	parameter RedWordSize=5;


	wire signed [GreenWordSize+2:0] gxG, gyG;
	wire signed [GreenWordSize+2:0] abs_gxG, abs_gyG;
	wire signed [GreenWordSize+2:0] sumG;

	assign gxG = ((sliding2[10:5]-sliding0[10:5])+((sliding5[10:5]-sliding3[10:5])<<1)
		          + (sliding8[10:5]-sliding6[10:5]));
	assign gyG = ((sliding0[10:5]-sliding6[10:5])+((sliding1[10:5]-sliding7[10:5])<<1)
		          +(sliding2[10:5]-sliding8[10:5]));

	assign abs_gxG = (gxG[GreenWordSize+2]? ~gxG+1 : gxG);
	assign abs_gyG = (gyG[GreenWordSize+2]? ~gyG+1 : gyG);
	assign sumG = (abs_gxG+abs_gyG);

	// Image01
	assign outputPixel[10:5] = ((sumG[GreenWordSize+2:0]<9'b000000000)?6'b000000 : sumG[GreenWordSize-1:0]);

	

	// Image02
	//assign outputPixel[10:5] = ((sumG[GreenWordSize+2:0]<9'b000110000)?6'b000000 : sumG[GreenWordSize-1:0]);

	
	// Image03
	//assign outputPixel[10:5] = ((sumG[GreenWordSize+2:0]<9'b000000000)?6'b000000 : sumG[GreenWordSize-1:0]);
	
	// Image04
	//assign outputPixel[10:5] = ((sumG[GreenWordSize+2:0]<9'b000011000)?6'b000000 : sumG[GreenWordSize-1:0]);
	
	
endmodule
