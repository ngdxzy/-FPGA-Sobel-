module SCCB_tb;
    reg clk;
    reg reset;
    wire SCL;
    wire SDA;
    wire finish;

    I2C_CCD_Config U( // Host Side
      clk,
      reset,
      //iExposure,
      // I2C Side
      SCL,
      SDA,
      finish );
      
    initial begin
        reset = 1;clk = 0;
        #10 reset = 0;
        #10 reset = 1;
        #20000 $finish;
    end
    always 
        #1 clk = !clk;
endmodule