module dsp_subsystem (input sample_clock,  input reset, input [1:0] selector, input [15:0] input_sample, output reg [15:0] output_sample);

	wire [15:0] filter;
	wire [15:0] echo;
	
	FIR_filter (.clk(sample_clock),.reset(reset),.input_sample(input_sample),.output_sample(filter));
		
	echo_machine (.sample_clock(sample_clock),.input_sample(input_sample),.output_sample(echo));
	
	
	always @(posedge sample_clock) begin
	
		case(selector) 
			2'b00: output_sample <= input_sample;
			
			2'b01: output_sample <= filter;
			
			2'b10: output_sample <= echo;
			
		endcase
	end


endmodule
