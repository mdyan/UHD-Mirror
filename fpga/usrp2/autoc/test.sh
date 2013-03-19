iverilog -Wall -o test.vvp \
test.v test_tb.v
#-y ../models \
#-y ../control_lib \
vvp test.vvp
#gtkwave power_trig_my.vcd
