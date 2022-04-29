
module tb_flash_led();
	reg        		sys_clock;
	reg        		sys_rst_n;

	wire  [3:0]    	led_out  ;

initial
	begin
		sys_clock <= 1'b1;
		sys_rst_n <= 1'b0;

		#20
		sys_rst_n <= 1'b1;
	end

always #10 sys_clock = ~sys_clock;


flash_led
#(
	.CNT_MAX(25'd24)
)
flash_led_inst
(
	. sys_clock(sys_clock),
	. sys_rst_n(sys_rst_n),
	
	.led_out    (led_out)
);
endmodule
