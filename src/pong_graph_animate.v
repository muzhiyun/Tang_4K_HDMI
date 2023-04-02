`timescale 1ns / 1ps

module pong_graph_animate(
			input clk, reset,
			input video_on,
			input wire [1:0]btn,
			input [9:0]pix_x, pix_y,
			output reg [2:0] graph_rgb
    );
localparam MAX_X = 640;
localparam MAX_Y = 480;
wire refr_tick;
localparam WALL_X_L = 32;
localparam WALL_X_R = 35;
localparam BAR_X_L = 600;
localparam BAR_X_R = 603;
wire [9:0]bar_y_t, bar_y_b;
localparam BAR_Y_SIZE = 72;
reg[9:0]bar_y_reg, bar_y_next;
localparam BAR_V = 4;
localparam BALL_SIZE = 8;
//球的左右边界,矩形球
wire [9:0]ball_x_l, ball_x_r;
//球的上下边界
wire [9:0]ball_y_t, ball_y_b;
//寄存器存储球的左侧与上册
reg [9:0] ball_x_reg, ball_y_reg;
wire ball_x_next, ball_y_next;
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
	3'h0:rom_data = 8'b00111100;//  ****
	3'h1:rom_data = 8'b01111110;// ******
	3'h2:rom_data = 8'b11111111;//********
	3'h3:rom_data = 8'b11111111;//********
	3'h4:rom_data = 8'b11111111;//********
	3'h5:rom_data = 8'b11111111;//********
	3'h6:rom_data = 8'b01111110;// ******
	3'h7:rom_data = 8'b00111100;//  ****
endcase


endmodule
