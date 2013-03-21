module autoc
  #(     //frontend bus width
    parameter WIDTH = 24,
    parameter DELAY = 32
  )
//     parameter DELAY=8 )
  (
    input clk, 
  
    //strobed samples {I16,Q16} from the RX DDC chain
    output ddc_out_enable, //enables DDC module
    input [31:0] ddc_out_sample,
    input ddc_out_strobe, //high on valid sample
    
    output [42:0] si, 
    output [42:0] sq,
    output reg outputting // output is valid..
  );
  
  function [17:0] pad;
    input [15:0] n;
    begin
      // sign extend and pad
      pad = {n[15], n, 1'b0};
    end
  endfunction
    
  
  parameter DDC_SAMPLE_WIDTH = 32; // 32 bit input from ddc...
  
  wire [35:0] ii_mult_out;
  wire [35:0] iq_mult_out;
  wire [35:0] qi_mult_out;
  wire [35:0] qq_mult_out;
  
  //reg stb_d1, stb_d2;
  //always @(posedge clk) stb_d1 <= ddc_out_strobe;
  //always @(posedge clk) stb_d2 <= stb_d1;
  
  wire [15:0] i_curr = ddc_out_sample[31:16];
  wire [15:0] q_curr = ddc_out_sample[15:0];
  
  wire [15:0] i_delayed;
  wire [15:0] q_delayed;
  
  autoc_delay_mult #( .WIDTH(16), .DELAY(32) ) mult_delay_ii
    (.clk(clk), .sample_in(i_curr), .delay_mult_out();
     ( .clk(clk), .din(i_curr), .dout(i_delayed), .outputting(delay_line_output));
  n_delay #( .WIDTH(16), .DELAY(32) ) q_delay
     ( .clk(clk), .din(i_curr), .dout(i_delayed), .outputting()); // we have an out already!
  
  MULT18X18S ii_mult(.P(ii_mult_out), .A(pad(i_delayed)), .B(pad(i_curr)), .C(clk), .CE(1), .R(0));
  
endmodule
