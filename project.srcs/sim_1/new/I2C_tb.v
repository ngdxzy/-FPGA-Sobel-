module I2C_tb;
    reg clk;
    reg reset;
    wire SCL;
    wire SDA;
    wire finish;
    reg [23:0]D = 24'b10100101_00111100_10101011;
    reg start;
    wire ack;
    wire ends;
I2C_Controller U(
	clk,
	SCL,//I2C CLOCK
 	SDA,//I2C DATA
	D,//DATA:[SLAVE_ADDR,SUB_ADDR,DATA]
	start,      //GO transfor
	ends,     //END transfor 

	ack,      //ACK
	reset
);
    initial begin
        reset = 1;clk = 0;start = 0;
        #10 reset = 0;
        #10 reset = 1;
        #10 start = 1;
        #10 start = 1;
        #200 $finish;
    end
    always 
    #1 clk = !clk;
endmodule