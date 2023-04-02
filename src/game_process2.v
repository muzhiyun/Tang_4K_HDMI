module game_process2(
			input clk, reset,
			input wire [1:0]btn,
			input wire [1:0]sw,
			input wire str,
			input [9:0]pix_x, pix_y,
			output wire graph_on,
			output reg [2:0] graph_rgb
			//output wire [1:0]LED
    );
//常数定义和信号量声明
//x,y坐标范围是（0,0）到（639,479）
parameter MAX_X = 640;
parameter MAX_Y = 480;
wire refr_tick;
//砖块的大小定义
parameter block0_x = 170;
parameter block1_x = 290;
parameter block2_x = 410;
parameter block_y = 180;
parameter width = 40;
parameter length = 60;
wire [2:0]block_on;
//挡板定义
parameter bar_x_size1 = 50;
parameter bar_x_size2 = 40;
parameter bar_x_size3 = 30;
parameter bar_y_b = 357;
parameter bar_y_t = 353;//上下固定边界
reg [9:0]bar_x_size;
wire bar_on;
wire [9:0]bar_x_l, bar_x_r;//左右边界
//寄存器存储挡板位置
reg[9:0]bar_x_reg, bar_x_next;
//挡板的运动速度
parameter bar_v = 2;
//ball
parameter ball_size = 8;
//球的左右边界,矩形球
wire [9:0]ball_x_l, ball_x_r;
//球的上下边界
wire [9:0]ball_y_t, ball_y_b;
//寄存器存储球的左侧与上册
reg [9:0] ball_x_reg, ball_y_reg;
wire[9:0] ball_x_next, ball_y_next;
//圆形球定义
wire [2:0]rom_addr, rom_col;
reg [7:0]rom_data;
wire rom_bit;
//输出
wire sq_ball_on;
wire rd_ball_on;

//状态机
reg[2:0]move_state;
parameter[2:0]
s0 = 3'b000,//初始状态
s1 = 3'b001,//小球向左上方跑
s2 = 3'b010,//小球向右上方跑
s3 = 3'b011,//小球向右下方跑
s4 = 3'b100,//小球向左下方跑
s7 = 3'b111;//结束状态
//圆形球图像映射
always@*
case(rom_addr)
	3'h0:rom_data = 8'b00111100;
	3'h1:rom_data = 8'b01111110;
	3'h2:rom_data = 8'b11111111;
	3'h3:rom_data = 8'b11111111;
	3'h4:rom_data = 8'b11111111;
	3'h5:rom_data = 8'b11111111;
	3'h6:rom_data = 8'b01111110;
	3'h7:rom_data = 8'b00111100;
endcase
//寄存器存储球的速度
reg [9:0] x_v_reg, x_v_next;
reg [9:0] y_v_reg, y_v_next;
reg str_run;
localparam ball_v_10 = -1;
localparam ball_v_11 = 1;

reg[9:0] ball_v_0,ball_v_1;

assign refr_tick = (pix_y == 481)&&(pix_x == 0);
//砖块显示（判断一个像素点是否在一个矩形块中）
assign block_on[0] = (block0_x <= pix_x)&&(pix_x <= block0_x + length)&&(block_y+width >= pix_y)&&(pix_y >= block_y);
assign block_on[1] = (block1_x <= pix_x)&&(pix_x <= block1_x + length)&&(block_y+width >= pix_y)&&(pix_y >= block_y);
assign block_on[2] = (block2_x <= pix_x)&&(pix_x <= block2_x + length)&&(block_y+width >= pix_y)&&(pix_y >= block_y);

//棒显示
assign  bar_x_l = bar_x_reg;
assign  bar_x_r = bar_x_l+bar_x_size-1;
assign bar_on = (bar_x_l <= pix_x)&&(pix_x<=bar_x_r)&&(bar_y_t<=pix_y)&&(pix_y<=bar_y_b);
reg [1:0] LED_reg;
//棒长短
always@*
case(sw)
	2'b00: begin ball_v_0 <= ball_v_10; ball_v_1 <= ball_v_11; bar_x_size <= bar_x_size1; LED_reg <= 2'b01;end
	2'b01: begin ball_v_0 <= ball_v_10; ball_v_1 <= ball_v_11; bar_x_size <= bar_x_size2; LED_reg <= 2'b10;end
	2'b10: begin ball_v_0 <= ball_v_10; ball_v_1 <= ball_v_11; bar_x_size <= bar_x_size3; LED_reg <= 2'b11;end
	2'b11: begin ball_v_0 <= ball_v_10; ball_v_1 <= ball_v_11; bar_x_size <= bar_x_size3; LED_reg <= 2'b11; end
