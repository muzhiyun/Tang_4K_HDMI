//Copyright (C)2014-2022 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//GOWIN Version: V1.9.8.10
//Part Number: GW1NSR-LV4CQN48PC6/I5
//Device: GW1NSR-4C
//Created Time: Thu Apr 06 23:10:34 2023

module Gowin_SP (dout, clk, oce, ce, reset, wre, ad, din);

output [2:0] dout;
input clk;
input oce;
input ce;
input reset;
input wre;
input [14:0] ad;
input [2:0] din;

wire [30:0] sp_inst_0_dout_w;
wire [0:0] sp_inst_0_dout;
wire [30:0] sp_inst_1_dout_w;
wire [1:1] sp_inst_1_dout;
wire [30:0] sp_inst_2_dout_w;
wire [2:2] sp_inst_2_dout;
wire [28:0] sp_inst_3_dout_w;
wire [2:0] sp_inst_3_dout;
wire dff_q_0;
wire ce_w;
wire gw_gnd;

assign ce_w = ~wre & ce;
assign gw_gnd = 1'b0;

SP sp_inst_0 (
    .DO({sp_inst_0_dout_w[30:0],sp_inst_0_dout[0]}),
    .CLK(clk),
    .OCE(oce),
    .CE(ce),
    .RESET(reset),
    .WRE(wre),
    .BLKSEL({gw_gnd,gw_gnd,ad[14]}),
    .AD(ad[13:0]),
    .DI({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,din[0]})
);

defparam sp_inst_0.READ_MODE = 1'b0;
defparam sp_inst_0.WRITE_MODE = 2'b00;
defparam sp_inst_0.BIT_WIDTH = 1;
defparam sp_inst_0.BLK_SEL = 3'b000;
defparam sp_inst_0.RESET_MODE = "SYNC";
defparam sp_inst_0.INIT_RAM_00 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_01 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_02 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_03 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_04 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_05 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_06 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_07 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_08 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_09 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_0A = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_0B = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_0C = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_0D = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_0E = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_0F = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_10 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_11 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_12 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_13 = 256'hFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFE0001FFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_14 = 256'hFFFFFFFFFFFFFFFE0000FFFFFFFFF07FFFFFFFFFFFFFFFFFFFFFFFFE0000FFFF;
defparam sp_inst_0.INIT_RAM_15 = 256'h0000FFFFFFFFF03FFFFFFFFFFFFFFFFFFFFFFFFE0000FFFFFFFFF07FFFFFFFFF;
defparam sp_inst_0.INIT_RAM_16 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFE0FFFEFFFFF01FFFFFFFFFFFFFFFFFFFFFFFFE;
defparam sp_inst_0.INIT_RAM_17 = 256'hC01F041FFFE0FFC0FFFFF001FFFFFFFFFFFFFFFFFFFFFFFFFFE0FFF8FFFFF007;
defparam sp_inst_0.INIT_RAM_18 = 256'hFFFFF041FFFF003FC018041F000F001FFFE0FE00FFFFF001FFFF807FF07C0C1F;
defparam sp_inst_0.INIT_RAM_19 = 256'h8000001E0003001F8000E000FFFFF061FFFE001F8000001F0007001FFFE0FC00;
defparam sp_inst_0.INIT_RAM_1A = 256'h80008000FFFFF07FFFF81E0F83C0701E0F83B01F80008000FFFFF079FFFC000F;
defparam sp_inst_0.INIT_RAM_1B = 256'hFFF83F0783E0F81E0FFFFC1F00000000FFFFF07FFFF83F0783E0F81E0FCFF81F;
defparam sp_inst_0.INIT_RAM_1C = 256'h001FFC1FFFC00000FFFFF07FFFF8000783E0FC1E00FFFC1F80000000FFFFF07F;
defparam sp_inst_0.INIT_RAM_1D = 256'hFFFFF07FFFF0000783E0FC1E0007FC1FD0000000FFFFF07FFFF0000783E0FC1E;
defparam sp_inst_0.INIT_RAM_1E = 256'h83E0FC1E0F83FC1F00000000FFFFF07FFFF8000783E0FC1E0E03FC1FC0000000;
defparam sp_inst_0.INIT_RAM_1F = 256'h00000000FFFFF07FFFFF3F0783E0FC1E0FC1FC1800000000FFFFF07FFFFFFF07;
defparam sp_inst_0.INIT_RAM_20 = 256'hFFF81C0F83E0FC1E0781FC1000000000FFFFF07FFFF83E0F83E0FC1E0FC1FC10;
defparam sp_inst_0.INIT_RAM_21 = 256'h0003E40000000000FFFFF07FFFFC001F83E0FC1E0003FC0000000000FFFFF07F;
defparam sp_inst_0.INIT_RAM_22 = 256'hFFFFF07FFFFF007F83E0FC1C1804000000000000FFFFF07FFFFE001F83E0FC1E;
defparam sp_inst_0.INIT_RAM_23 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFFFFFEFDFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_24 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_25 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_26 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_27 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_28 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_29 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_2A = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_2B = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_2C = 256'hFFFFF7FBFFFEFFDFFFFFFFFFF9F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_2D = 256'hF07C1C3FC01F0E1FFFE1FFFFFFFFF7E3FFFF7FBFEFBBE7BFBFEF76BFFFEDFFFF;
defparam sp_inst_0.INIT_RAM_2E = 256'hFFE1FFFFFFFFF003FFFFFFFFFFFFFFFFFFFFFFFFFFE1FFFFFFFFF0C3FFFFC0FF;
defparam sp_inst_0.INIT_RAM_2F = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFE1FFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_30 = 256'hFFFFFFFE0000FFFFFFFFF03FFFFFFFFFFFFFFFFFFFFFFFFE0001FFFFFFFFF01F;
defparam sp_inst_0.INIT_RAM_31 = 256'hFFFFF07FFFFFFFFFFFFFFFFFFFFFFFFE0000FFFFFFFFF07FFFFFFFFFFFFFFFFF;
defparam sp_inst_0.INIT_RAM_32 = 256'h0000000000000001FFFE0000FFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFE0000FFFF;
defparam sp_inst_0.INIT_RAM_33 = 256'h00000000000000000000000000000000000000000000000000000F4000000000;
defparam sp_inst_0.INIT_RAM_34 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_0.INIT_RAM_35 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_0.INIT_RAM_36 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_0.INIT_RAM_37 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_0.INIT_RAM_38 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_0.INIT_RAM_39 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_0.INIT_RAM_3A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_0.INIT_RAM_3B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_0.INIT_RAM_3C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_0.INIT_RAM_3D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_0.INIT_RAM_3E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_0.INIT_RAM_3F = 256'h0000000000000000000000000000000000000000000000000000000000000000;

