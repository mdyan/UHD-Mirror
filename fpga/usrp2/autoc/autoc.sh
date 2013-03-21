iverilog -Wall -o autoc.vvp \
autoc_tb.v autoc.v \
-y . \
-y ../models && \
#-y ../control_lib \
vvp autoc.vvp
#gtkwave autoc.vcd
