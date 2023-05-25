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
  inout            JTAG_TDO,  // 38 ( 2)
  inout            JTAG_TDI,  // 37 ( 3)
  inout            JTAG_PROG, // 32 ( 4)x
  inout            JTAG_TRST, // 31 ( 5)x
  inout            JTAG_TMS,  // 30 ( 6)
  inout            JTAG_TCK,  // 23 ( 8)
  inout            JTAG_DONE, // 22 ( 9)x
  inout            JTAG_INIT, // 21 (10)x
  inout            SCLK,
  inout            DIN,
  inout            CS,
  inout            DOUT,
  output           CH0,
  output           CH1,
  output           CH2,
  output           CH3,
  output           LPT_1,  // TCK-+- To Board
  input            LPT_2,  // TDO |
  output           LPT_3,  // TDI |
  output           LPT_4,  // TMS-+
  input            LPT_5,  // TCK-+- To Platform Cable
  output           LPT_6,  // TDO |
  input            LPT_7,  // TDI |
  input            LPT_8,  // TMS-+
  inout            LPT_9,  // 
  inout            LPT_10, // 
  inout            LPT_11, // 
  inout            LPT_12, // 
  inout            LPT_13, // 
  inout            LPT_14, // 
  inout            LPT_15, // 
  inout            LPT_16, // 
  input            DSW0, // (13)
  input            DSW1, // (12)
  input            DSW2, // (11)
  input            DSW3, // (10)
  input            SW1   // (81)
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
assign USB_SCL    = 1'b1;
assign USB_SDA    = 1'b1;
assign USB_RDY    = 2'b00;
assign USB_CTL    = 3'b000;
assign USB_PA     = 8'h00;
assign USB_PB     = counter[23:16]; // Slave FIFO
assign USB_PD     = counter[31:24]; // Slave FIFO
assign SCLK       = USB_CLKO;
assign DIN        = 1'b1;
assign CS         = 1'b1;
assign DOUT       = 1'b1;
assign JTAG_TDO   = LPT_2;
//assign JTAG_TDI = 1'b1;
//assign JTAG_PROG = 1'b1;
//assign JTAG_TRST = 1'b1;
//assign JTAG_TMS = 1'b1;
//assign JTAG_TCK = 1'b1;
//assign JTAG_DONE = SW1;
//assign JTAG_INIT = ~SW1;
assign CH0 = DSW0; // (1)
assign CH1 = DSW1; // (2)
assign CH2 = DSW2; // (3)
assign CH3 = DSW3; // (4)
assign LPT_1  = (DSW0) ? JTAG_TCK : LPT_5;  // ( 6) TCK
//assign LPT_2  = 1'b0; // ( 7) TDO
assign LPT_3  = (DSW0) ? JTAG_TDI : LPT_7; // ( 8) TDI
assign LPT_4  = (DSW0) ? JTAG_TMS : LPT_8; // ( 9) TMS
//assign LPT_5  = ; // (10) TCK
assign LPT_6  = LPT_2; // (11) TDO
//assign LPT_7  = ; // (12) TDI
//assign LPT_8  = ; // (13) TMS
// ---
assign LPT_9  = LPT_1; // (14)
assign LPT_10 = LPT_2; // (15)
assign LPT_11 = LPT_3; // (21)
assign LPT_12 = LPT_4; // (22)
//assign LPT_13 = ; // (23)
//assign LPT_14 = ; // (24)
//assign LPT_15 = ; // (25)
//assign LPT_16 = ; // (26)

endmodule