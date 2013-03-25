module autoc_tb();
   initial $dumpfile("autoc.vcd");
   initial $dumpvars(0, autoc_tb);

   reg clk = 0;
   always #10 clk <= ~clk;
   
   reg [17:0] in;
   
//   initial in <= 18'b0;
   reg [31:0] fake_data;
   
   initial fake_data <= 32'h1024BEEF;
  
  autoc #(.WIDTH(24),.DELAY(32)) autocorrelate
  ( .clk(clk), .ddc_out_enable(), .ddc_out_sample(fake_data), 
    .ddc_out_strobe(1), .enable(1), .si(), .sq(), .outputting()
  );
  
  always @(posedge clk)
       fake_data <= fake_data + 32'h00010002;
       
  initial
    #100000 $finish;
endmodule
