`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2014/05/23 15:48:40
// Design Name: 
// Module Name: vga
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


module vga(
input clk,
input reset,
input [11:0]colour,
output [18:0]addr,
output reg[3:0] vga_red,
output reg[3:0] vga_green,
output reg[3:0] vga_blue,
output reg vga_hsync,
output reg vga_vsync
    );
    ///Timing constants
          parameter hRez   = 640;
          parameter hStartSync   = 640+16;
          parameter hEndSync     = 640+16+96;
          parameter hMaxCount    = 800;
        
          parameter vRez         = 480;
          parameter vStartSync   = 480+10;
          parameter vEndSync     = 480+10+2;
          parameter vMaxCount    = 480+10+2+33;
        
        parameter hsync_active   =0;
        parameter vsync_active  = 0;
        reg[9:0] hCounter;
        reg[9:0] vCounter;    
        reg blank;
        assign addr = vCounter*640 + hCounter;
       initial   hCounter = 10'b0;
       initial   vCounter = 10'b0;  
       initial   blank = 1'b1;    
     
        
   
       always@(posedge clk or negedge reset)begin
            if(!reset)begin
                hCounter <= 0;
                vCounter <= 0;
                vga_red   <= 0;
               vga_green <= 0;
               vga_blue  <= 0;
               blank <= 0;
            end
            else begin
                if( hCounter == hMaxCount-1 )begin
                    hCounter <=  10'b0;
                    if (vCounter == vMaxCount-1 )
                        vCounter <=  10'b0;
                    else begin
                        vCounter <= vCounter+1;
                       // addr <= addr + 1;
                    end
                end
                else begin
                    hCounter <= hCounter+1;
                end
       
                   if (blank ==0) begin
                       vga_red   <= colour[11:8];
                       vga_green <= colour[7:4];
                       vga_blue  <= colour[3:0];
                       end
                   else begin
                       vga_red   <= 4'b0;
                       vga_green <= 4'b0;
                       vga_blue  <= 4'b0;
                        end;
           
                   if(  vCounter  >= 480 || vCounter  < 0) begin
                       blank <= 1;
                       end
                   else begin
                       if ( hCounter  < 640 && hCounter  >= 0) begin
                           blank <= 0;
                           end
                       else
                           blank <= 1;
                       end;
           
                   // Are we in the hSync pulse? (one has been added to include frame_buffer_latency)
                   if( hCounter > hStartSync && hCounter <= hEndSync)
                       vga_hsync <= hsync_active;
                   else
                       vga_hsync <= ~ hsync_active;
                   
       
                   // Are we in the vSync pulse?
                   if( vCounter >= vStartSync && vCounter < vEndSync )
                       vga_vsync <= vsync_active;
                   else
                       vga_vsync <= ~ vsync_active;
               end
        end 
endmodule
