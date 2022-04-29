module flash_led
#(
	parameter CNT_MAX = 25'd24_999_999
)
(
	input  wire  		sys_clock ,
	input  wire  		sys_rst_n ,
	
	output wire  [3:0] 	led_out
);

reg	[24:0]	cnt;
reg [3:0]   led_out_reg;
reg 		cnt_flag;
//cnt  计数器
always@(posedge sys_clock or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		cnt <= 1'b0;
	else if(cnt == CNT_MAX)
		cnt <= 1'b0;
	else
		cnt <= cnt + 1'b1;

//cnt标志位cnt_flag
always@(posedge sys_clock or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		cnt_flag <= 1'b0;
	else if(cnt == CNT_MAX - 1'b1)
		cnt_flag <= 1'b1;
	else
		cnt_flag <= 1'b0;

//led_out_reg输出标志位
always@(posedge sys_clock or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		led_out_reg <= 4'b0001;
	else if(led_out_reg == 4'b1000 && cnt_flag == 1'b1 )
		led_out_reg <= 4'b0001;
	else if(cnt_flag == 1'b1)
		led_out_reg <= led_out_reg << 1'b1;
	else
		led_out_reg <= led_out_reg;
		
assign led_out = ~led_out_reg;
endmodule