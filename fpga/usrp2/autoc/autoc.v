module autoc
  #(     //frontend bus width
    parameter WIDTH = 24,
    parameter DELAY = 32
  )
//     parameter DELAY=8 )
  (
    input clk, enable, 
  
    //strobed samples {I16,Q16} from the RX DDC chain
    output ddc_out_enable, //enables DDC module
    input [31:0] ddc_out_sample,
    input ddc_out_strobe, //high on valid sample
    
    output [42:0] si, 
    output [42:0] sq,
    output wire outputting // output is valid..
  );
  
  function [17:0] pad;
    input [15:0] n;
    begin
      // sign extend and pad
      pad = {n[15], n, 1'b0};
    end
  endfunction
    
  
  parameter DDC_SAMPLE_WIDTH = 32; // 32 bit input from ddc...
  
  wire [31:0] ii_mult_out;
  wire [31:0] qq_mult_out;
  wire [31:0] iq_mult_out;
  wire [31:0] qi_mult_out;
  
  //reg stb_d1, stb_d2;
  //always @(posedge clk) stb_d1 <= ddc_out_strobe;
  //always @(posedge clk) stb_d2 <= stb_d1;
  
  wire [15:0] i_curr = ddc_out_sample[31:16];
  wire [15:0] q_curr = ddc_out_sample[15:0];
  wire s1,s2,s3,s4;
  wire go;
  assign go = s1&s2&s3&s4;
  
  ////~ wire [15:0] i_delayed;
  ////~ wire [15:0] q_delayed;
  
  autoc_delay_mult #( .WIDTH(16), .DELAY(32) ) mult_delay_ii
    (.clk(clk), .enable(enable), .sample_in(i_curr), .sample_in_delay(i_curr), .delay_mult_out(ii_mult_out), .strobe(s1));
  autoc_delay_mult #( .WIDTH(16), .DELAY(32) ) mult_delay_qq
    (.clk(clk), .enable(enable), .sample_in(q_curr), .sample_in_delay(q_curr), .delay_mult_out(qq_mult_out), .strobe(s2));
  autoc_delay_mult #( .WIDTH(16), .DELAY(32) ) mult_delay_iq
    (.clk(clk), .enable(enable), .sample_in(i_curr), .sample_in_delay(q_curr), .delay_mult_out(iq_mult_out), .strobe(s3));
  autoc_delay_mult #( .WIDTH(16), .DELAY(32) ) mult_delay_qi
    (.clk(clk), .enable(enable), .sample_in(q_curr), .sample_in_delay(i_curr), .delay_mult_out(qi_mult_out), .strobe(s4));
    
  reg [31:0] add;
  reg [31:0] sub;
    
  always @(posedge clk)
    if(go)
      begin
        add <= ii_mult_out + qq_mult_out;
        sub <= qi_mult_out - iq_mult_out;
      end
  
  wire [31:0] add_delay;
  wire [31:0] sub_delay;
  wire delay1,delay2,go2;
  assign go2 = delay1&delay2;
  
  n_delay #( .WIDTH(32), .DELAY(32) ) delay_line_1
    ( .clk(clk), .enable(go), .din(add), .dout(add_delay), .outputting(delay1));
    
  n_delay #( .WIDTH(32), .DELAY(32) ) delay_line_2
    ( .clk(clk), .enable(go), .din(sub), .dout(sub_delay), .outputting(delay2));
    
  reg [31:0] add2;
  reg [31:0] sub2;
  
  // fix later.. this code sucks
  reg load_acc;
  reg tmp;
  reg tmp2;
  initial load_acc = 1;
  initial tmp = 1;  
  initial tmp2 = 1;
  always @(posedge clk)
    if(go2)
      begin
        add2 <= add - add_delay;
        sub2 <= sub - sub_delay;
        tmp <= 0;
        tmp2 <= tmp;
        load_acc <= tmp2;
      end
      
  
  // ACCUMULATORS
  acc #(.IWIDTH(32), .OWIDTH(43)) acc_a
    (.clk(clk), .clear(load_acc), .acc(1'b1), .in(add2), .out(si));
    
  assign outputting = ~load_acc;
  
  acc #(.IWIDTH(32), .OWIDTH(43)) acc_b
    (.clk(clk), .clear(load_acc), .acc(1'b1), .in(sub2), .out(sq));
endmodule