endcase

//assign LED =LED_reg;

//棒在x轴方向上的运动
always@*
begin 
	bar_x_next = bar_x_reg;
	if(refr_tick)
		if(btn[0]&(bar_x_r <= (480 - bar_v)))
			bar_x_next = bar_x_reg + bar_v;
		else if(btn[1]&(bar_x_l >=160 + bar_v))
			bar_x_next = bar_x_reg - bar_v;
end

//显示矩形球
assign ball_x_l = ball_x_reg;
assign ball_y_t = ball_y_reg;
assign ball_x_r = ball_x_l + ball_size -1;
assign ball_y_b = ball_y_t + ball_size -1;
//球显示区域
assign sq_ball_on = (ball_x_l<=pix_x)&&(pix_x<=ball_x_r)&&(ball_y_t<=pix_y)&&(pix_y<=ball_y_b);
//映射当前像素到ROM地址空间
assign rom_addr = pix_y[2:0] - ball_y_t[2:0];
assign rom_col = pix_x[2:0] - ball_x_l[2:0];
assign rom_bit = rom_data[rom_col];
//球显示区域
assign rd_ball_on = sq_ball_on&rom_bit;
//球的颜色
//assign ball_rgb = 3'b100;
//球的新的位置
assign ball_x_next = (refr_tick)?ball_x_reg + x_v_reg : ball_x_reg;
assign ball_y_next = (refr_tick)?ball_y_reg + y_v_reg : ball_y_reg;

always@(posedge clk or negedge reset)
begin
	if(!reset)
		begin
		 bar_x_reg <= MAX_X/2 - bar_x_size/2;
		 ball_x_reg <= MAX_X/2 - ball_size/2 ;
		 ball_y_reg <= bar_y_t - ball_size;
		 x_v_reg <= 0;
		 y_v_reg <= 0;
		 str_run <= 0;
		end
	else
	begin
		bar_x_reg <= bar_x_next;
		ball_x_reg <= ball_x_next;
		ball_y_reg <= ball_y_next;
		x_v_reg <= x_v_next;
		y_v_reg <= y_v_next;
		str_run <= str;
	end
end
	
