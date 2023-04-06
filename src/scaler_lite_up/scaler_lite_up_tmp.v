//Copyright (C)2014-2022 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: GowinSynthesis V1.9.8.10
//Part Number: GW1NSR-LV4CQN48PC6/I5
//Device: GW1NSR-4C
//Created Time: Thu Apr 06 23:36:22 2023

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	Scaler_Lite_Up_Top your_instance_name(
		.I_reset(I_reset_i), //input I_reset
		.I_sysclk(I_sysclk_i), //input I_sysclk
		.I_vin_ref_vs(I_vin_ref_vs_i), //input I_vin_ref_vs
		.I_vin_ref_de(I_vin_ref_de_i), //input I_vin_ref_de
		.O_vin_vs_req(O_vin_vs_req_o), //output O_vin_vs_req
		.O_vin_de_req(O_vin_de_req_o), //output O_vin_de_req
		.I_buf_fstline_rdy(I_buf_fstline_rdy_i), //input I_buf_fstline_rdy
		.I_vin_data0_cpl(I_vin_data0_cpl_i), //input [7:0] I_vin_data0_cpl
		.I_vin_data1_cpl(I_vin_data1_cpl_i), //input [7:0] I_vin_data1_cpl
		.I_vin_data2_cpl(I_vin_data2_cpl_i), //input [7:0] I_vin_data2_cpl
		.O_vout0_data(O_vout0_data_o), //output [7:0] O_vout0_data
		.O_vout1_data(O_vout1_data_o), //output [7:0] O_vout1_data
		.O_vout2_data(O_vout2_data_o), //output [7:0] O_vout2_data
		.O_vout_vs(O_vout_vs_o), //output O_vout_vs
		.O_vout_de(O_vout_de_o) //output O_vout_de
	);

//--------Copy end-------------------
