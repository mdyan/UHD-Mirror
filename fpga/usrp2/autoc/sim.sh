iverilog -Wall -o power_trig_my.vvp \
../models/MULT18X18S.v \
../control_lib/setting_reg.v \
../control_lib/ram_2port.v \
power_trig_my.v power_trig_my_tb.v
#-y ../models \
#-y ../control_lib \
vvp power_trig_my.vvp
#gtkwave power_trig_my.vcd
