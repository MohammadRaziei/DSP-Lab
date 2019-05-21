`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module VGA(
    input CLK,
	 output REFRESH,
    input [15:0] COLOUR_IN,
    output reg [15:0] COLOUR_OUT,
    output [9:0] ADDRH,
    output [8:0] ADDRV,
    output reg HS,
    output reg VS,
	 input DOWNCOUNTER
    );
	
	wire [9:0] VertCounter;
	wire [9:0] HorzCounter;
	wire EndHorzTrigger;

	initial begin
		HS = 0;
		VS = 0;
		COLOUR_OUT = 0;
	end
	

	parameter HorzTimeToPulseWidthEnd	= 10'd96;
	parameter HorzTimeToBackPorchEnd		= 10'd144;
	parameter HorzTimeToDisplayTimeEnd	= 10'd784;
	parameter HorzTimeToFrontPorchEnd	= 10'd800;
	
	parameter VertTimeToPulseWidthEnd	= 10'd2;
	parameter VertTimeToBackPorchEnd		= 10'd31;
	parameter VertTimeToDisplayTimeEnd	= 10'd511;
	parameter VertTimeToFrontPorchEnd	= 10'd521;
	
	
	Counter # (
				.MaxValue(HorzTimeToFrontPorchEnd-1),
				.Size(10)
			)
	TimeCounterHorizontal(
				.CLK(CLK),
				.ENABLE(DOWNCOUNTER),
				.TRIGGER_OUT(EndHorzTrigger),
				.TIME_COUNT(HorzCounter)
			);		


		
	Counter # (
				.MaxValue(VertTimeToFrontPorchEnd-1),
				.Size(10)
			)			
	TimeCounterVertical(
				.CLK(CLK),
				.ENABLE(EndHorzTrigger),
				.TRIGGER_OUT(REFRESH),
				.TIME_COUNT(VertCounter)
			);	
					

	always @(posedge CLK) begin
		if ((HorzCounter < HorzTimeToPulseWidthEnd-1) || (HorzCounter == HorzTimeToFrontPorchEnd-1))
			HS <= 1'b0;
		else 
			HS <= 1'b1;
	end


	always @(posedge CLK) begin
		if (EndHorzTrigger)begin
			if ((VertCounter < VertTimeToPulseWidthEnd-1) || (VertCounter == VertTimeToFrontPorchEnd-1))
				VS <= 1'b0;
			else 
				VS <= 1'b1;
		end
	end
	

	always @(posedge CLK) begin
		if (DOWNCOUNTER) begin
			if (  (HorzCounter > HorzTimeToBackPorchEnd-2)
				&& (HorzCounter <= HorzTimeToDisplayTimeEnd-2)
				&& (VertCounter > VertTimeToBackPorchEnd-1)
				&& (VertCounter <= VertTimeToDisplayTimeEnd-1) )
				COLOUR_OUT <= COLOUR_IN;
			else
				COLOUR_OUT <= 0;
		end
	end


	PixCounter # (
					.AddressSize(10),
					.TimeToBackPorchEnd (HorzTimeToBackPorchEnd-1),
					.TimeToDisplayTimeEnd (HorzTimeToDisplayTimeEnd-1)
					)
				HorzPix(
					.CLK(CLK),
					.SYNCH_TIME(HorzCounter),
					.ENABLE(DOWNCOUNTER),
					.PIXCOUNT(ADDRH)
					);
	

	PixCounter # (
					.AddressSize(9),
					.TimeToBackPorchEnd (VertTimeToBackPorchEnd-1),
					.TimeToDisplayTimeEnd (VertTimeToDisplayTimeEnd-1)
					)
				
				VertPix(
					.CLK(CLK),
					.SYNCH_TIME(VertCounter),
					.ENABLE(EndHorzTrigger),
					.PIXCOUNT(ADDRV)
					);
endmodule