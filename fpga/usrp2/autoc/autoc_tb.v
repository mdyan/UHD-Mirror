module autoc_tb();
   initial $dumpfile("autoc.vcd");
   initial $dumpvars(0,autoc);

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
