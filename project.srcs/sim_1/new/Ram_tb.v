`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/26 19:22:07
// Design Name: 
// Module Name: Ram_tb
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


module Ram_tb();
reg clk;
reg [11:0]din;
reg clkIn;
reg [18:0]addr;
wire 
RAM_controller U(
    input reset,
    input [11:0] din,
    input clk,
    input clkIn,
    input [18:0]addr,
    output [11:0] dout
    );
endmodule
