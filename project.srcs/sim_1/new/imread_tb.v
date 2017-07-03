module imr_tb;
    reg pclk,reset,vsync,href;
    reg [7:0]din;
    wire valid;
    wire [11:0]dout;
    imageReader U(
    reset,
    clk,
    pclk,
    vsync,
    href,
    din,
    dout,
    valid
    );
	integer i,j;
	initial begin
		din = 0;pclk = 0;reset = 1;
		vsync = 0;href = 0;din = 0;
		#10 reset = 0;
		#10 reset = 1;
		for(i = 0;i < 3;i= i+ 1)
		begin
		#5 vsync = 1;
		#5 vsync = 0;
		#5 href = 1;
			for(j = 0;j<10;j= j+ 1)
			begin
				#5 pclk = 1;
				#5 pclk = 0;
				din = din + 1;
			end
		end
		$finish;
	end
	
endmodule