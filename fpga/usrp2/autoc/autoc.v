module autoc
  #(     //frontend bus width
    parameter WIDTH = 24  // not sure if i need this
  )
//     parameter DELAY=8 )
  (
    input clk, 
    input wire [WIDTH-1:0] din, 
    output reg [WIDTH-1:0] dout,
  
    //strobed samples {I16,Q16} from the RX DDC chain
    output ddc_out_enable, //enables DDC module
    input [31:0] ddc_out_sample,
    input ddc_out_strobe, //high on valid sample
    
    // SOME OUTPUT thing
    
    output [42:0] si, 
    output [42:0] sq     
    output reg outputting // output is valid..
  );
  
  parameter DDC_SAMPLE_WIDTH = 32; // 32 bit input from ddc...
  
  wire ii_mult_out;
  MULT18X18S(.P(
     
   reg [WIDTH-1:0] circ_buf [DELAY-1:0];   
   integer wr_ptr;
   
   wire [31:0] rd_ptr;
   initial wr_ptr <= 0;
   initial outputting <= 0;
   assign rd_ptr = (wr_ptr + 1) % DELAY;
   
   always @ (posedge clk)
     begin
       circ_buf[wr_ptr] <= din;
       dout <= circ_buf[rd_ptr];
       wr_ptr <= (wr_ptr + 1) % DELAY;
       if (rd_ptr == 0)
         outputting <= 1;
     end
   
   integer k;
   initial
     begin
       for(k = 0; k < DELAY-1; k=k+1)
         begin
           circ_buf [k] = 0;
         end
     end
     

endmodule
