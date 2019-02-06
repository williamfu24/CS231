
module nios_system (
	clk_clk,
	hexa_export,
	hexb_export,
	leds_export,
	reset_reset_n,
	switches_export);	

	input		clk_clk;
	output	[7:0]	hexa_export;
	output	[7:0]	hexb_export;
	output	[7:0]	leds_export;
	input		reset_reset_n;
	input	[7:0]	switches_export;
endmodule
