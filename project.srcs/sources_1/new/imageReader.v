`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/26 12:21:00
// Design Name: 
// Module Name: imageReader
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


module imageReader(
    input reset,
    input clk,
    input pclk,
    input vsync,
    input href,
    input [7:0] din,
    output reg[11:0] dout,
    output valid
    );
    reg [15:0]d_latch;
    reg [1:0]wr_hold;
    assign valid = wr_hold[1]&& !pclk;
    always@ (posedge pclk or negedge reset)
    begin
        if(!reset)
        begin
            wr_hold <= 0;
            d_latch <= 0;
            dout <= 0;
        end
        else begin
            if(vsync == 1)
                begin
                    wr_hold <= {2{1'b0}};
                end
            else
                begin
                    dout <= {d_latch[15:12],d_latch[10:7],d_latch[4:1]};
                    wr_hold <= {wr_hold[0], (href && !wr_hold[0])};
                    d_latch <= {d_latch [7:0], din};
                end
        end
    end
endmodule
