
//AHB PSRAM
//Default is Burst 16 -> 4 word

module Gowin_AHB_PSRAM_Top
(
	//AHB bus IO
	output	wire	[31:0]			 AHB_HRDATA,
	output	wire					 AHB_HREADY,
	output	wire					 AHB_HRESP,
	input	wire	[1:0]  		     AHB_HTRANS,
	input	wire	[2:0]  	    	 AHB_HBURST,
	input	wire	[3:0]  		     AHB_HPROT,
	input	wire	[2:0]			 AHB_HSIZE,
	input	wire					 AHB_HWRITE,
	input	wire					 AHB_HMASTLOCK,
	input	wire	[3:0]			 AHB_HMASTER,
	input	wire	[31:0]			 AHB_HADDR,
	input	wire	[31:0]  		 AHB_HWDATA,
	input	wire					 AHB_HSEL,
	input	wire					 AHB_HCLK,
	input	wire					 AHB_HRESETn,
	//PSRAM user IO
    input   wire                     psram_base_clk,
    input   wire                     psram_memory_clk,
    output  wire                     led_init,
	//PSRAM phy IO
	output 	wire	[1:0]            O_psram_ck,
	output 	wire	[1:0]            O_psram_ck_n,
	output 	wire	[1:0]            O_psram_cs_n,
	output 	wire	[1:0]            O_psram_reset_n,
	inout  	wire	[15:0]           IO_psram_dq,
	inout   wire	[1:0]            IO_psram_rwds
);

//The AHB BUS is always ready
assign AHB_HREADY = 1'b1;

//Response OKAY
assign AHB_HRESP  = 1'b0;

//Define Reg for AHB BUS
reg [11:0]  ahb_address;
reg 		ahb_control;
reg         ahb_sel;
reg         ahb_htrans;

always @(posedge AHB_HCLK or negedge AHB_HRESETn)
begin
	if(~AHB_HRESETn)
	begin
		ahb_address  <= 12'b0;
		ahb_control  <= 1'b0;
        ahb_sel      <= 1'b0;
        ahb_htrans   <= 1'b0;
	end
	else              //Select The AHB Device 
	begin			  //Get the Address of reg
		ahb_address  <= AHB_HADDR[11:0];
		ahb_control  <= AHB_HWRITE;
        ahb_sel      <= AHB_HSEL;
        ahb_htrans   <= AHB_HTRANS[1];
	end
end

wire write_enable = ahb_htrans & ahb_control    & ahb_sel;
wire read_enable  = ahb_htrans & (!ahb_control) & ahb_sel;

//Write to AHB register
reg  		reg_cmd;
reg [20:0]  reg_address;
reg 		reg_cmd_en;
reg [31:0]  reg_data_in0,reg_data_in1,reg_data_in2,reg_data_in3;
reg 		reg_read_done;	
		
//write data to register	
always @(posedge AHB_HCLK or negedge AHB_HRESETn)
begin
	if(~AHB_HRESETn)
	begin
		reg_cmd  		<= 1'b0;
		reg_address		<= 21'b0;
		
		reg_data_in0	<= 32'b0;
		reg_data_in1	<= 32'b0;
		reg_data_in2	<= 32'b0;
		reg_data_in3	<= 32'b0;
	end
	else if(write_enable)
	begin
		case (ahb_address[11:2])
			10'h000: reg_cmd 		<= AHB_HWDATA[0];
			10'h001: reg_address	<= AHB_HWDATA[20:0];
			10'h002: reg_data_in0	<= AHB_HWDATA;
			10'h003: reg_data_in1	<= AHB_HWDATA;
			10'h004: reg_data_in2	<= AHB_HWDATA;
			10'h005: reg_data_in3	<= AHB_HWDATA;
            10'h006: reg_cmd_en     <= AHB_HWDATA[0];
			default: ;
		endcase
	end
end

//read data from psram
reg [31:0]  reg_data_out0,reg_data_out1,reg_data_out2,reg_data_out3;
reg [31:0]	ahb_rdata;

