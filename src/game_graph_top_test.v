`timescale 1ns / 1ps


module game_graph_top_test;

	// Inputs
	reg clk;
	reg reset;
	reg [1:0] btn;
	reg [1:0] sw;
	reg str;

	// Outputs
	wire hsync;
	wire vsync;
	wire [2:0] rgb;

	// Instantiate the Unit Under Test (UUT)
	game_graph_top uut (
		.clk(clk), 
		.reset(reset), 
		.btn(btn), 
		.sw(sw), 
		.str(str), 
		.hsync(hsync), 
		.vsync(vsync), 
		.rgb(rgb)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		btn = 0;
		sw = 0;
		str = 1;

		// Wait 100 ns for global reset to finish
		#100;
      reset = 1;
	   #20;
		reset = 0;
		btn[0] = 1;
		#10;
		btn[0] = 0;
		#10;
		btn[1] = 1;
		#10;
		btn[0] = 0;
		// Add stimulus here

	end
	always@*
	begin
	#10;
	clk<=~clk;
	end
      
endmodule

