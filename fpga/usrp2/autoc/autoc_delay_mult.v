module autoc_delay_mult
  #(
    parameter WIDTH=16,
    parameter DELAY=32  
  )
  (
    input clk, input enable, 
    input [WIDTH-1:0] sample_in,
    input [WIDTH-1:0] sample_in_delay,
    output [(WIDTH*2)-1:0] delay_mult_out,
    output strobe
  );
  
  function [17:0] pad;
    input [15:0] n;
    begin
      pad = {n[15], n, 1'b0};
    end
  endfunction
  
  wire delay_line_enabled;
  wire [WIDTH-1:0] delayed_sample;
  wire [35:0] mult_out;
  reg mult_strobe;
  
  n_delay #( .WIDTH(WIDTH), .DELAY(DELAY) ) delay
    ( .clk(clk), .enable(enable), .din(sample_in_delay), .dout(delayed_sample), .outputting(delay_line_enabled));
    
  MULT18X18S ii_mult(.P(mult_out), .A(pad(delayed_sample)), .B(pad(sample_in)),
    .C(clk), .CE(delay_line_enabled), .R(1'b0));
    
  always @(posedge clk)
    mult_strobe <= delay_line_enabled;
    
  assign delay_mult_out = mult_out [35:4];
  assign strobe = mult_strobe;
   
  
endmodule
