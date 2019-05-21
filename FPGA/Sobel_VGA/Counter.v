`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module Counter(
	CLK,
	ENABLE,
	TRIGGER_OUT,
	TIME_COUNT
    );
	
	parameter MaxValue  = 799;
	parameter Size = 10;
	parameter InitialValue = MaxValue;
	
	input CLK;
	input ENABLE;
	output reg TRIGGER_OUT;
	output reg [Size - 1: 0] TIME_COUNT;
	
	initial begin
		TRIGGER_OUT = 0;
		TIME_COUNT = InitialValue;
	end
	
	always@(posedge CLK) begin
		if (ENABLE) begin
			if (TIME_COUNT == MaxValue)
				TIME_COUNT <= 0;
			else
				TIME_COUNT <= TIME_COUNT + 1;
		end
	end

	always @(posedge CLK) begin
		if (ENABLE && (TIME_COUNT == MaxValue-1))
			TRIGGER_OUT <= 1;	
		else
			TRIGGER_OUT <= 0;
	end
endmodule