//read data from AHB
always @(*)
begin
	if(read_enable)
	begin
		case (ahb_address[11:2])
		10'h000: ahb_rdata = {31'h0,reg_cmd};
	    10'h001: ahb_rdata = {11'h0,reg_address};
        10'h002: ahb_rdata = reg_data_in0;
        10'h003: ahb_rdata = reg_data_in1;
        10'h004: ahb_rdata = reg_data_in2;
        10'h005: ahb_rdata = reg_data_in3;
		10'h006: ahb_rdata = {31'h0,reg_cmd_en};
		
		10'h007: ahb_rdata = {31'h0,reg_read_done};
		10'h008: ahb_rdata = reg_data_out0;
		10'h009: ahb_rdata = reg_data_out1;
		10'h00A: ahb_rdata = reg_data_out2;
		10'h00B: ahb_rdata = reg_data_out3;
        10'h00C: ahb_rdata = {31'b0,cross_wire_init2};
		default: ahb_rdata = 32'hFFFFFFFF;
		endcase
	end
	else
	begin
		ahb_rdata = 32'hFFFFFFFF;
	end
end
assign AHB_HRDATA = ahb_rdata;

wire wire_init;
//cross the clk domain -init sig
//user clk -> ahb clk
reg cross_wire_init1,cross_wire_init2;

always @(posedge AHB_HCLK or negedge AHB_HRESETn)
begin
    if(~AHB_HRESETn)
    begin
        cross_wire_init1  <= 1'b0;
        cross_wire_init2  <= 1'b0;
    end
    else
    begin
        cross_wire_init1  <= wire_init;
        cross_wire_init2  <= cross_wire_init1;
    end
end
//cross_wire_init2 will be read

//cross the reg_cmd ahb clk -> user clk
reg cross_reg_cmd1,cross_reg_cmd2;

always @(posedge user_clk or negedge AHB_HRESETn)
begin
    if(~AHB_HRESETn)
    begin
        cross_reg_cmd1  <= 1'b0;
        cross_reg_cmd2  <= 1'b0;
    end
    else
    begin
        cross_reg_cmd1  <= reg_cmd;
        cross_reg_cmd2  <= cross_reg_cmd1;
    end
end
//cross_reg_cmd2 will be use

//cross the reg_cmd_en ahb clk -> user clk
reg cross_reg_cmd_en1,cross_reg_cmd_en2;
wire raise_edge_reg_cmd_en;

always @(posedge user_clk or negedge AHB_HRESETn)
begin
    if(~AHB_HRESETn)
    begin
        cross_reg_cmd_en1  <= 1'b0;
        cross_reg_cmd_en2  <= 1'b0;
    end
    else
    begin
        cross_reg_cmd_en1  <= reg_cmd_en;
        cross_reg_cmd_en2  <= cross_reg_cmd_en1;
    end
end

assign raise_edge_reg_cmd_en = cross_reg_cmd_en1 &(!cross_reg_cmd_en2);

//the raise edge of the reg cmd enable
reg cmd_enable;

always @(posedge user_clk or negedge AHB_HRESETn)
begin
    if(~AHB_HRESETn)
    begin
        cmd_enable <= 1'b0;
    end
    else if(raise_edge_reg_cmd_en)
    begin
        cmd_enable <= 1'b1;
    end
    else
    begin
        cmd_enable <= 1'b0;
    end
end

//Send data to psram
//write data to psram
reg [ 1:0] data_sel;
reg [ 1:0] wr_state;

always @(posedge user_clk or negedge AHB_HRESETn)
begin
	if(~AHB_HRESETn)
	begin
		data_sel  <= 2'b00;
		wr_state  <= 2'b00;
	end
	else 
	begin//write cmd and vist the ahb bus and set the cmd enable function
		case (wr_state)
		2'b00:	
			  begin
				   if(cross_reg_cmd2 & cmd_enable)
				   begin
					   data_sel <= 2'b01;
					   wr_state <= wr_state + 1'b1;
				   end
			  end
		2'b01:
			  begin
					   data_sel <= 2'b10;
					   wr_state <= wr_state + 1'b1;
			  end
		2'b10:
			  begin
					   data_sel <= 2'b11;
					   wr_state <= wr_state + 1'b1;						
			  end
		2'b11:
			  begin
					   data_sel <= 2'b00;
					   wr_state <= wr_state + 1'b1;								
			  end
		endcase
	end
