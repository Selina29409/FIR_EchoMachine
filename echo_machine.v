module echo_machine(input sample_clock, input [15:0] input_sample, output reg [15:0] output_sample);

	wire [15:0] delay, divide_delay, feedback;
	
	assign feedback = output_sample;
	assign divide_delay = {delay[15], delay[15], delay[15:2]};
	
	shiftregister Echo(.clock(sample_clock), .shiftin(feedback), .shiftout(delay));
	
	always @(posedge sample_clock)
	begin
		output_sample = divide_delay + input_sample;
	end
endmodule 