module game_graph_top(
	input wire clk,
    input wire reset, 
	input wire[1:0]btn,   //按钮
	input wire[1:0]sw,  //拨码开关
	input wire str,       //游戏控制
	//output wire [1:0]LED,     //显示游戏分数
    output led,  
    output wire hsync, vsync,  //VGA信号
    output wire [2:0] rgb,       //颜色
    input [9:0] hdmi_pix_x, hdmi_pix_y
    );
wire [9:0] pixel_x, pixel_y;      //像素坐标
wire video_on, pixel_tick, graph_on;  //视频信号开关，像素时钟信号，是否绘制的信号
wire [2:0] graph_rgb;                //游戏颜色
reg [2:0] rgb_reg, rgb_next;         //像素颜色寄存器

///vga的同步
//vga_sync vsync_unit(.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync), .video_on(video_on), .p_tick(pixel_tick), .pixel_x(pixel_x), .pixel_y(pixel_y));

//游戏逻辑
game_process2 graph_unit(.clk(clk), .reset(reset),.pix_x(hdmi_pixel_x), .pix_y(hdmi_pixel_y), .btn(btn),.sw(sw),.str(str),.graph_on(graph_on), .graph_rgb(graph_rgb));


//reg [32:0] cnt_clk;     
//assign led = (cnt_clk < 26'd15_900_000) ? 1'b1 : 1'b0;
//always @ (posedge pixel_tick or negedge reset) begin
//    if(!reset)                  
//        cnt_clk <=26'd0;
//    else if(cnt_clk < 26'd31_800_000)
//        cnt_clk <= cnt_clk + 1'b1;    
//    else
//        cnt_clk <= 26'd0;     
//end

//更新rgb寄存器
always @(posedge clk, negedge reset)
    if (reset)
	begin
	    rgb_reg <= 3'b100;
	end 
	else 
	begin 
	    //if (pixel_tick)
		    rgb_reg <= rgb_next;
	end


always @*
//    if (~video_on)
//        rgb_next = 3'b010;
//    else begin
        if (graph_on)
            rgb_next = graph_rgb;
		else if(hdmi_pixel_x>=150&&hdmi_pixel_x<=160&&hdmi_pixel_y>=110&&hdmi_pixel_y<=370) //与运算得到x与y的范围
			rgb_next = 3'b111;
		else if(hdmi_pixel_x>=160&&hdmi_pixel_x<=480&&hdmi_pixel_y>=110&&hdmi_pixel_y<=120)
			rgb_next = 3'b111;
		else if(hdmi_pixel_x>=160&&hdmi_pixel_x<480&&hdmi_pixel_y>=360&&hdmi_pixel_y<=370)
			rgb_next = 3'b111;
		else if(hdmi_pixel_x>=480&&hdmi_pixel_x<490&&hdmi_pixel_y>=110&&hdmi_pixel_y<=370)
			rgb_next = 3'b111;        
		else
            rgb_next = 3'b001;    // background
//    end
// output
assign rgb = rgb_reg;
endmodule