SP sp_inst_1 (
    .DO({sp_inst_1_dout_w[30:0],sp_inst_1_dout[1]}),
    .CLK(clk),
    .OCE(oce),
    .CE(ce),
    .RESET(reset),
    .WRE(wre),
    .BLKSEL({gw_gnd,gw_gnd,ad[14]}),
    .AD(ad[13:0]),
    .DI({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,din[1]})
);

defparam sp_inst_1.READ_MODE = 1'b0;
defparam sp_inst_1.WRITE_MODE = 2'b00;
defparam sp_inst_1.BIT_WIDTH = 1;
defparam sp_inst_1.BLK_SEL = 3'b000;
defparam sp_inst_1.RESET_MODE = "SYNC";
defparam sp_inst_1.INIT_RAM_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_05 = 256'h00000000000000000000001F0000000000000000000000000000000000000007;
defparam sp_inst_1.INIT_RAM_06 = 256'h000003FF000000000000000000000000000000000000007F0000000000000000;
defparam sp_inst_1.INIT_RAM_07 = 256'h00000000000000000000000000001FFF00000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_08 = 256'h000000000001FFFF0000000000000000000000000000000000007FFF00000000;
defparam sp_inst_1.INIT_RAM_09 = 256'h000000000000000000000000000000000007FFFF000000000000000000000000;
defparam sp_inst_1.INIT_RAM_0A = 256'h000000000000000001FFFFFF00000000000000000000000000000000003FFFFF;
defparam sp_inst_1.INIT_RAM_0B = 256'h1FFFFFFF0000000000000000000000000000000007FFFFFF0000000000000000;
defparam sp_inst_1.INIT_RAM_0C = 256'h000000000000000000000000FFFFFFFF00000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_0D = 256'h0000001FFFFFFFFF00000000000000000000000000000003FFFFFFFF00000000;
defparam sp_inst_1.INIT_RAM_0E = 256'h0000000000000000000000000000007FFFFFFFFF000000000000000000000000;
defparam sp_inst_1.INIT_RAM_0F = 256'h0000000000000FFFFFFFFFFF000000000000000000000000000003FFFFFFFFFF;
defparam sp_inst_1.INIT_RAM_10 = 256'hFFFFFFFF00000000000000000000000000003FFFFFFFFFFF0000000000000000;
defparam sp_inst_1.INIT_RAM_11 = 256'h00000000000000000007FFFFFFFFFFFF0000000000000000000000000001FFFF;
defparam sp_inst_1.INIT_RAM_12 = 256'h007FFFFFFFFFFFFF000000000000000000000000001FFFFFFFFFFFFF00000000;
defparam sp_inst_1.INIT_RAM_13 = 256'h00000000000000000000000003FFFFFE0001FFFF000000000000000000000000;
defparam sp_inst_1.INIT_RAM_14 = 256'h000000007FFFFFFE0000FFFF0000000000000000000000000FFFFFFE0000FFFF;
defparam sp_inst_1.INIT_RAM_15 = 256'h0000FFFF000000000000000000000001FFFFFFFE0000FFFF0000000000000000;
defparam sp_inst_1.INIT_RAM_16 = 256'h000000000000001FFFFFFFFFFFE0FFFF00000000000000000000000FFFFFFFFE;
defparam sp_inst_1.INIT_RAM_17 = 256'hC01F061FFFE0FFFF0000000000000000000183FFFFFFFFFFFFE0FFFF00000000;
defparam sp_inst_1.INIT_RAM_18 = 256'h00000000000000000010041F000F001FFFE0FFFF000000000000000000000C1F;
defparam sp_inst_1.INIT_RAM_19 = 256'h0000001E0003001FA000FFFF00000000000000000000001F0007001FFFE0FFFF;
defparam sp_inst_1.INIT_RAM_1A = 256'h8000FFFF00000000000000000180701E0F83B01F8000FFFF0000000000000000;
defparam sp_inst_1.INIT_RAM_1B = 256'h0000000003E0F81E0FFFFC1F8000FFFF00000000000000000240F81E0FDFF81F;
defparam sp_inst_1.INIT_RAM_1C = 256'h001FFC1FFFE0FFFF000000000000000403E0FC1E00FFFC1F8000FFFF00000000;
defparam sp_inst_1.INIT_RAM_1D = 256'h000000000000000503E0FC1E0007FC1FFFE0FFFF000000000000000403E0FC1E;
defparam sp_inst_1.INIT_RAM_1E = 256'h83E0FC1E0F83FC1FFFC0FFFF000000000000000503E0FC1E0E03FC1FFFC0FFFF;
defparam sp_inst_1.INIT_RAM_1F = 256'hFFC0FFF8000000000000010783E0FC1E0FC3FC1FFFC0FFFE0000000000000107;
defparam sp_inst_1.INIT_RAM_20 = 256'h00000C0F83E0FC1E0783FC1FFFC0FFE0000000000000260783E0FC1E0FC1FC1F;
defparam sp_inst_1.INIT_RAM_21 = 256'h1007FC1FFFC0FC00000000000004001F83E0FC1E0003FC1FFFC0FF8000000000;
defparam sp_inst_1.INIT_RAM_22 = 256'h000000000003007F83E0FC1C180FFC1FFFC08000000000000000001F83E0FC1E;
defparam sp_inst_1.INIT_RAM_23 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFFFFFFFFFFFFFFFFFF;
defparam sp_inst_1.INIT_RAM_24 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_1.INIT_RAM_25 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_1.INIT_RAM_26 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_1.INIT_RAM_27 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_1.INIT_RAM_28 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_1.INIT_RAM_29 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_1.INIT_RAM_2A = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_1.INIT_RAM_2B = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_1.INIT_RAM_2C = 256'hFFFFF7FBFFFEFFDFFFFFFFFFF9F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_1.INIT_RAM_2D = 256'hF07C1C3FC01F0E1FFFE1FFFFFFFFF7E3FFFF7FBFEFBBE7BFBFEF76BFFFEDFFFF;
defparam sp_inst_1.INIT_RAM_2E = 256'hFFE1FFFFFFFFF003FFFFFFFFFFFFFFFFFFFFFFFFFFE1FFFFFFFFF0C3FFFFC0FF;
defparam sp_inst_1.INIT_RAM_2F = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFE1FFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_1.INIT_RAM_30 = 256'hFFFFFFFE0000FFFFFFFFF03FFFFFFFFFFFFFFFFFFFFFFFFE0001FFFFFFFFF01F;
defparam sp_inst_1.INIT_RAM_31 = 256'hFFFFF07FFFFFFFFFFFFFFFFFFFFFFFFE0000FFFFFFFFF07FFFFFFFFFFFFFFFFF;
defparam sp_inst_1.INIT_RAM_32 = 256'h0000000000000001FFFE0000FFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFE0000FFFF;
defparam sp_inst_1.INIT_RAM_33 = 256'h00000000000000000000000000000000000000000000000000000F4000000000;
defparam sp_inst_1.INIT_RAM_34 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_35 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_36 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_37 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_38 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_39 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_3A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_3B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_3C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_3D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_3E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_1.INIT_RAM_3F = 256'h0000000000000000000000000000000000000000000000000000000000000000;

