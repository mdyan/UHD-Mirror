iverilog -Wall -o n_delay.vvp \
n_delay_tb.v n_delay.v && \
-y ../models \
#-y ../control_lib \
vvp n_delay.vvp
#gtkwave power_trig_my.vcd
