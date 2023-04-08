module top (
    input sys_clk,
    input sys_resetn,
    
////  video clocks
//    input clk_pixel,
//    input clk_5x_pixel,
//    input locked,

    //output logic [2:0] tmds,
    //output logic tmds_clock


    //for gameboy
    //input wire clk,
    //input wire reset, 
//	input wire[1:0]btn,   //按钮
//	input wire[1:0]sw,  //拨码开关
//	input wire str,       //游戏控制


    //for mcu
    output led,  
    inout [6:0] gpio,
    //inout led,
    input uart0_rxd,
	output uart0_txd,

    // output signals
    output       tmds_clk_n,
	output       tmds_clk_p,
	output [2:0] tmds_d_n,
	output [2:0] tmds_d_p
	
    //PSRAM Interface
//      init_calib,   //Initialized flag
//      O_psram_ck,
//      O_psram_ck_n,
//      O_psram_cs_n,
//      O_psram_reset_n,
//      IO_psram_dq,
//      IO_psram_rwds



);


//    PSRAM
//    output init_calib;
//    output [1:0] O_psram_ck;
//    output [1:0] O_psram_ck_n;
//    output [1:0] O_psram_cs_n;
//    output [1:0] O_psram_reset_n;
//    inout [15:0] IO_psram_dq;
//    inout [1:0] IO_psram_rwds;

//logic [2:0] tmds;
//logic tmds_clock;

// HDMI domain clocks
logic[2:0] tmds;
wire clk_pixel;  // 720p pixel clock: 74.25 Mhz
wire clk_pixel_x5;  // 5x pixel clock: 371.25 Mhz
wire pll_lock;

//logic reset;




wire master_hclk;
wire master_hrst;
wire master_hsel;
wire [31:0] master_haddr;
wire [1:0] master_htrans;
wire master_hwrite;
wire [2:0] master_hsize;
wire [2:0] master_hburst;
wire [3:0] master_hprot;
wire [1:0] master_hmemattr;
wire master_hexreq;
wire [3:0] master_hmaster;
wire [31:0] master_hwdata;
wire master_hmastlock;
wire master_hreadymux;
wire master_hauser;
wire [3:0] master_hwuser;
wire [31:0] master_hrdata;
wire master_hreadyout;
wire master_hresp;

wire mclk ;             //mcu clock = 50MHz
//wire psram_memory_clk;  //psram memory clock = 100MHz
//wire psram_base_clk;    //psram base clock = 50MHz

//for game_boy
wire[1:0]btn ;//= 2'b11;   //按钮
wire[1:0]sw ;//= 2'b11;  //拨码开关
wire str ;// = 1'b0;       //游戏控制
wire game_start;             //GameUI flag 


//// 720p, 371.25 = 27 * 55 / 4, 371.25/5 = 74.25 (720p pixel clock)
//// 480p, 159 = 27 * 53 / 9, 159/5 = 31.8 
//https://juj.github.io/gowin_fpga_code_generators/pll_calculator.html
Gowin_PLLVR u_pll(
    .clkout(clk_pixel_x5), //output clkout
    .lock(pll_lock), //output lock
    .clkin(sys_clk) //input clkin
);

wire game_clk;
Gowin_PLLVR_Game u_pllvr_game(      //for mcu 78Mhz
    .clkout(game_clk), //output clkout
    .clkin(sys_clk) //input clkin
);

Gowin_CLKDIV u_div_5(
        .clkout(clk_pixel), //output clkout
        .hclkin(clk_pixel_x5), //input hclkin
        .resetn(sys_resetn & pll_lock) //input resetn
);



//reg [32:0] cnt_clk;     
//assign led = (cnt_clk < 26'd12_500_000) ? 1'b1 : 1'b0;
//always @ (posedge clk_pixel or negedge sys_resetn) begin
//    if(!sys_resetn)                  
//        cnt_clk <=26'd0;
//    else if(cnt_clk < 26'd25_000_000)
//        cnt_clk <= cnt_clk + 1'b1;    
//    else
//        cnt_clk <= 26'd0;     
//end

