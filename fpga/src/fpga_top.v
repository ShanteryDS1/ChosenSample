`timescale 1ns / 1ns

//
// File            : fpga_top.v
// Author          : 
// Date            : 05/23/2022
// Version         : 0.0
// Abstract        : 
//
// Modification History:
// Date        By       Version    Change Description
//
// ===========================================================
// 05/23/22    KOMORI   0.0        Original
// 
// ===========================================================

// CY7C68013A Slave FIFO
// PD7          FD[15]
// PD6          FD[14]
// PD5          FD[13]
// PD4          FD[12]
// PD3          FD[11]
// PD2          FD[10]
// PD1          FD[ 9]
// PD0          FD[ 8]
// PB7          FD[ 7]
// PB6          FD[ 6]
// PB5          FD[ 5]
// PB4          FD[ 4]
// PB3          FD[ 3]
// PB2          FD[ 2]
// PB1          FD[ 1]
// PB0          FD[ 0]
//
// RDY0         SLRD
// RDY1         SLWR
//
// CTL0         FLAGA
// CTL1         FLAGB
// CTL2         FLAGC
//
// PA0/INT0#    PA0/INT0#
// PA1/INT1#    PA1/INT1#
// PA2          SLOE
// PA3/WU2      PA3/WU2
// PA4          FIFOADR0
// PA5          FIFOADR1
// PA6          PKTEND
// PA7          PA7/FLAGD/SLCS#

module fpga_top (
  input            USB_CLKO,
  input            USB_RESET2,
  output reg       USB_IFCLK,
  inout            USB_WAKEUP,
  inout            USB_SCL,
  inout            USB_SDA,
  inout      [1:0] USB_RDY,
  inout      [2:0] USB_CTL,
  inout      [7:0] USB_PA,
  inout      [7:0] USB_PD, // Slave FIFO
  inout      [7:0] USB_PB, // Slave FIFO
  inout            JTAG_TDO,
  inout            JTAG_TDI,
  inout            JTAG_PROG,
  inout            JTAG_TRST,
  inout            JTAG_TMS,
  inout            JTAG_TCK,
  inout            JTAG_DONE,
  inout            JTAG_INIT,
  inout            SCLK,
  inout            DIN,
  inout            CS,
  inout            DOUT,
  output           CH0,
  output           CH1,
  output           CH2,
  output           CH3,
  inout            LPT_1,
  inout            LPT_2,
  inout            LPT_3,
  inout            LPT_4,
  inout            LPT_5,
  inout            LPT_6,
  inout            LPT_7,
  inout            LPT_8,
  inout            LPT_9,
  inout            LPT_10,
  inout            LPT_11,
  inout            LPT_12,
  inout            LPT_13,
  inout            LPT_14,
  inout            LPT_15,
  inout            LPT_16,
  input            DSW0,
  input            DSW1,
  input            DSW2,
  input            DSW3,
  input            SW1
);

reg [31:0] counter;

always @(posedge USB_CLKO) begin
  if (~USB_RESET2) begin
    USB_IFCLK <= 1'b0;
  end else begin
    USB_IFCLK <= ~USB_IFCLK;
  end
end

always @(posedge USB_IFCLK) begin
  if (~SW1) begin
    counter   <= 32'd0;
  end else begin
    counter   <= counter + 32'd1;
  end
end

assign USB_WAKEUP = 1'b1;
assign USB_SCL = 1'b1;
assign USB_SDA = 1'b1;
assign USB_RDY = 2'b00;
assign USB_CTL = 3'b000;
assign USB_PA = 8'h00;
assign USB_PB = counter[23:16]; // Slave FIFO
assign USB_PD = counter[31:24]; // Slave FIFO
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
assign JTAG_DONE = SW1;
assign JTAG_INIT = ~SW1;
assign CH0 = DSW0;
assign CH1 = DSW1;
assign CH2 = DSW2;
assign CH3 = DSW3;
assign LPT_16 = LPT_8;
assign LPT_15 = LPT_7;
assign LPT_14 = LPT_6;
assign LPT_13 = LPT_5;
assign LPT_12 = LPT_4;
assign LPT_11 = LPT_3;
assign LPT_10 = LPT_2;
assign LPT_9 = LPT_1;


endmodule