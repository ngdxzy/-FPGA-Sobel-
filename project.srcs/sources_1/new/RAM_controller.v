`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/26 12:23:46
// Design Name: 
// Module Name: RAM_controller
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


module RAM_controller(
    input reset,
    input [11:0] din,
    input clk,
    input clkIn,
    input [18:0]addr,
    output [11:0] dout
    );
    reg [18:0]selfaddr;
    reg wea,clka;
    blk_mem_gen_0 blockRAM(
        .clka(clkIn),
        .wea(1), 
        .addra(selfaddr), 
        .dina(din),
        .clkb(clk),
        .addrb(addr), 
        .doutb(dout) 
    );
    always @ (posedge clkIn or negedge reset)
    begin
        if(!reset)
        begin
            selfaddr <= 0;
        end
        else
        begin
            if(selfaddr < 307200)
                selfaddr <= selfaddr + 1;
            else
                selfaddr <= 0;
        end
    end

endmodule
