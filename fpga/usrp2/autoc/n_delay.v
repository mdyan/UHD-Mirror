module n_delay
  #( parameter WIDTH=8, 
     parameter DELAY=8 )
   ( input clk, input enable,
     input wire [WIDTH-1:0] din, 
     output reg [WIDTH-1:0] dout,
     output reg outputting);
     
   reg [WIDTH-1:0] circ_buf [DELAY-1:0];   
   integer wr_ptr;
   
   wire [31:0] rd_ptr;
   initial wr_ptr <= 0;
   initial outputting <= 0;
   assign rd_ptr = (wr_ptr + 1) % DELAY;
   
   always @ (posedge clk)
     if(enable)
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
