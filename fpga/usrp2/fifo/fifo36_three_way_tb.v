module fifo36_three_way_tb();
   initial $dumpfile("fifo36_three_way.vcd");
   initial $dumpvars(0, fifo36_three_way_tb);

   reg clk = 0;
   always #10 clk <= ~clk;
   
   reg [17:0] in;
   
//   initial in <= 18'b0;
   reg [35:0] fake1;
   reg [35:0] fake2;
   reg [35:0] fake3;
   wire [35:0] out;
   reg c;
   
   
   initial fake1 <= 36'hF9001BEEF;
   initial fake2 <= 36'hF1234BEEF;
   initial fake3 <= 36'hF1337BEEF;
   initial 
     begin
       c <= 1;
       #20
       c <= 0;
     end
       
   
  fifo36_three_way #(.prio(1'b0)) three_way (
    .clk(clk), .reset(c), .clear(c),
    .data0_i(fake1), .src0_rdy_i(1'b1), .dst0_rdy_o(),
    .data1_i(fake2), .src1_rdy_i(1'b1), .dst1_rdy_o(),
    .data2_i(fake3), .src2_rdy_i(1'b1), .dst2_rdy_o(),
    .data_o(out), .src_rdy_o(), .dst_rdy_i(1'b1)
    );
  
  always @(posedge clk)
    begin
       fake1 <= fake1 + 32'h00000001;
       fake2 <= fake2 + 32'h00000001;
       fake3 <= fake3 + 32'h00000001;
    end
      
  initial
    #100000 $finish;
endmodule
