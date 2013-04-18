iverilog -Wall -o fifo36_three_way.vvp \
fifo36_three_way_tb.v fifo36_three_way.v \
-y ../models \
-y . && \
#-y ../fifo \
#-y ../sdr_lib && \
#-y ../control_lib \

vvp fifo36_three_way.vvp #&&
#gtkwave fifo36_three_way.vcd
