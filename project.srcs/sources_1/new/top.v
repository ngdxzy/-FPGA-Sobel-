`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/26 12:58:04
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk,
    input reset,
    input [7:0] din,
    output SCL,
    inout SDA,
    output XCLK,
    input vsync,
    input href,
    input PCLK,
    output valid,
    output [3:0] vga_red,
    output [3:0] vga_green,
    output [3:0] vga_blue,
    output vga_hsync,
    output vga_vsync,
    output reg[7:0]led
    );
    wire vgaclk;
    wire ramclk;
    clk_wiz_0 clk_generator
     (
      .XCLK(XCLK),
      .VGA_clk(vgaclk),
      .reset(!reset),
      .locked(),
      .ramclk(ramclk),
      .clk_in1(clk)
     );
     reg pclk;
     always @ (posedge clk)
     begin
        pclk <= PCLK;
     end
     wire [11:0]datapass;
    // wire valid; 
    reg [11:0]test;
     always @ (posedge XCLK)
        test <= test+1;
     imageReader ImageReader(
         .reset(reset),
         .clk(),
         .pclk(pclk),
         .vsync(0),
         .href(1),
         .din(test[11:4]),
         .dout(datapass),
         .valid(valid)
     );
    
        
     wire [18:0]vga_addr;
     wire [11:0]vga_data; 
     RAM_controller RAM(
         .reset(reset),
         .din(datapass),
         .clk(clk),
         .clkIn(valid),
         .addr(vga_addr),
         .dout(vga_data)
     );
     
     vga VGA(
     .clk(vgaclk),
     .reset(reset),
     .colour(vga_data),
     .addr(vga_addr),
     .vga_red(vga_red),
     .vga_green(vga_green),
     .vga_blue(vga_blue),
     .vga_hsync(vga_hsync),
     .vga_vsync(vga_vsync)
         );
     I2C_CCD_Config SCCB(
           .iCLK(clk),
           .iRST_N(reset),
           .I2C_SCLK(SCL),
           .I2C_SDAT(SDA),
           .cmos_finish()
       );
     always @ (posedge valid)
        led <= led+1;
endmodule
