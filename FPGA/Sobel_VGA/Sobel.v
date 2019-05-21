`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module sobel(
              input clock,
				  input reset,
              input [15:0] inputPixel,
              output reg [15:0] outputPixel,
				  input ENABLE,
				  input area
				  );
				  
   //reg [15:0] outputPixel;
	parameter WORD_SIZE=16;
   parameter BUFFER_SIZE=3;
   parameter ROW_SIZE = 180;
	
	//reg reset = 0;
	reg [17:0] gx1, gx2, gy1, gy2;
	reg [17:0] gx, gy;
	reg [18:0] g;
	
  wire [15:0] sliding0;
  wire [15:0] sliding1;
  wire [15:0] sliding2;
  wire [15:0] sliding3;
  wire [15:0] sliding4;
  wire [15:0] sliding5;
  wire [15:0] sliding6;
  wire [15:0] sliding7;
  wire [15:0] sliding8;



  sliding_window my_window(
	         .clock(CLK),
				.reset(1'b0),
	         .inputPixel(inputPixel),
            .sliding0(sliding0),
				.sliding1(sliding1),
				.sliding2(sliding2),
				.sliding3(sliding3),
				.sliding4(sliding4),
				.sliding5(sliding5),
				.sliding6(sliding6),
				.sliding7(sliding7),
				.sliding8(sliding8),
				.ENABLE(ENABLE)
				);
				
	always @(posedge CLK) begin
		if (ENABLE)	begin
			if (reset) begin
				gx1 <= 18'b0;
				gx2 <= 18'b0;
				gy1 <= 18'b0;
				gy2 <= 18'b0;
         end
			else begin
				gx1 <= sliding0 + sliding6 + (sliding3<<1);
				gx2 <= sliding2 + sliding8 + (sliding5<<1);
				gy1 <= sliding0 + sliding2 + (sliding1<<1);
				gy2 <= sliding6 + sliding8 + (sliding7<<1);
			end
		end
	end

   always @* begin
		if (ENABLE)	begin
			if (gx1 > gx2) begin
				gx <= gx1-gx2;
			end
			else begin 
				gx <= gx2 - gx1;
			end
			if (gy1 > gy2) begin
				gy <= gy1-gy2;
			end
			else begin
				gy <= gy2-gy1;
			end
		end
	end
	 
   always @* begin
		if (ENABLE)	begin
		g <= gy+gx; 
		end
	end
	
   always @(posedge CLK) begin
		if (ENABLE)	begin
			if (area) begin
				if (reset) begin 
					outputPixel <= 16'b0;
				end
				else begin
					if (g[WORD_SIZE+2]) begin
						outputPixel <= 16'b1;
					end
					else begin
						outputPixel <= g[WORD_SIZE+1:2];
					end
				end
			end
			else begin
				outputPixel <= inputPixel;
			end
		end
	end
	
	endmodule