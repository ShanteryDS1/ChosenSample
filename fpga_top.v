`timescale 1ns / 1ns

module fpga_top (
	input USB_CLKO,
	input USB_RESET2,
	output reg USB_IFCLK,
	inout USB_WAKEUP,
	inout USB_SCL,
	inout USB_SDA,
	inout [1:0] USB_RDY,
	inout [2:0] USB_CTL,
	inout [7:0] USB_PA,
	inout [7:0] USB_PD,
	inout [7:0] USB_PB,
  inout JTAG_TDO,
	inout JTAG_TDI,
	inout JTAG_PROG,
	inout JTAG_TRST,
	inout JTAG_TMS,
	inout JTAG_TCK,
	inout JTAG_DONE,
	inout JTAG_INIT,
	inout SCLK,
	inout DIN,
	inout CS,
	inout DOUT,
	output CH0,
	output CH1,
	output CH2,
	output CH3,
	inout LPT_1,
	inout LPT_2,
	inout LPT_3,
	inout LPT_4,
	inout LPT_5,
	inout LPT_6,
	inout LPT_7,
	inout LPT_8,
	inout LPT_9,
	inout LPT_10,
	inout LPT_11,
	inout LPT_12,
	inout LPT_13,
	inout LPT_14,
	inout LPT_15,
	inout LPT_16
);

always @(posedge USB_CLKO) begin
	if (USB_RESET2) begin
		USB_IFCLK <= 1'b0;
	end else begin
		USB_IFCLK <= USB_CLKO;
	end
end

assign USB_WAKEUP = 1'b1;
assign USB_SCL = 1'b1;
assign USB_SDA = 1'b1;
assign USB_RDY = 2'b00;
assign USB_CTL = 3'b000;
assign USB_PA = USB_PD;
assign USB_PB = USB_PD;
assign SCLK = USB_CLKO;
assign DIN = 1'b1;
assign CS = 1'b1;
assign DOUT = 1'b1;
assign JTAG_TDO = 1'b1;
assign JTAG_TDI = 1'b1;
assign JTAG_PROG = 1'b1;
assign JTAG_TRST = 1'b1;
assign JTAG_TMS = 1'b1;
assign JTAG_TCK = 1'b1;
assign JTAG_DONE = 1'b1;
assign JTAG_INIT = 1'b1;
assign CH0 = 1'b1;
assign CH1 = 1'b1;
assign CH2 = 1'b1;
assign CH3 = 1'b1;
assign LPT_16 = LPT_8;
assign LPT_15 = LPT_7;
assign LPT_14 = LPT_6;
assign LPT_13 = LPT_5;
assign LPT_12 = LPT_4;
assign LPT_11 = LPT_3;
assign LPT_10 = LPT_2;
assign LPT_9 = LPT_1;


endmodule