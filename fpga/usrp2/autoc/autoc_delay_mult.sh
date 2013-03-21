iverilog -Wall -o autoc_delay_mult.vvp \
autoc_delay_mult_tb.v autoc_delay_mult.v \
-y . \
-y ../models && \
#-y ../control_lib \
vvp autoc_delay_mult.vvp
#gtkwave autoc.vcd