//球的运动（根据位置或撞击判断状态）
always@(posedge clk or negedge reset)
	begin
		if(!reset)
			begin
				move_state <= s0;
			end
		else 
			begin
				if(str_run)	begin
					case(move_state)
						s0:move_state <= s1;
						s1:
						begin
							if(ball_x_reg==160&&ball_y_reg==120)
								 move_state <= s3;
							else if(ball_y_reg == 120)
								move_state <= s4;
							else if(ball_x_reg == 160)
								move_state <= s2;
							else if(ball_y_reg == 220)
								begin
									if(ball_x_reg>=170&&ball_x_reg<=230)
										move_state <= s4;
									else if(ball_x_reg>=290&&ball_x_reg<=350)
										move_state <= s4;
									else if(ball_x_reg>=410&&ball_x_reg<=470)
										move_state <= s4;
									else 
										move_state <= move_state;
								end
							else if(ball_x_reg==230||ball_x_reg==350||ball_x_reg==470) 
								begin
									if(ball_y_reg>=180 && ball_y_reg<=220)
										move_state <= s2;
									else 
										move_state <= move_state;
								end
							else
								move_state <= move_state;
						end
						s2:
						begin
							if(ball_x_reg+ball_size==480&&ball_y_reg==120)
								 move_state <= s4;
							else if(ball_y_reg == 120)
								move_state <= s3;
							else if(ball_x_reg+ball_size == 480)
								move_state <= s1;
							else if(ball_y_reg == 220)
								begin
									if(ball_x_reg>=170&&ball_x_reg+ball_size<=230)
										move_state <= s3;
									else if(ball_x_reg>=290&&ball_x_reg+ball_size<=350)
										move_state <= s3;
									else if(ball_x_reg>=410&&ball_x_reg+ball_size<=470)
										move_state <= s3;
									else 
										move_state <= move_state;
								end
							else if(ball_x_reg+ball_size==170||ball_x_reg+ball_size==290||ball_x_reg+ball_size==410) 
								begin
									if(ball_y_reg>=180 && ball_y_reg+ball_size<=220)
										move_state <= s1;
									else 
										move_state <= move_state;
								end
							else
								move_state <= move_state;
						end
						s3:
						begin
							if(ball_x_reg+ball_size==480&&ball_y_reg+ball_size<=358)
								move_state <= s4;
							else if(ball_x_reg+ball_size==170||ball_x_reg+ball_size==290||ball_x_reg+ball_size==410) 
								begin
									if(ball_y_reg>=180 && ball_y_reg+ball_size<=220)
										move_state <= s4;
									else 
										move_state <= move_state;
								end
							else if(ball_y_reg+ball_size == 180) begin
								if(ball_x_reg>=170&&ball_x_reg+ball_size<=230)
									move_state <= s2;
								else if(ball_x_reg>=290&&ball_x_reg+ball_size<=350)
									move_state <= s2;
								else if(ball_x_reg>=410&&ball_x_reg+ball_size<=470)
									move_state <= s2;
								else 
									move_state<=move_state;
								end
							else if(ball_y_reg+ball_size == bar_y_t)
							begin
								if(ball_x_reg >= bar_x_l-ball_size/2&&ball_x_reg <= bar_x_r+ball_size/2)begin
									if(ball_x_reg <= bar_x_l+bar_x_size/2)
										move_state <= s2;
									else
										move_state <= s1;
									end
								else
									move_state <= s7;
							end
						end
						s4:
						begin
							if(ball_x_reg==160&&ball_y_reg+ball_size<=358)
								move_state <= s3;
							else if(ball_x_reg==230||ball_x_reg==350||ball_x_reg==470) 
								begin
									if(ball_y_reg>=180 && ball_y_reg<=220)
										move_state <= s3;
									else 
										move_state <= move_state;
								end
							else if(ball_y_reg+ball_size == 180) begin
								if(ball_x_reg>=170&&ball_x_reg+ball_size<=230)
									move_state <= s1;
								else if(ball_x_reg>=290&&ball_x_reg+ball_size<=350)
									move_state <= s1;
								else if(ball_x_reg>=410&&ball_x_reg+ball_size<=470)
									move_state <= s1;
								else 
									move_state<=move_state;
								end
							else if(ball_y_reg+ball_size == bar_y_t)
							begin
								if(ball_x_reg >= bar_x_l-ball_size/2&&ball_x_reg <= bar_x_r+ball_size/2)begin
									if(ball_x_reg <= bar_x_l+bar_x_size/2)
										move_state <= s1;
									else
										move_state <= s2;
									end
								else
									move_state <= s7;
							end
						end
						s7:
						begin
							move_state <= s7;
						end
						default:
							move_state <= s7;
						endcase
					end
				end
			end
							
			
		
//状态定义
always@*
	begin
		x_v_next = x_v_reg;
		y_v_next = y_v_reg;
	if(str_run) 
		case(move_state)
			s0:
				begin
					x_v_next = 0;
					y_v_next = 0;
				end
			s1:
				begin
					x_v_next = ball_v_0;
					y_v_next = ball_v_0;
				end
			s2:
				begin
					x_v_next = ball_v_1;
					y_v_next = ball_v_0;
				end
			s3:
				begin
					x_v_next = ball_v_1;
					y_v_next = ball_v_1;
				end
			s4:
				begin
					x_v_next = ball_v_0;
					y_v_next = ball_v_1;
				end
			s7:
				begin
					x_v_next = 0;
					y_v_next = 0;
				end
			default
				begin
					x_v_next = 0;
					y_v_next = 0;
				end
		endcase
	end
	
assign graph_on = block_on[0]||block_on[1]||block_on[2]||bar_on||rd_ball_on;
always@*
	begin 
		graph_rgb = 3'b000;
		if(graph_on)begin
			if(block_on[0]||block_on[1]||block_on[2])
			graph_rgb = 3'b011;
			else if(bar_on)
			graph_rgb = 3'b110;
			else if(rd_ball_on)
			graph_rgb = 3'b100;
			end
		end

endmodule
