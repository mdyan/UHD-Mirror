module n_delay_tb();
   initial $dumpfile("n_delay.vcd");
   initial $dumpvars(0,n_delay_tb);

   reg clk = 0;
   always #10 clk <= ~clk;
   
   reg [17:0] in;
   
   initial in <= 18'b0;
  
  n_delay #( .WIDTH(18), .DELAY(4) ) nb
   ( .clk(clk), 
     .din(in), 
     .dout() );
     
  always @(posedge clk)
       in <= in + 2;
       
  initial
    #100000 $finish;
endmodule