//Gowin_PLLVR_empu u_Gowin_PLLVR (
//    .clkout(psram_memory_clk),  //psram_memory_clk 100MHz
//    .clkoutp(psram_base_clk),   //psram_base_clk 50MHz
//    .clkoutd(mclk),             //mcu clock 50MHz
//    .clkin(sys_clk)             //input clkin
//);



//AHB PSRAM instantiation
//PSRAM Memory Interface
//Memory Clock = 100MHz
//Gowin_AHB_PSRAM_Top u_Gowin_AHB_PSRAM_Top (
//  .AHB_HRDATA(master_hrdata),
//  .AHB_HREADY(master_hreadyout),
//  .AHB_HRESP(master_hresp),
//  .AHB_HTRANS(master_htrans),
//  .AHB_HBURST(master_hburst),
//  .AHB_HPROT(master_hprot),
//  .AHB_HSIZE(master_hsize),
//  .AHB_HWRITE(master_hwrite),
//  .AHB_HMASTLOCK(master_hmastlock),
//  .AHB_HMASTER(master_hmaster),
//  .AHB_HADDR(master_haddr),
//  .AHB_HWDATA(master_hwdata),
//  .AHB_HSEL(master_hsel),
//  .AHB_HCLK(master_hclk),
//  .AHB_HRESETn(master_hrst),
//  .psram_base_clk(psram_base_clk),     //50MHz
//  .psram_memory_clk(psram_memory_clk), //100MHz
//  .led_init(init_calib),
//  .O_psram_ck(O_psram_ck),
//  .O_psram_ck_n(O_psram_ck_n),
//  .O_psram_cs_n(O_psram_cs_n),
//  .O_psram_reset_n(O_psram_reset_n),
//  .IO_psram_dq(IO_psram_dq),
//  .IO_psram_rwds(IO_psram_rwds)
//);

Gowin_AHB_Multiple u_ahb_multiple
(
	.AHB_HRDATA(master_hrdata),
	.AHB_HREADY(master_hreadyout),//ready signal, slave to MCU master, 1'b1
	.AHB_HRESP(master_hresp),//respone signal, slave to MCU master
	.AHB_HTRANS(master_htrans),
	.AHB_HBURST(master_hburst),
	.AHB_HPROT(master_hprot),
	.AHB_HSIZE(master_hsize),
	.AHB_HWRITE(master_hwrite),
	.AHB_HMASTLOCK(master_hmastlock),
	.AHB_HMASTER(master_hmaster),
	.AHB_HADDR(master_haddr[11:0]),
	.AHB_HWDATA(master_hwdata),
	.AHB_HSEL(master_hsel),
	.AHB_HCLK(master_hclk),
	.AHB_HRESETn(master_hrst),
    .mcu_btn(btn),
    .mcu_sw(sw),
    .mcu_str(str),
    .mcu_img(game_start),
    .led(led)
);



