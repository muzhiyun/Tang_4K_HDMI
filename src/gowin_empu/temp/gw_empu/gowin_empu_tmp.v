//Copyright (C)2014-2022 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: GowinSynthesis V1.9.8.10
//Part Number: GW1NSR-LV4CQN48PC6/I5
//Device: GW1NSR-4C
//Created Time: Fri Mar 31 23:20:24 2023

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	Gowin_EMPU_Top your_instance_name(
		.sys_clk(sys_clk_i), //input sys_clk
		.gpio(gpio_io), //inout [15:0] gpio
		.uart0_rxd(uart0_rxd_i), //input uart0_rxd
		.uart0_txd(uart0_txd_o), //output uart0_txd
		.master_hclk(master_hclk_o), //output master_hclk
		.master_hrst(master_hrst_o), //output master_hrst
		.master_hsel(master_hsel_o), //output master_hsel
		.master_haddr(master_haddr_o), //output [31:0] master_haddr
		.master_htrans(master_htrans_o), //output [1:0] master_htrans
		.master_hwrite(master_hwrite_o), //output master_hwrite
		.master_hsize(master_hsize_o), //output [2:0] master_hsize
		.master_hburst(master_hburst_o), //output [2:0] master_hburst
		.master_hprot(master_hprot_o), //output [3:0] master_hprot
		.master_hmemattr(master_hmemattr_o), //output [1:0] master_hmemattr
		.master_hexreq(master_hexreq_o), //output master_hexreq
		.master_hmaster(master_hmaster_o), //output [3:0] master_hmaster
		.master_hwdata(master_hwdata_o), //output [31:0] master_hwdata
		.master_hmastlock(master_hmastlock_o), //output master_hmastlock
		.master_hreadymux(master_hreadymux_o), //output master_hreadymux
		.master_hauser(master_hauser_o), //output master_hauser
		.master_hwuser(master_hwuser_o), //output [3:0] master_hwuser
		.master_hrdata(master_hrdata_i), //input [31:0] master_hrdata
		.master_hreadyout(master_hreadyout_i), //input master_hreadyout
		.master_hresp(master_hresp_i), //input master_hresp
		.master_hexresp(master_hexresp_i), //input master_hexresp
		.master_hruser(master_hruser_i), //input [2:0] master_hruser
		.reset_n(reset_n_i) //input reset_n
	);

//--------Copy end-------------------
