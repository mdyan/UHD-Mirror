module autoc_delay_mult_tb();
   initial $dumpfile("autoc_delay_mult.vcd");
   initial $dumpvars(0, autoc_delay_mult_tb);

   reg clk = 0;
   always #10 clk <= ~clk;
   
   reg [15:0] fake_data;
   
   initial fake_data <= 16'h1337;
  
  autoc_delay_mult #(.WIDTH(16),.DELAY(32)) ac
  ( .clk(clk), .sample_in(fake_data), .delay_mult_out());
  
  always @(posedge clk)
    fake_data <= fake_data + 16'h0101;
       
  initial
    #100000 $finish;
endmodule
