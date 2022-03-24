module FIR_filter (input clk, input reset, input [15:0] input_sample, output reg [15:0] output_sample);

	parameter N = 19;

	reg [15:0] delay[N-1: 0];
	wire signed [15:0] sum [N-1:0];
	reg signed [15:0] finalsum;

	reg signed [15:0] coeff[18:0];
	
	integer x;

	always @(*)
	begin
		coeff[0]  = -1;
		coeff[1]  = -3779;
		coeff[2]  = -1;
		coeff[3]  = 2886;
		coeff[4]  = 0;
		coeff[5]  = -3574;
		coeff[6]  = 1;
		coeff[7]  = 4042;
		coeff[8]  = 1;
		coeff[9]  = 28562;
		coeff[10] = 1;
		coeff[11] = 4042;
		coeff[12] = 1;
		coeff[13] = -3574;
		coeff[14] = 0;
		coeff[15] = 2886;
		coeff[16] = -1;
		coeff[17] = -3779;
		coeff[18] = -1;
	end

	generate 
	genvar i;

	for (i=0; i<N; i=i+1) begin: mult1p
		multiplier mult1p(.dataa(coeff[i]), .datab(delay[i]), .result(sum[i]));
	end
	
	endgenerate

	always @(posedge clk or posedge reset) begin

		if(reset)begin			
			output_sample = 0;
			for (x = 0; x < N; x = x + 1) begin
				delay[x] = 0;
			end
		end
		
		else begin
			for (x = N - 1; x > 0; x = x - 1) begin
				delay[x] = delay[x-1];
			end
			
			delay[0] = input_sample;
		end
		
		finalsum = 0;
		
		for (x = 0; x < N; x = x + 1) begin
			finalsum = finalsum + sum[x];
		end
		
		output_sample = finalsum;
	end

endmodule