end

reg [31:0] psram_wrdata;

always @(*)
begin
	case (data_sel)
	2'b00:psram_wrdata = reg_data_in0;
	2'b01:psram_wrdata = reg_data_in1;
	2'b10:psram_wrdata = reg_data_in2;
	2'b11:psram_wrdata = reg_data_in3;
	endcase
end

//read data from psram
reg [ 2:0]  rd_state;
wire		rd_valid;
wire[31:0]  psram_data_out;

always @(posedge user_clk or negedge AHB_HRESETn)
begin
	if(~AHB_HRESETn)
	begin
		rd_state <= 3'b000;
	end
	else
	begin
		case (rd_state)
        3'd0:
            begin
                if(~cross_reg_cmd2 & cmd_enable)
                begin
                    rd_state	  <= rd_state + 1'b1;
                end
            end
		3'd1:
			 begin
				if(rd_valid)
				begin
					reg_data_out0 <= psram_data_out;
					rd_state	  <= rd_state + 1'b1;
				end
			 end
		3'd2:
			 begin
					reg_data_out1 <= psram_data_out;
					rd_state	  <= rd_state + 1'b1;
			 end
		3'd3:
			 begin
					reg_data_out2 <= psram_data_out;
					rd_state	  <= rd_state + 1'b1;
			 end
		3'd4:
			 begin
					reg_data_out3 <= psram_data_out;
					rd_state	  <= 3'd0;
			 end
		endcase
	end
end

//cross the rd valid user clk -> ahb clk
reg cross_rd_valid1,cross_rd_valid2;

always @(posedge AHB_HCLK or negedge AHB_HRESETn)
begin
    if(~AHB_HRESETn)
    begin
        cross_rd_valid1  <= 1'b0;
        cross_rd_valid2  <= 1'b0;
    end
    else
    begin
        cross_rd_valid1  <= rd_valid;
        cross_rd_valid2  <= cross_rd_valid1;
    end
end

//get the fall edge of rd valid
reg fall_edge_rd_valid1,fall_edge_rd_valid2;

always @(posedge AHB_HCLK or negedge AHB_HRESETn)
begin
	if(~AHB_HRESETn)
	begin
		fall_edge_rd_valid1  <= 1'b0;
		fall_edge_rd_valid2  <= 1'b0;
	end
	else
	begin
		fall_edge_rd_valid1  <= cross_rd_valid2;
		fall_edge_rd_valid2  <= fall_edge_rd_valid1; 
	end
end

wire fall_edge_rd_valid = ~fall_edge_rd_valid1 & fall_edge_rd_valid2;

always @(posedge AHB_HCLK or negedge AHB_HRESETn)
begin
    if(~AHB_HRESETn)
    begin
       	reg_read_done  <= 1'b0;
    end
	else if(write_enable &(ahb_address[11:2] == 10'h007))
	begin
		reg_read_done  <=  AHB_HWDATA[0];
	end
	else if(fall_edge_rd_valid )
	begin
		reg_read_done  <=  1'b1;
	end
end

PSRAM_Memory_Interface_HS_Top u_PSRAM_Memory_Interface_Top(
    .clk			(psram_base_clk         ),
    .memory_clk		(psram_memory_clk       ),
    .rst_n			(AHB_HRESETn            ),
    .pll_lock		(1'b1   	            ),
     //phy IO                             
    .O_psram_ck		(O_psram_ck             ),
    .O_psram_ck_n	(O_psram_ck_n           ),
    .IO_psram_dq	(IO_psram_dq            ),
    .IO_psram_rwds	(IO_psram_rwds          ),
    .O_psram_cs_n	(O_psram_cs_n           ),
    .O_psram_reset_n(O_psram_reset_n        ),
    //user IO
    .init_calib		(wire_init		        ),
    .wr_data		(psram_wrdata           ),
    .rd_data		(psram_data_out         ),
    .rd_data_valid	(rd_valid		        ),
    .addr			(reg_address		    ),
    .cmd			(cross_reg_cmd2	        ),
    .cmd_en			(cmd_enable         	),	 
    .clk_out		(user_clk   		    ),
    .data_mask		(8'b0000                )	
);

assign led_init = !wire_init;

endmodule