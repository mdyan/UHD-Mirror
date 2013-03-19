module test (
  input clk,
  input wire [3:0] in,
  output reg [3:0] out
);

  always @(posedge clk)
    out <= in;
    
endmodule