Gowin_EMPU_Top empu_u(
    .sys_clk(game_clk), //input sys_clk
    .gpio(gpio), //inout [15:0] gpio
    .uart0_rxd(uart0_rxd), //input uart0_rxd
    .uart0_txd(uart0_txd), //output uart0_txd
     // ----AHB2 Master----//
    .master_hclk(master_hclk),
    .master_hrst(master_hrst),
    .master_hsel(master_hsel),
    .master_haddr(master_haddr),
    .master_htrans(master_htrans),
    .master_hwrite(master_hwrite),
    .master_hsize(master_hsize),
    .master_hburst(master_hburst),
    .master_hprot(master_hprot),
    .master_hmemattr(master_hmemattr),
    .master_hexreq(master_hexreq),
    .master_hmaster(master_hmaster),
    .master_hwdata(master_hwdata),
    .master_hmastlock(master_hmastlock),
    .master_hreadymux(master_hreadymux),
    .master_hauser(master_hauser),
    .master_hwuser(master_hwuser),
    .master_hrdata(master_hrdata),
    .master_hreadyout(master_hreadyout),
    .master_hresp(master_hresp),
    .master_hexresp(1'b0),
    .master_hruser(3'b000),
    .reset_n(sys_resetn) //input reset_n
);


/********************************Test CLK Start****************************************/
         
//reg [32:0] cnt_pixel;  
//reg [32:0] cnt_pixel5 = 0;              


//assign led[1] = (cnt_pixel < 26'd500) ? 1'b1 : 1'b0;
//assign led[2] = (cnt_pixel5 < 26'd500) ? 1'b0 : 1'b1;



//always @ (posedge clk_pixel or negedge sys_resetn) begin
//    if(!sys_resetn)                  
//        cnt_pixel <=26'd0;
//    else if(cnt_pixel < 26'd1000)
//        cnt_pixel <= cnt_pixel + 1'b1;      
//    else
//        cnt_pixel <= 26'd0;           
//end


//always @ (posedge clk_pixel_x5) begin
//    if(cnt_pixel5 < 26'd1000)
//        cnt_pixel5 <= cnt_pixel5 + 1'b1;      
//    else
//        cnt_pixel5 <= 26'd0;
//end
/********************************Test CLK End****************************************/

// audio stuff
//logic [10:0] audio_divider;
logic clk_audio;

//localparam AUDIO_RATE=48000;
//localparam CLKFRQ = 74250;

//always_ff@(posedge clk_pixel) 
//begin
//    if (audio_divider != CLKFRQ * 1000 / AUDIO_RATE / 2 - 11'd1) 
//        audio_divider++; //generated from clk_pixel 27.0000MHz/281=48042,70Hz ; 27.0000MHz/306=44117,64Hz
//    else begin 
//        clk_audio <= ~clk_audio; 
//        audio_divider <= 0; 
//    end
//end

logic [15:0] audio_sample_word [1:0]; //= '{16'haaaa, 16'haaaa};

//Audio Test Data
//always @(posedge clk_audio)
 //audio_sample_word <= {16'haaaa,16'haaaa};
// audio_sample_word <= {audio_sample_word[1] + 16'h1111, audio_sample_word[0] - 16'h1111};

/********************************Test CLK Start****************************************/
//reg [32:0] cnt_audio_clk;  

//assign led[3] = (cnt_audio_clk == 26'd0) ? 1'b0 : 1'b1;


//always @ (posedge clk_audio or negedge sys_resetn) begin
//    if(!sys_resetn)                  
//        cnt_audio_clk <=26'd0;
//    else if(cnt_audio_clk == 26'd0)
//        cnt_audio_clk <= cnt_audio_clk + 1'b1;    
//    else
//        cnt_audio_clk <= 26'd0;     
//end
/********************************Test CLK End****************************************/

logic [9:0] cx, cy, screen_start_x, screen_start_y, frame_width, frame_height, screen_width, screen_height;

logic [23:0] rgb = 24'hff0000;   //24'hffffff;   // R G B


//output wire [1:0]LED,     //显示游戏分数
//wire hsync, vsync; //VGA信号



//game_graph_top u_game_graph_top (
//    .clk(clk_pixel),          //25Mhz
//    .reset(!sys_resetn), 
//    .btn(btn), 
//    .sw(sw), 
//    .str(str), 
//    .hsync(hsync), 
//    .vsync(vsync), 
//    .rgb(game_rgb),
//    .hdmi_pix_x(cx),
//    .hdmi_pix_y(cy),
//    .led(led)
//);



wire graph_on; 
wire [2:0] menu_rgb;       //颜色
wire [2:0] game_rgb;       //颜色
reg [2:0] final_rgb;       //颜色
reg[14 : 0] sramAddress;


localparam FRAMEBUFFER_DEPTH = 160 * 120;
//reg[$clog2(FRAMEBUFFER_DEPTH) - 1 : 0] sramAddress;

//    Gowin_SP u_sp_img(
//        .dout(game_rgb), //output [2:0] dout
//        .clk(clk_pixel), //input clk
//        .oce(oce_i), //input oce
//        .ce(1'b1), //input ce
//        .reset(1'b0), //input reset
//        .wre(1'b0), //input wre
//        .ad(sramAddress) //input [14:0] ad
//        .din(game_rgb) //input [2:0] din
//    );
    Gowin_pROM u_prom_img(
        .dout(menu_rgb), //output [2:0] dout
        .clk(clk_pixel), //input clk
        .ce(~game_start), //input ce
        .oce(1'b0), //input oce
        .reset(~sys_resetn), //input reset
        .ad(sramAddress) //input [14:0] ad
    );


    game_process2 graph_unit(.clk(clk_pixel), .enable(game_start),.reset(sys_resetn&game_start),.pix_x(cx), .pix_y(cy), .btn(btn),.sw(sw),.str(str),.graph_on(graph_on), .graph_rgb(game_rgb));

reg[1:0] hCycleCount;
reg[1:0] vCycleCount;


//Video Test Pattern
// Border test (left = red, top = green, right = blue, bottom = blue, fill = black)
always @(posedge clk_pixel )
begin
//  rgb <= {cx == 0 ? ~8'd0 : 8'd0, cy == 0 ? ~8'd0 : 8'd0, cx == screen_width - 1'd1 || cy == screen_width - 1'd1 ? ~8'd0 : 8'd0};

/*
    if(cx == 12'd0 || cx == 12'd639)
        rgb = 24'hffffff;
    else if(cy == 12'd0 || cy == 12'd479)
        rgb = 24'hffffff;
    else
        rgb = 24'h000000;
*/

// sramAddress <= ((cx == 12'd0 && cy == 12'd0) || (cx == 12'd639 && cy == 12'd479)) ? 0 : ((cx > 12'd159 || cy > 12'd119) ? sramAddress : sramAddress + 1 );

   if((cx == 12'd0 && cy == 12'd0) || (cx > 12'd639 && cy > 12'd479)) begin
        sramAddress <= 0;
        hCycleCount <= 0;
        vCycleCount <= 0;
   end
   else if(cx < 12'd640 && cy < 12'd480) begin
        if(vCycleCount != 4'd3 && cx != 12'd639) begin
            vCycleCount <= vCycleCount + 1'b1;
        end
        if(vCycleCount == 4'd3 && cx != 12'd639) begin        //列重复4次完成
            vCycleCount <= 0;
            sramAddress <= sramAddress + 1'b1;
        end
        if(cx == 12'd639 && hCycleCount != 4'd3 )begin     //列重复到达一行末尾 但下一行仍需重复
            vCycleCount <= 0;
            hCycleCount <= hCycleCount + 1'b1;
            sramAddress <= sramAddress - 12'd159;  
        end
        if(cx == 12'd639 && hCycleCount == 4'd3 ) begin     //行列终点 下一行无需重复
            vCycleCount <= 0;
            hCycleCount <= 0;
            sramAddress <= sramAddress + 1'b1;
        end 
   end

    if(game_start) 
        final_rgb <= game_rgb;
    else 
        final_rgb <= menu_rgb;
    case(final_rgb)
        3'b111:
            rgb = 24'hffffff;
        3'b110:
            rgb = 24'hffff00;
        3'b101:
            rgb = 24'hff00ff;
        3'b100:
            rgb = 24'hff0000;
        3'b011:
            rgb = 24'h00ffff;
        3'b010:
            rgb = 24'h00ff00;
        3'b001:
            rgb = 24'h0000ff;
        3'b000:
            rgb = 24'h000000;
    endcase
end

// 640x480 @ 59.94Hz
hdmi #(.VIDEO_ID_CODE(1), .VIDEO_REFRESH_RATE(59.94), .AUDIO_RATE(48000), .AUDIO_BIT_WIDTH(16)) hdmi(
  .clk_pixel_x5(clk_pixel_x5),
  .clk_pixel(clk_pixel),
  .clk_audio(clk_audio),
  .reset(~sys_resetn),
  .rgb(rgb),
  .audio_sample_word(audio_sample_word),
  .tmds(tmds),
  .tmds_clock(tmds_clock),
  .cx(cx),
  .cy(cy),
  .frame_width(frame_width),
  .frame_height(frame_height),
   .screen_width(screen_width),
   .screen_height(screen_height)
);


    // Gowin LVDS output buffer
    ELVDS_OBUF tmds_bufds [3:0] (
        .I({clk_pixel, tmds}),
        .O({tmds_clk_p, tmds_d_p}),
        .OB({tmds_clk_n, tmds_d_n})
    );

endmodule
