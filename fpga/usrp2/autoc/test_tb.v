
module test_tb();
  initial $dumpfile("test.vcd");
  initial $dumpvars(0,t);

  reg clk = 0;
  reg [3:0] data = 4'b0;
  always 
    begin
      #10 clk <= ~clk;
    end
   
    test t(.clk(clk), .in(data), .out());
   
  always @ (posedge clk)
    data <= data + 1;
  initial
    #100000 $finish;
endmodule
