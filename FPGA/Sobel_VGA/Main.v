`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module Main(
   input CLK,
   output [15:0] COLOUR_OUT,
   output HS,
   output VS
	);
	
	reg DOWNCOUNTER = 0;
 
// Image01 & Image02
	parameter pixelNum = 15'd22800;
	parameter Width = 8'd150;
	parameter Height = 8'd152;
	wire [14:0] STATE;
	reg signed [10:0]X = 10'd245;
	reg signed [9:0]Y = 9'd164;

/*
// Image03
	parameter pixelNum = 15'd16748;
	parameter Width = 8'd158;
	parameter Height = 7'd106;
	wire [14:0] STATE;
	reg signed [10:0]X = 10'd241;
	reg signed [9:0]Y = 9'd187;	
*/

/*
// Image04
	parameter pixelNum = 15'd30625;
	parameter Width = 8'd175;
	parameter Height = 8'd175;
	wire [14:0] STATE;
	reg signed [10:0]X = 10'd235;
	reg signed [9:0]Y = 9'd155;
*/
	always @(posedge CLK)begin     
		DOWNCOUNTER <= ~DOWNCOUNTER;
	end
   
	parameter WordSize=16;
	parameter BlueWordSize=5;
	parameter GreenWordSize=6;
	parameter RedWordSize=5;
   parameter BufferSize=3;
   parameter RowSize = 180;


	reg [15:0] COLOUR_IN;
	reg [15:0] COLOUR_DATA [0:pixelNum-1];
	
	wire TrigRefresh;
	wire [9:0] ADDRH;
	wire [8:0] ADDRV;
	wire [15:0] outputPixel;

	
	wire [WordSize-1:0] sliding0;
   wire [WordSize-1:0] sliding1;
   wire [WordSize-1:0] sliding2;
   wire [WordSize-1:0] sliding3;
   wire [WordSize-1:0] sliding4;
   wire [WordSize-1:0] sliding5;
   wire [WordSize-1:0] sliding6;
   wire [WordSize-1:0] sliding7;
   wire [WordSize-1:0] sliding8;
	
	
	VGA VGA(
		.CLK(CLK),
		.COLOUR_IN (outputPixel),
		.COLOUR_OUT(COLOUR_OUT),
		.HS(HS),
		.VS(VS),
		.REFRESH(TrigRefresh),
		.ADDRH(ADDRH),
		.ADDRV(ADDRV),
		.DOWNCOUNTER(DOWNCOUNTER)
	);
	
	initial
	$readmemh ("Image01.list", COLOUR_DATA);
	
	assign STATE = (ADDRH-X)*Height+ADDRV-Y;
	
	always @(posedge CLK) begin
		if (ADDRH>=X && ADDRH<X+Width && ADDRV>=Y && ADDRV<Y+Height) begin
			COLOUR_IN <= COLOUR_DATA[{STATE}];
		end
		else begin
			COLOUR_IN <= 16'h0000;
		end	
	end

	sliding_window #(.WORD_SIZE(16),.ROW_SIZE(640))
		my_window(
			.AH(ADDRH),
			.AV(ADDRV),
			.clock(CLK),
			.reset(1'b0),
			.inputPixel(COLOUR_IN),
			.sliding0(sliding0),
			.sliding1(sliding1),
			.sliding2(sliding2),
			.sliding3(sliding3),
			.sliding4(sliding4),
			.sliding5(sliding5),
			.sliding6(sliding6),
			.sliding7(sliding7),
			.sliding8(sliding8)
		);
							
	core_sobel #(.WordSize(16))
		Sobel(
			.sliding0(sliding0),
			.sliding1(sliding1),
			.sliding2(sliding2),
			.sliding3(sliding3),
			.sliding5(sliding5),
			.sliding6(sliding6),
			.sliding7(sliding7),
			.sliding8(sliding8),
			.outputPixel(outputPixel)
		);
		
endmodule
