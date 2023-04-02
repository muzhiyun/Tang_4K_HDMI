module vga_sync
(
input wire clk, reset,
output wire hsync, vsync, video_on, p_tick,
output wire [9:0] pixel_x, pixel_y
);
// constant declaration
// VGA 640_by_480 sync parameters
parameter HD = 640; // horizontal display area
parameter HF = 48 ; // h.front(left) border
parameter HB = 16 ; // h.back(right) border
parameter HR = 96 ; // h.retrace
parameter VD = 480; // vertical display area
parameter VF = 10; // v.front(top) border
parameter VB = 33; // v.back(bottom) border
parameter VR = 2; // v.retrace
//HD：每行像素数。
//HF：左边的黑边框宽度。
//HB：右边的黑边框宽度。
//HR：每行像素的扫描线数。
//VD：每列像素数。
//VF：上面的黑边框宽度。
//VB：下面的黑边框宽度。
//VR：每列像素的扫描线数。

// mod_2 counter
reg mod2_reg;
wire mod2_next ;
// sync counters
reg [9:0] h_count_reg, h_count_next;
reg [9:0] v_count_reg , v_count_next ;
// output buffer
reg v_sync_reg , h_sync_reg;
wire v_sync_next , h_sync_next;
// status signal
wire h_end, v_end, pixel_tick;

// body
// registers
always @ ( posedge clk , negedge reset)
  if (reset)
    begin
      mod2_reg <= 1'b0;
      v_count_reg <= 0;
      h_count_reg <= 0;
      v_sync_reg <= 1'b0;
      h_sync_reg <= 1'b0;
    end
  else
    begin
      mod2_reg <= mod2_next ;
      v_count_reg <= v_count_next;
      h_count_reg <= h_count_next;
      v_sync_reg <= v_sync_next ;
      h_sync_reg <= h_sync_next ;
    end
// mod_2 circuit to generate 25MHz enable tick
assign mod2_next = ~mod2_reg;
assign pixel_tick = mod2_reg;
// status signals
// end of horizontal counter (799)
assign h_end = (h_count_reg==(HD+HF+HB+HR-1)) ;
// end of vertical counter (524)
assign v_end = (v_count_reg==(VD+VF+VB+VR-1)) ;

// next-state logic of mod-800 horizontal sync counter
always @*
  if (pixel_tick) // 25 MHz pulse
    if (h_end)
      h_count_next = 0 ;
    else
      h_count_next = h_count_reg + 1;
  else
    h_count_next = h_count_reg;
// next-state logic of mod-525 vertical sync counter
always @*
  if (pixel_tick & h_end)
    if (v_end)
      v_count_next = 0;
    else
      v_count_next = v_count_reg + 1;
  else
    v_count_next = v_count_reg;

// horizontal and vertical sync, buffered to avoid glitch
// h_svnc_next asserted between 656 and 751
assign h_sync_next = (h_count_reg>=HR);
// v_sync_next asserted between 490 and 491
assign v_sync_next = (v_count_reg >= VR);
// video on/off
assign video_on = (h_count_reg>=HF+HR) && (v_count_reg>=VB+VR)&&(h_count_reg<HF+HR+HD) && (v_count_reg<VD+VB+VR);
// output
assign hsync = h_sync_reg;
assign vsync = v_sync_reg;
assign pixel_x = h_count_reg-HF-HR;
assign pixel_y = v_count_reg-VB-VR;
assign p_tick = pixel_tick;
endmodule
