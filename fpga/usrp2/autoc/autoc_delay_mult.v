module autoc_delay_mult
  #(
    parameter WIDTH=16,
    parameter DELAY=32  
  )
  (
    input clk,
    input [WIDTH-1:0] sample_in,
    output [(WIDTH*2):2] delay_mult_out,
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
  
  n_delay #( .WIDTH(WIDTH), .DELAY(DELAY) ) delay
    ( .clk(clk), .din(sample_in), .dout(delayed_sample), .outputting(delay_line_enabled));
    
  MULT18X18S ii_mult(.P(mult_out), .A(pad(delayed_sample)), .B(pad(sample_in)),
    .C(clk), .CE(delay_line_enabled), .R(0));
    
  assign delay_mult_out = mult_out [35:2];
  assign strobe = delay_line_enabled;
  
  
  
endmodule