SP sp_inst_2 (
    .DO({sp_inst_2_dout_w[30:0],sp_inst_2_dout[2]}),
    .CLK(clk),
    .OCE(oce),
    .CE(ce),
    .RESET(reset),
    .WRE(wre),
    .BLKSEL({gw_gnd,gw_gnd,ad[14]}),
    .AD(ad[13:0]),
    .DI({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,din[2]})
);

defparam sp_inst_2.READ_MODE = 1'b0;
defparam sp_inst_2.WRITE_MODE = 2'b00;
defparam sp_inst_2.BIT_WIDTH = 1;
defparam sp_inst_2.BLK_SEL = 3'b000;
defparam sp_inst_2.RESET_MODE = "SYNC";
defparam sp_inst_2.INIT_RAM_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_08 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_09 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_0A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_0B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_0C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_0D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_0E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_0F = 256'h0000000000000000000000030000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_10 = 256'h0000007F000000000000000000000000000000000000001F0000000000000000;
defparam sp_inst_2.INIT_RAM_11 = 256'h000000000000000000000000000003FF00000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_12 = 256'h0000000000003FFF0000000000000000000000000000000000000FFF00000000;
defparam sp_inst_2.INIT_RAM_13 = 256'h000000000000000000000000000000000000FFFF000000000000000000000000;
defparam sp_inst_2.INIT_RAM_14 = 256'h00000000000000000000FFFF000000000000000000000000000000000000FFFF;
defparam sp_inst_2.INIT_RAM_15 = 256'h0000FFFF000000000000000000000000000000000000FFFF0000000000000000;
defparam sp_inst_2.INIT_RAM_16 = 256'h0000000000000000000000001FE0FFFF00000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_17 = 256'h00000003FFE0FFFE000000000000000000000000000000007FE0FFFF00000000;
defparam sp_inst_2.INIT_RAM_18 = 256'h0000000000000000000000000000001FFFE0FFF8000000000000000000000000;
defparam sp_inst_2.INIT_RAM_19 = 256'h000000000000001FB000FF000000000000000000000000000000001FFFE0FFC0;
defparam sp_inst_2.INIT_RAM_1A = 256'h8000E0000000000000000000000000000000001F8000FC000000000000000000;
defparam sp_inst_2.INIT_RAM_1B = 256'h00000000000000000000FC1F800080000000000000000000000000000000581F;
defparam sp_inst_2.INIT_RAM_1C = 256'h000FFC1FFFC000000000000000000000000000000003FC1F8000000000000000;
defparam sp_inst_2.INIT_RAM_1D = 256'h0000000000000000000000000007FC1FFFC00000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_1E = 256'h000000000F83FC1FF80000000000000000000000000000000403FC1FFE000000;
defparam sp_inst_2.INIT_RAM_1F = 256'h000000000000000000000000000000000FC1FC1FC00000000000000000000000;
defparam sp_inst_2.INIT_RAM_20 = 256'h00000000000000060783FC1C000000000000000000000000000000020FC1FC1F;
defparam sp_inst_2.INIT_RAM_21 = 256'h1003FC100000000000000000000000000000001E0003FC100000000000000000;
defparam sp_inst_2.INIT_RAM_22 = 256'h00000000000000000000001C1807F4000000000000000000000000000000001E;
defparam sp_inst_2.INIT_RAM_23 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFFFFFFFFFFFFFF;
defparam sp_inst_2.INIT_RAM_24 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_2.INIT_RAM_25 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_2.INIT_RAM_26 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_2.INIT_RAM_27 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_2.INIT_RAM_28 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_2.INIT_RAM_29 = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_2.INIT_RAM_2A = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_2.INIT_RAM_2B = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_2.INIT_RAM_2C = 256'hFFFFF7FBFFFEFFDFFFFFFFFFF9F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_2.INIT_RAM_2D = 256'hF07C1C3FC01F0E1FFFE1FFFFFFFFF7E3FFFF7FBFEFBBE7BFBFEF76BFFFEDFFFF;
defparam sp_inst_2.INIT_RAM_2E = 256'hFFE1FFFFFFFFF003FFFFFFFFFFFFFFFFFFFFFFFFFFE1FFFFFFFFF0C3FFFFC0FF;
defparam sp_inst_2.INIT_RAM_2F = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFE1FFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFF;
defparam sp_inst_2.INIT_RAM_30 = 256'hFFFFFFFE0000FFFFFFFFF03FFFFFFFFFFFFFFFFFFFFFFFFE0001FFFFFFFFF01F;
defparam sp_inst_2.INIT_RAM_31 = 256'hFFFFF07FFFFFFFFFFFFFFFFFFFFFFFFE0000FFFFFFFFF07FFFFFFFFFFFFFFFFF;
defparam sp_inst_2.INIT_RAM_32 = 256'h0000000000000001FFFE0000FFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFE0000FFFF;
defparam sp_inst_2.INIT_RAM_33 = 256'h00000000000000000000000000000000000000000000000000000F4000000000;
defparam sp_inst_2.INIT_RAM_34 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_35 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_36 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_37 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_38 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_39 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_3A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_3B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_3C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_3D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_3E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_2.INIT_RAM_3F = 256'h0000000000000000000000000000000000000000000000000000000000000000;

SP sp_inst_3 (
    .DO({sp_inst_3_dout_w[28:0],sp_inst_3_dout[2:0]}),
    .CLK(clk),
    .OCE(oce),
    .CE(ce),
    .RESET(reset),
    .WRE(wre),
    .BLKSEL({ad[14],ad[13],ad[12]}),
    .AD({ad[11:0],gw_gnd,gw_gnd}),
    .DI({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,din[2:0]})
);

defparam sp_inst_3.READ_MODE = 1'b0;
defparam sp_inst_3.WRITE_MODE = 2'b00;
defparam sp_inst_3.BIT_WIDTH = 4;
defparam sp_inst_3.BLK_SEL = 3'b100;
defparam sp_inst_3.RESET_MODE = "SYNC";
defparam sp_inst_3.INIT_RAM_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_08 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_09 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_0A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_0B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_0C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_0D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_0E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_0F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_10 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_11 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_12 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_13 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_14 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_15 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_16 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_17 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_18 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_19 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_1A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_1B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_1C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_1D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_1E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_1F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_20 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_21 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_22 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_23 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_24 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_25 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_26 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_27 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_28 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_29 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_2A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sp_inst_3.INIT_RAM_2B = 256'h0000000000000000000000000000000000000000000000000000000000000000;

DFFE dff_inst_0 (
  .Q(dff_q_0),
  .D(ad[14]),
  .CLK(clk),
  .CE(ce_w)
);
MUX2 mux_inst_4 (
  .O(dout[0]),
  .I0(sp_inst_0_dout[0]),
  .I1(sp_inst_3_dout[0]),
  .S0(dff_q_0)
);
MUX2 mux_inst_9 (
  .O(dout[1]),
  .I0(sp_inst_1_dout[1]),
  .I1(sp_inst_3_dout[1]),
  .S0(dff_q_0)
);
MUX2 mux_inst_14 (
  .O(dout[2]),
  .I0(sp_inst_2_dout[2]),
  .I1(sp_inst_3_dout[2]),
  .S0(dff_q_0)
);
endmodule //Gowin_SP